import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  // Key to store whether tutorial has been shown
  static const String _tutorialShownKey = 'tutorial_shown';

  // Check if this is the first time opening the app
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    // If the key doesn't exist or is false, it's the first time
    return !(prefs.getBool(_tutorialShownKey) ?? false);
  }

  // Mark tutorial as completed
  static Future<void> markTutorialAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tutorialShownKey, true);
  }

  // Reset tutorial (useful for testing)
  static Future<void> resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tutorialShownKey, false);
  }
}


