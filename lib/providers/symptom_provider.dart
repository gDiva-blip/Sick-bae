import 'package:flutter/material.dart';
import '../data/health_database.dart';
import '../models/symptom_model.dart';

class SymptomProvider extends ChangeNotifier {
  SymptomInfo? _currentSymptom;
  List<String> _selectedSymptoms = [];

  SymptomInfo? get currentSymptom => _currentSymptom;
  List<String> get selectedSymptoms => _selectedSymptoms;

  void searchSymptom(String symptomName) {
    _currentSymptom = HealthDatabase.getSymptomInfo(symptomName);
    notifyListeners();
  }

  void addSymptom(String symptom) {
    if (!_selectedSymptoms.contains(symptom)) {
      _selectedSymptoms.add(symptom);
      notifyListeners();
    }
  }

  void removeSymptom(String symptom) {
    _selectedSymptoms.remove(symptom);
    notifyListeners();
  }

  void clearSymptoms() {
    _selectedSymptoms.clear();
    _currentSymptom = null;
    notifyListeners();
  }
}
