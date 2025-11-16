import 'package:flutter/material.dart';
import 'package:tomotoe_disease_detection_app/view/dashBoardScreen.dart';
import 'package:tomotoe_disease_detection_app/view/tutorial_screen.dart';
import 'package:tomotoe_disease_detection_app/service/tutorial_service.dart';

void main() {
  runApp(const TomaCareApp());
}

class TomaCareApp extends StatelessWidget {
  const TomaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const AppInitializer(), // Changed to check for first launch
      debugShowCheckedModeBanner: false,
    );
  }
}

// Widget that decides whether to show tutorial or home screen
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool isLoading = true;
  bool showTutorial = false;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  // Check if this is the first time opening the app
  Future<void> checkFirstLaunch() async {
    final isFirstTime = await TutorialService.isFirstTime();
    setState(() {
      showTutorial = isFirstTime;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFE6EEDA),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show tutorial if first time, otherwise show home
    return showTutorial ? const TutorialScreen() : const TomaCareHomePage();
  }
}

