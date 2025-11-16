import 'package:flutter/material.dart';
import 'package:tomotoe_disease_detection_app/service/disease_info_service.dart';
import 'package:tomotoe_disease_detection_app/view/disease_detail_screen.dart';

class PestsDiseasesPage extends StatelessWidget {
  const PestsDiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allDiseases = DiseaseInfoService.getAllDiseases();
    
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      appBar: AppBar(
        title: const Text('Diseases'),
        backgroundColor: const Color(0xFF55873B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allDiseases.length,
        itemBuilder: (context, index) {
          final disease = allDiseases[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: _getSeverityColor(disease.severity).withOpacity(0.2),
                child: Icon(
                  disease.severity == 'None' ? Icons.check_circle : Icons.warning,
                  color: _getSeverityColor(disease.severity),
                ),
              ),
              title: Text(
                disease.diseaseName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Severity: ${disease.severity}',
                style: TextStyle(
                  color: _getSeverityColor(disease.severity),
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseDetailScreen(disease: disease),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }
}