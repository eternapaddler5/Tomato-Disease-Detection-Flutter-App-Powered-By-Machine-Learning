import 'package:flutter/material.dart';
import 'package:tomotoe_disease_detection_app/view/dashBoardScreen.dart';

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
      home:  TomaCareHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

