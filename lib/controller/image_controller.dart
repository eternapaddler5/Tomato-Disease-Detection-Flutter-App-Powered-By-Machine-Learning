import 'dart:io';

import 'package:tomotoe_disease_detection_app/model/camera_model.dart';

class ImageController {
  Future<File?> captureFromCamera() {
    return pickImageFromCamera();
  }

  Future<File?> selectFromGallery() {
    return pickImageFromGallery();
  }

  Future<File?> selectFromFiles() {
    return pickImageFromFiles();
  }
}


