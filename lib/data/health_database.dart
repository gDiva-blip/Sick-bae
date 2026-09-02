import '../models/symptom_model.dart';

class HealthDatabase {
  static final Map<String, SymptomInfo> symptoms = {
    'headache': SymptomInfo(
      name: 'Headache',
      description: 'Pain or pressure in the head or neck area',
      commonCauses: [
        'Stress and tension',
        'Dehydration',
        'Poor sleep',
        'Eye strain',
      ],
      recommendations: [
        'Rest in a quiet, dark room',
        'Drink plenty of water',
        'Apply a warm or cold compress',
        'Take over-the-counter pain relief (if appropriate)',
        'Practice relaxation techniques',
      ],
      requiresEmergency: false,
      emergencyWarning: '',
    ),
    'fever': SymptomInfo(
      name: 'Fever',
      description: 'Body temperature higher than normal (above 100.4°F or 38°C)',
      commonCauses: [
        'Viral infection (flu, cold)',
        'Bacterial infection',
        'Inflammation',
      ],
      recommendations: [
        'Rest and get plenty of sleep',
        'Stay hydrated with water and fluids',
        'Use fever-reducing medication if needed',
        'Wear light clothing',
        'Monitor your temperature regularly',
      ],
      requiresEmergency: false,
      emergencyWarning: 'Seek immediate care if fever is above 103°F (39.4°C) or accompanied by confusion.',
    ),
    'cough': SymptomInfo(
      name: 'Cough',
      description: 'Repeated forced expulsion of air from the lungs',
      commonCauses: [
        'Common cold',
        'Flu',
        'Allergies',
        'Irritation',
      ],
      recommendations: [
        'Stay hydrated',
        'Use honey or cough drops',
        'Rest your voice',
        'Use a humidifier',
        'Avoid irritants like smoke',
      ],
      requiresEmergency: false,
      emergencyWarning: '',
    ),
    'nausea': SymptomInfo(
      name: 'Nausea',
      description: 'Feeling sick to the stomach',
      commonCauses: [
        'Food poisoning',
        'Motion sickness',
        'Migraine',
        'Medication side effects',
      ],
      recommendations: [
        'Sit or lie down in a cool place',
        'Eat small, bland meals',
        'Drink ginger tea or water',
        'Avoid strong smells',
        'Try deep breathing exercises',
      ],
      requiresEmergency: false,
      emergencyWarning: '',
    ),
  };

  static SymptomInfo? getSymptomInfo(String symptom) {
    return symptoms[symptom.toLowerCase()];
  }

  static List<String> getAllSymptoms() {
    return symptoms.keys.toList();
  }
}
