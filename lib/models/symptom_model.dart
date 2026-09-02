class SymptomInfo {
  final String name;
  final String description;
  final List<String> commonCauses;
  final List<String> recommendations;
  final bool requiresEmergency;
  final String emergencyWarning;

  SymptomInfo({
    required this.name,
    required this.description,
    required this.commonCauses,
    required this.recommendations,
    required this.requiresEmergency,
    required this.emergencyWarning,
  });
}
