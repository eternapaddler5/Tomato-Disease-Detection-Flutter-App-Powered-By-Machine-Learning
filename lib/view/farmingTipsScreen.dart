import 'package:flutter/material.dart';

class FarmingTipsPage extends StatelessWidget {
  const FarmingTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      appBar: AppBar(
        title: const Text('Farming Tips'),
        backgroundColor: const Color(0xFF55873B),
      ),
      body: const Center(
        child: Text('Farming tips content goes here (placeholder)'),
      ),
    );
  }
}