import 'package:flutter/material.dart';

class PestsDiseasesPage extends StatelessWidget {
  const PestsDiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      appBar: AppBar(
        title: const Text('Pests & Diseases'),
        backgroundColor: const Color(0xFF55873B),
      ),
      body: const Center(
        child: Text('Pests & Diseases content goes here (placeholder)'),
      ),
    );
  }
}