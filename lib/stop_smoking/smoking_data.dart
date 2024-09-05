class SmokingData {
  final int selectedCigarettes;
  final String firstCigaretteTime;
  final String lastCigaretteTime;
  final int morningCigarettes;
  final int afternoonCigarettes;
  final int eveningCigarettes;

  SmokingData({
    required this.selectedCigarettes,
    required this.firstCigaretteTime,
    required this.lastCigaretteTime,
    required this.morningCigarettes,
    required this.afternoonCigarettes,
    required this.eveningCigarettes,
  });

  Map<String, dynamic> toMap() {
    return {
      'selectedCigarettes': selectedCigarettes,
      'firstCigaretteTime': firstCigaretteTime,
      'lastCigaretteTime': lastCigaretteTime,
      'morningCigarettes': morningCigarettes,
      'afternoonCigarettes': afternoonCigarettes,
      'eveningCigarettes': eveningCigarettes,
    };
  }

  factory SmokingData.fromMap(Map<String, dynamic> map) {
    return SmokingData(
      selectedCigarettes: map['selectedCigarettes'],
      firstCigaretteTime: map['firstCigaretteTime'],
      lastCigaretteTime: map['lastCigaretteTime'],
      morningCigarettes: map['morningCigarettes'],
      afternoonCigarettes: map['afternoonCigarettes'],
      eveningCigarettes: map['eveningCigarettes'],
    );
  }
}
