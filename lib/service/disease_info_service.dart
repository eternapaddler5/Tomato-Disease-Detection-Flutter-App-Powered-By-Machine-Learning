import 'package:tomotoe_disease_detection_app/model/disease_info.dart';

class DiseaseInfoService {
  static final Map<String, DiseaseInfo> _diseaseDatabase = {
    'tomato_bacterial_spot': DiseaseInfo(
      diseaseName: 'Bacterial Spot',
      key: 'tomato_bacterial_spot',
      symptoms: [
        'Small, dark, water-soaked spots on leaves',
        'Spots enlarge and become angular',
        'Yellow halos around spots',
        'Spots may appear on stems and fruits',
      ],
      managementSteps: [
        'Remove and destroy infected plant parts immediately',
        'Apply copper-based fungicides every 7-10 days',
        'Avoid overhead watering to reduce leaf wetness',
        'Use disease-free seeds and transplants',
        'Practice crop rotation (3-4 years)',
        'Maintain proper spacing for air circulation',
      ],
      severity: 'High',
      preventionTips: 'Use resistant varieties and sanitize tools between uses.',
    ),
    'tomato_early_blight': DiseaseInfo(
      diseaseName: 'Early Blight',
      key: 'tomato_early_blight',
      symptoms: [
        'Dark brown spots with concentric rings on lower leaves',
        'Yellowing and browning of leaves',
        'Premature leaf drop',
        'Lesions on stems and fruits',
      ],
      managementSteps: [
        'Remove infected leaves and plant debris',
        'Apply fungicides containing chlorothalonil or mancozeb',
        'Mulch around plants to prevent soil splash',
        'Water at the base, not on leaves',
        'Ensure good air circulation',
        'Stake plants to keep foliage off the ground',
      ],
      severity: 'Medium',
      preventionTips: 'Start with disease-free seeds and maintain proper plant spacing.',
    ),
    'tomato_late_blight': DiseaseInfo(
      diseaseName: 'Late Blight',
      key: 'tomato_late_blight',
      symptoms: [
        'Water-soaked lesions on leaves and stems',
        'White fungal growth on undersides of leaves',
        'Rapid browning and death of plant tissue',
        'Dark, firm lesions on fruits',
      ],
      managementSteps: [
        'Remove and destroy infected plants immediately',
        'Apply fungicides preventively (chlorothalonil, mancozeb)',
        'Avoid working in wet fields',
        'Improve air circulation and reduce humidity',
        'Use resistant varieties when available',
        'Practice strict sanitation',
      ],
      severity: 'High',
      preventionTips: 'Monitor weather conditions and apply preventive treatments during humid periods.',
    ),
    'healthy': DiseaseInfo(
      diseaseName: 'Healthy',
      key: 'healthy',
      symptoms: [
        'No visible disease symptoms',
        'Normal leaf color and texture',
        'Proper plant growth',
      ],
      managementSteps: [
        'Continue current care practices',
        'Monitor plants regularly',
        'Maintain proper watering and nutrition',
        'Practice preventive measures',
      ],
      severity: 'None',
      preventionTips: 'Maintain good cultural practices to keep plants healthy.',
    ),
  };

  static DiseaseInfo? getDiseaseInfo(String label) {
    // Try exact match first
    if (_diseaseDatabase.containsKey(label)) {
      return _diseaseDatabase[label];
    }
    
    // Try case-insensitive match
    final lowerLabel = label.toLowerCase();
    for (var entry in _diseaseDatabase.entries) {
      if (entry.key.toLowerCase() == lowerLabel) {
        return entry.value;
      }
    }
    
    return null;
  }

  static List<DiseaseInfo> getAllDiseases() {
    return _diseaseDatabase.values.toList();
  }
}

