class DiseaseInfo {
  final String diseaseName;
  final String key; // matches the label from your model
  final List<String> symptoms;
  final List<String> managementSteps;
  final String severity; // 'Low', 'Medium', 'High'
  final String preventionTips;

  DiseaseInfo({
    required this.diseaseName,
    required this.key,
    required this.symptoms,
    required this.managementSteps,
    required this.severity,
    required this.preventionTips,
  });
}

