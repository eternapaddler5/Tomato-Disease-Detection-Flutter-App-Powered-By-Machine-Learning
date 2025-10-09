import 'dart:io';
import 'package:flutter/material.dart';

class RecentResultsPage extends StatelessWidget {
  final File? image;
  const RecentResultsPage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      appBar: AppBar(
        title: const Text('Recent Results'),
        backgroundColor: const Color(0xFF55873B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Here are recent results (placeholder)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            if (image != null) ...[
              const Text('Captured image:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Image.file(image!, width: 250, height: 250, fit: BoxFit.cover,),
            ] else ...[
              const SizedBox(height: 12),
              const Text('No captured image available. Take a picture from the home screen.'),
            ],
          ],
        ),
      ),
    );
  }
}
