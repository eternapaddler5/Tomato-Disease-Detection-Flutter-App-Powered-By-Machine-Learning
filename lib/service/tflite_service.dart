import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TomaCareClassifier {
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isLoading = false;
  bool _isModelLoaded = false;

  bool get isModelLoaded => _isModelLoaded;
  bool get isLoading => _isLoading;

  Future<void> loadModel() async {
    if (_isModelLoaded || _isLoading) return;
    
    _isLoading = true;
    try {
      // Load model
      _interpreter = await Interpreter.fromAsset('assets/TomaCare_model_quantized.tflite');
      
      // Load labels from assets
      final labelsData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelsData.split('\n').where((label) => label.trim().isNotEmpty).toList();
      
      _isModelLoaded = true;
      print('✅ Model loaded successfully with ${_labels.length} labels');
    } catch (e) {
      print('❌ Error loading model: $e');
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<PredictionResult> predict(File imageFile) async {
    if (!_isModelLoaded || _interpreter == null) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    try {
      // 1️⃣ Load image
      final imageBytes = await imageFile.readAsBytes();
      final rawImage = img.decodeImage(imageBytes);
      if (rawImage == null) {
        throw Exception('Failed to decode image');
      }
      
      final resized = img.copyResize(rawImage, width: 224, height: 224);

      // 2️⃣ Convert to Float32 input [1, 224, 224, 3]
      var input = List.generate(
        1,
        (_) => List.generate(
          224,
          (_) => List.generate(
            224,
            (_) => List.filled(3, 0.0),
          ),
        ),
      );

      for (int x = 0; x < 224; x++) {
        for (int y = 0; y < 224; y++) {
          final pixel = resized.getPixel(x, y);
          input[0][x][y][0] = img.getRed(pixel) / 255.0;
          input[0][x][y][1] = img.getGreen(pixel) / 255.0;
          input[0][x][y][2] = img.getBlue(pixel) / 255.0;
        }
      }

      // 3️⃣ Run inference
      var output = List.generate(1, (_) => List.filled(_labels.length, 0.0));
      _interpreter!.run(input, output);

      // 4️⃣ Find the best prediction
      final predictions = List<double>.from(output[0]);
      double maxConfidence = predictions.reduce((a, b) => a > b ? a : b);
      final index = predictions.indexOf(maxConfidence);
      final label = _labels[index];

      return PredictionResult(
        label: label,
        confidence: maxConfidence,
        allPredictions: Map.fromIterables(_labels, predictions),
      );
    } catch (e) {
      print('❌ Error during prediction: $e');
      rethrow;
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isModelLoaded = false;
  }
}

class PredictionResult {
  final String label;
  final double confidence;
  final Map<String, double> allPredictions;

  PredictionResult({
    required this.label,
    required this.confidence,
    required this.allPredictions,
  });

  String get formattedLabel {
    return label.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String get confidencePercentage {
    return '${(confidence * 100).toStringAsFixed(2)}%';
  }

  String get fullResult {
    return '$formattedLabel ($confidencePercentage)';
  }
}

