import 'package:flutter/material.dart';
import 'package:tomotoe_disease_detection_app/service/tutorial_service.dart';
import 'package:tomotoe_disease_detection_app/view/dashBoardScreen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  // Page controller for PageView
  final PageController _pageController = PageController();
  
  // Current page index
  int currentPage = 0;

  // List of tutorial pages
  final List<TutorialPage> tutorialPages = [
    TutorialPage(
      title: 'Welcome to TomaCare!',
      description: 'Your smart tomato disease detection assistant. Let\'s get started!',
      icon: Icons.eco,
      color: Colors.green,
    ),
    TutorialPage(
      title: 'Capture Plant Images',
      description: 'Take a photo of your tomato plant leaf or upload an image from your gallery to diagnose diseases.',
      icon: Icons.camera_alt,
      color: Colors.blue,
    ),
    TutorialPage(
      title: 'Get Instant Diagnosis',
      description: 'Our AI will analyze the image and tell you if your plant is healthy or has a disease.',
      icon: Icons.analytics,
      color: Colors.orange,
    ),
    TutorialPage(
      title: 'Learn & Manage',
      description: 'View detailed symptoms, management instructions, and prevention tips for each disease.',
      icon: Icons.healing,
      color: Colors.purple,
    ),
    TutorialPage(
      title: 'Browse Diseases',
      description: 'Explore all diseases in the Pests & Diseases section to learn more about tomato plant health.',
      icon: Icons.bug_report,
      color: Colors.red,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEDA),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at the top
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () => _completeTutorial(),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            // Page view for tutorial pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: tutorialPages.length,
                itemBuilder: (context, index) {
                  return _buildTutorialPage(tutorialPages[index]);
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tutorialPages.length,
                (index) => _buildPageIndicator(index == currentPage),
              ),
            ),

            const SizedBox(height: 30),

            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < tutorialPages.length - 1) {
                      // Go to next page
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Complete tutorial
                      _completeTutorial();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    currentPage < tutorialPages.length - 1 ? 'Next' : 'Get Started',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build a single tutorial page
  Widget _buildTutorialPage(TutorialPage page) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 60,
              color: page.color,
            ),
          ),
          const SizedBox(height: 40),

          // Title
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build page indicator dots
  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Complete tutorial and navigate to home
  Future<void> _completeTutorial() async {
    // Mark tutorial as shown
    await TutorialService.markTutorialAsShown();
    
    // Navigate to home screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TomaCareHomePage(),
        ),
      );
    }
  }
}

// Model class for tutorial pages
class TutorialPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  TutorialPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}


