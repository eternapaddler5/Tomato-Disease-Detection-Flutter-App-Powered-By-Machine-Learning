class PastRecord {
  const PastRecord({
    this.id,
    required this.imagePath,
    required this.diagnosisLabel,
    required this.confidence,
    required this.createdAt,
  });

  final int? id;
  final String imagePath;
  final String diagnosisLabel;
  final double confidence;
  final DateTime createdAt;

  PastRecord copyWith({int? id}) {
    return PastRecord(
      id: id ?? this.id,
      imagePath: imagePath,
      diagnosisLabel: diagnosisLabel,
      confidence: confidence,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_path': imagePath,
      'diagnosis_label': diagnosisLabel,
      'confidence': confidence,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory PastRecord.fromMap(Map<String, dynamic> map) {
    return PastRecord(
      id: map['id'] as int?,
      imagePath: map['image_path'] as String,
      diagnosisLabel: map['diagnosis_label'] as String,
      confidence: (map['confidence'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String get formattedLabel {
    return diagnosisLabel
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

