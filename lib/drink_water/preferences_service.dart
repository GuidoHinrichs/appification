import 'package:shared_preferences/shared_preferences.dart';

// Lädt die Benutzereinstellungen aus den SharedPreferences
Future<void> loadPreferences(
    Function(int) onWeightLoaded,
    Function(int) onAgeLoaded,
    Function(String) onActivityLevelLoaded,
    Function(String) onUserNameLoaded,
    Function(bool) onNameEditableChanged) async {
  final prefs = await SharedPreferences.getInstance();
  final selectedWeight = prefs.getInt('selectedWeight') ?? 60;
  final selectedAge = prefs.getInt('selectedAge') ?? 25;
  final selectedActivityLevel =
      prefs.getString('selectedActivityLevel') ?? 'NORMAL';
  final userName = prefs.getString('userName') ?? '';
  final isNameEditable =
      userName.isEmpty; // Bearbeitung des Namens, wenn er leer ist

  onWeightLoaded(selectedWeight);
  onAgeLoaded(selectedAge);
  onActivityLevelLoaded(selectedActivityLevel);
  onUserNameLoaded(userName);
  onNameEditableChanged(isNameEditable);
}

// Speichert die Benutzereinstellungen in den SharedPreferences
Future<void> savePreferences(int selectedWeight, int selectedAge,
    String selectedActivityLevel, String userName) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('selectedWeight', selectedWeight);
  prefs.setInt('selectedAge', selectedAge);
  prefs.setString('selectedActivityLevel', selectedActivityLevel);
  prefs.setString('userName', userName);
}
