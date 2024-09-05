import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:guidohinrichs/stop_smoking/picker/picker_type.dart';

Picker buildPicker(
  BuildContext context,
  PickerType pickerType,
  int selectedCigarettes,
  int morningCigarettes,
  int afternoonCigarettes,
  int eveningCigarettes,
  int addictionCigarettes,
  int habitCigarettes,
  int rewardCigarettes,
  int insteadOfEatingCigarettes,
  int boredomCigarettes,
  int enjoymentCigarettes,
  Function(Picker, List<int>) onConfirm,
) {
  Picker picker;
  int remainingCigarettes;

  switch (pickerType) {
    case PickerType.cigarettes:
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(begin: 0, end: 60),
        ]),
        delimiter: [
          PickerDelimiter(
            child: Container(
              width: 30.0,
              alignment: Alignment.center,
              child: const Text(''),
            ),
          ),
        ],
        hideHeader: true,
        title: const Text('Zigaretten pro Tag?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.firstCigaretteTime:
    case PickerType.lastCigaretteTime:
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(
            begin: 0,
            end: 23,
            suffix: Text(' Uhr'),
          ),
          const NumberPickerColumn(
            begin: 0,
            end: 45,
            jump: 15, // Nur 00, 15, 30, 45 Minuten anzeigen
          ),
        ]),
        hideHeader: true,
        title: Text(pickerType == PickerType.firstCigaretteTime
            ? 'Deine erste Zigarette?'
            : 'Deine letzte Zigarette?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.morningCigarettes:
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: selectedCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Wie viele Morgens?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.afternoonCigarettes:
      remainingCigarettes = selectedCigarettes - morningCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Wie viele Tagsüber?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.eveningCigarettes:
      remainingCigarettes =
          selectedCigarettes - morningCigarettes - afternoonCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Wie viele Abends?'),
        onConfirm: onConfirm,
      );
      break;
    // Noch nicht genutze Optionen
    case PickerType.addictionCigarettes:
      remainingCigarettes = selectedCigarettes -
          habitCigarettes -
          rewardCigarettes -
          insteadOfEatingCigarettes -
          boredomCigarettes -
          enjoymentCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten aus Sucht?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.habitCigarettes:
      remainingCigarettes = selectedCigarettes -
          addictionCigarettes -
          rewardCigarettes -
          insteadOfEatingCigarettes -
          boredomCigarettes -
          enjoymentCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten aus Gewohnheit?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.rewardCigarettes:
      remainingCigarettes = selectedCigarettes -
          addictionCigarettes -
          habitCigarettes -
          insteadOfEatingCigarettes -
          boredomCigarettes -
          enjoymentCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten zur Belohnung?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.insteadOfEatingCigarettes:
      remainingCigarettes = selectedCigarettes -
          addictionCigarettes -
          habitCigarettes -
          rewardCigarettes -
          boredomCigarettes -
          enjoymentCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten statt Essen?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.boredomCigarettes:
      remainingCigarettes = selectedCigarettes -
          addictionCigarettes -
          habitCigarettes -
          rewardCigarettes -
          insteadOfEatingCigarettes -
          enjoymentCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten aus Langeweile?'),
        onConfirm: onConfirm,
      );
      break;
    case PickerType.enjoymentCigarettes:
      remainingCigarettes = selectedCigarettes -
          addictionCigarettes -
          habitCigarettes -
          rewardCigarettes -
          insteadOfEatingCigarettes -
          boredomCigarettes;
      picker = Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: remainingCigarettes),
        ]),
        hideHeader: true,
        title: const Text('Zigaretten zum Genießen?'),
        onConfirm: onConfirm,
      );
      break;
  }

  return picker;
}
