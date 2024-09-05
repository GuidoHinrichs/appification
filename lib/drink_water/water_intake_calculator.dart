// Berechnung der empfohlenen Wasseraufnahme basierend auf Gewicht, Alter, Aktivitätsniveau und Temperatur
double calculateWaterIntake(
    int weight, int age, String activityLevel, double temperature) {
  double baseIntake = weight * 0.03; // Basiswert pro kg Körpergewicht
  double activityFactor;
  double temperatureFactor;

  switch (activityLevel) {
    case 'NIEDRIG':
      activityFactor = 1.0;
      break;
    case 'NORMAL':
      activityFactor = 1.1;
      break;
    case 'MEDIUM':
      activityFactor = 1.2;
      break;
    case 'HOCH':
      activityFactor = 1.3;
      break;
    default:
      activityFactor = 1.0;
  }

  if (temperature <= 20) {
    temperatureFactor = 1.0;
  } else if (temperature <= 25) {
    temperatureFactor = 1.1;
  } else if (temperature <= 30) {
    temperatureFactor = 1.2;
  } else {
    temperatureFactor = 1.3;
  }

  return baseIntake * activityFactor * temperatureFactor;
}
