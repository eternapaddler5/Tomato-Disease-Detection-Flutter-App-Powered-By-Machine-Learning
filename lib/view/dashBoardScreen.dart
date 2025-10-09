import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tomotoe_disease_detection_app/model/camera_model.dart';
import 'package:tomotoe_disease_detection_app/view/farmingTipsScreen.dart';
import 'package:tomotoe_disease_detection_app/view/pestDiseaseScreen.dart';
import 'package:tomotoe_disease_detection_app/view/resultsScreen.dart';

class TomaCareHomePage extends StatefulWidget {
  const TomaCareHomePage({super.key});

  @override
  State<TomaCareHomePage> createState() => _TomaCareHomePageState();
}

class _TomaCareHomePageState extends State<TomaCareHomePage> {
  int _selectedIndex = 0;
  File? _selectedImage; // image captured from camera

  void _pickImageFromCamera() async {
    final image = await pickImageFromCamera();
    if (image == null) return;

    setState(() {
      _selectedImage = image;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Image captured successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildWeatherSection(),
                const SizedBox(height: 30),
                _buildCropSelection(),
                const SizedBox(height: 24),
                _buildFeatureCards(),
                const SizedBox(height: 24),
                _buildHealYourCropSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TomaCare',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.more_vert, color: Colors.black, size: 24),
        ),
      ],
    );
  }

  Widget _buildWeatherSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Today, 11 Aug',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  '25 °C',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCropSelection() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'lib/view/icons/tomato animation.gif',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCropIcon(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.add, color: Colors.black, size: 30),
    );
  }

  Widget _buildFeatureCards() {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.history_edu_outlined,
            title: 'Recent\nResults',
            color: const Color(0xFF55873B),
            onTap: () {
              // navigate to RecentResultsPage and pass the captured image (if any)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecentResultsPage(image: _selectedImage),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.bug_report,
            title: 'Pests &\nDiseases',
            color: const Color(0xFF55873B),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PestsDiseasesPage()),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.agriculture,
            title: 'farming\nTips',
            color: const Color(0xFF55873B),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FarmingTipsPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    // Use Material + InkWell to keep ripple effect while preserving your design
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealYourCropSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diagnose your crop',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/view/icons/capture plant2.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 5),
                  const Text('Capture Plant'),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/view/icons/app process icon2.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 5),
                  const Text('App Process'),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/view/icons/results2.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 5),
                  const Text('Results'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _pickImageFromCamera();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: const Color(0xFFC1E698),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Take A Picture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Community',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
