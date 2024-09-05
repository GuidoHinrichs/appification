import 'package:flutter/material.dart';
import 'package:guidohinrichs/stop_smoking/smoking_data.dart';
import 'database_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Option3Page extends StatefulWidget {
  const Option3Page({super.key});

  @override
  _Option3PageState createState() => _Option3PageState();
}

class _Option3PageState extends State<Option3Page> {
  final List<Map<String, dynamic>> _results = [];
  bool _isCalculating = true;
  late int initialCigarettes;

  @override
  void initState() {
    super.initState();
    _startOption1Algorithm();
  }

  int calculateNewCigaretteCount(int currentCigarettes, double reductionFactor,
      int totalToReduce, int diff) {
    double reduction = (currentCigarettes / reductionFactor) * totalToReduce;
    int roundedReduction = reduction.floor();

    if (diff > 0 && reduction > roundedReduction) {
      roundedReduction++;
      diff--;
    }
    return currentCigarettes - roundedReduction;
  }

  void _startOption1Algorithm() async {
    SmokingData? smokingData = await DatabaseHelper.instance.getSmokingData();

    if (smokingData == null) {
      if (!mounted) return;
      setState(() {
        _isCalculating = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fehler beim Laden der Daten.')),
        );
      }
      return;
    }

    initialCigarettes = smokingData.selectedCigarettes;
    int totalCigarettes = initialCigarettes;
    int morningCigarettes = smokingData.morningCigarettes;
    int afternoonCigarettes = smokingData.afternoonCigarettes;
    int eveningCigarettes = smokingData.eveningCigarettes;
    String method = 'Option 3: 4 % weniger jeden Tag';

    for (int day = 0; day < 51; day++) {
      int cigarettesToReduce = (totalCigarettes * 0.04).round();
      if (cigarettesToReduce < 1) cigarettesToReduce = 1;

      int diff = cigarettesToReduce;
      int newMorningCigarettes = calculateNewCigaretteCount(morningCigarettes,
          totalCigarettes.toDouble(), cigarettesToReduce, diff);
      diff -= (morningCigarettes - newMorningCigarettes);

      int newAfternoonCigarettes = calculateNewCigaretteCount(
          afternoonCigarettes,
          totalCigarettes.toDouble(),
          cigarettesToReduce,
          diff);
      diff -= (afternoonCigarettes - newAfternoonCigarettes);

      int newEveningCigarettes = calculateNewCigaretteCount(eveningCigarettes,
          totalCigarettes.toDouble(), cigarettesToReduce, diff);

      totalCigarettes =
          newMorningCigarettes + newAfternoonCigarettes + newEveningCigarettes;

      if (totalCigarettes <= 0) {
        totalCigarettes = 0;
        newMorningCigarettes = 0;
        newAfternoonCigarettes = 0;
        newEveningCigarettes = 0;
      }

      setState(() {
        _results.add({
          'day': day + 1,
          'morning': newMorningCigarettes,
          'afternoon': newAfternoonCigarettes,
          'evening': newEveningCigarettes,
        });
      });

      await DatabaseHelper.instance.insertProgressData({
        'date': DateTime.now().add(Duration(days: day)).toString(),
        'cigarettes_remaining': totalCigarettes,
        'method': method,
      });

      if (totalCigarettes == 0) break;

      morningCigarettes = newMorningCigarettes;
      afternoonCigarettes = newAfternoonCigarettes;
      eveningCigarettes = newEveningCigarettes;
    }

    setState(() {
      _isCalculating = false;
    });
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                  'Du rauchst $initialCigarettes Zigaretten täglich. Hier ist dein Plan, dies langsam abbauend zu beenden:'),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Tag', 'Morgens', 'Tagsüber', 'Abends', 'Total'],
                data: _results.map((result) {
                  return [
                    result['day'].toString(),
                    result['morning'].toString(),
                    result['afternoon'].toString(),
                    result['evening'].toString(),
                  ];
                }).toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Geschafft, Du bist Nichtraucher!'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      return pdf.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Langsam abbauend')),
      body: _isCalculating
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Du rauchst $initialCigarettes Zigaretten täglich. Hier ist dein Plan, dies langsam abbauend zu beenden:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Tag')),
                            DataColumn(label: Text('Morgens')),
                            DataColumn(label: Text('Tagsüber')),
                            DataColumn(label: Text('Abends')),
                          ],
                          rows: _results.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> result = entry.value;

                            return DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (index % 2 == 0) {
                                  return Colors.grey.withOpacity(0.2);
                                }
                                return null;
                              }),
                              cells: [
                                DataCell(Text(result['day'].toString())),
                                DataCell(Text(result['morning'].toString())),
                                DataCell(Text(result['afternoon'].toString())),
                                DataCell(Text(result['evening'].toString())),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Geschafft, Du bist Nichtraucher!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
