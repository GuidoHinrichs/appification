import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KurzprofilScreen extends StatelessWidget {
  const KurzprofilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Milestones', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(
          color: isDarkMode
              ? Colors.black
              : Colors.black, // Icons color für light und dark mode
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/images/gh.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 300.0),
                _buildSectionWithOpacity(
                  'KERNKOMPETENZEN',
                  _buildCompetenceList([
                    'App-Entwicklung für Android- und iOS-Devices',
                    'Konzeption und Visualisierung von Onlineshops',
                    'Entwicklung von Offline-Marketingkonzepten',
                    'Generierung von Online-Marketingstrategien',
                    'Projekt- und Budgetplanung',
                    'Informations- und Medienkompetenz'
                  ]),
                ),
                const Divider(),
                _buildSectionWithOpacity(
                  'Coding & Computing',
                  _buildProgressGridList([
                    {'text': 'Dart', 'successRate': 0.85},
                    {'text': 'Kotlin', 'successRate': 0.25},
                    {'text': 'Swift', 'successRate': 0.25},
                    {'text': 'MySQL', 'successRate': 0.80},
                    {'text': 'JAVA', 'successRate': 0.35},
                    {'text': 'Python', 'successRate': 0.35},
                    {'text': 'Adobe Creative Cloud', 'successRate': 0.75},
                    {'text': 'MS Office Suite', 'successRate': 0.9},
                    {'text': 'macOS', 'successRate': 0.9},
                    {'text': 'appwrite', 'successRate': 0.55},
                  ], context),
                ),
                const Divider(),
                _buildSectionWithOpacity(
                  'BERUFLICHE SCHWERPUNKTE',
                  _buildCompetenceList([
                    'Werbeleiter - Tien-Versand, Nordhorn',
                    'Creativ Director - GECCO Werbeagentur, Hamburg',
                    'Projektleiter - mifaz.de, Lüneburg',
                    'Art Director - Direct Friends, Hamburg',
                    'Selbstständig - Hamburg, Bad Bevensen'
                  ]),
                ),
                const Divider(),
                _buildSectionWithOpacity(
                  'AUSBILDUNG',
                  _buildEducationList([
                    'Fachinformatiker Anwendungsentwicklung (IHK)',
                    'Scrum Master (Certified Scrum Master®)',
                    'Product Owner (Certified Product Owner®)',
                    'Fachhochschulreife (FOS für Gestaltung)',
                    'Certified Neuro Linguistik Seller',
                    'Gestalter für visuelles Marketing (IHK)'
                  ]),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                const Divider(),
                _buildSectionWithOpacity(
                  'PERSÖNLICHKEIT',
                  _buildGridList([
                    'kreativ',
                    'zuverlässig',
                    'kommunikativ',
                    'neugierig',
                    'analytisch',
                    'lernbereit',
                    'überzeugend',
                    'innovativ'
                  ], context),
                ),
                const SizedBox(height: 20.0),
                _buildContactInfo(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressButton(
      String text, double successRate, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              value: successRate,
              minHeight: 10,
              backgroundColor: Colors.grey[400],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      // Consistent color for dark mode
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'GUIDO HINRICHS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, // Orange color for the header
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Kurzprofil',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Adjust color based on theme
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithOpacity(String title, Widget content,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Align(
            alignment: crossAxisAlignment == CrossAxisAlignment.end
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          const SizedBox(height: 10.0),
          content,
        ],
      ),
    );
  }

  Widget _buildProgressGridList(
      List<Map<String, dynamic>> items, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildProgressButton(
          item['text'] as String,
          item['successRate'] as double,
          context,
        );
      },
    );
  }

  Widget _buildEducationList(List<String> education) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: education
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text('• $item',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ))
          .toList(),
    );
  }

  Widget _buildCompetenceList(List<String> competences) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: competences
          .map((competence) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text('• $competence',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ))
          .toList(),
    );
  }

  Widget _buildGridList(List<String> items, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          // Set color based on theme
          child: Center(
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode
                    ? Colors.white
                    : Colors.black, // Set text color based on theme
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Kontakt',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Text color based on theme
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Krummer Arm 35, 29549 Bad Bevensen',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Text color based on theme
                ),
              ),
              const SizedBox(height: 5),
              // E-Mail Adresse nur als Text anzeigen
              Text(
                'guido.hinrichs@icloud.com',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Orange text color
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: '+491635749349',
                  );
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  } else {
                    if (kDebugMode) {
                      print('Could not launch $phoneUri');
                    }
                  }
                },
                child: Text(
                  '+49 163 / 57 49 3 49',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode
                        ? Colors.orange
                        : Colors.orange, // Orange text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
