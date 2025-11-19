# TomaCare Model Assets

## Required Files

1. **TomaCare_model_quantized.tflite** - Your trained and quantized TensorFlow Lite model
   - Place this file in the `assets/` directory
   - The model should be optimized for mobile deployment

2. **labels.txt** - Already created with the following labels:
   - Early_blight
   - Late_blight
   - Leaf_mold
   - Healthy

## Instructions

1. Copy your `TomaCare_model_quantized.tflite` file into this `assets/` directory
2. Verify that `labels.txt` contains your exact class names (one per line)
3. Run `flutter pub get` to ensure all dependencies are installed
4. The app will automatically load the model when it starts

## Model Requirements

- Input size: 224x224x3 (RGB images)
- Input normalization: Pixel values should be in range [0.0, 1.0] (already handled in code)
- Output: Probability distribution over 4 classes






