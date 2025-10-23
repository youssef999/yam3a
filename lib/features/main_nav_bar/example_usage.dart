import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/main_nav_bar/floating_bottom_bar.dart';

class ExampleScreenWithFloatingBar extends StatelessWidget {
  const ExampleScreenWithFloatingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('example_screen'.tr.isNotEmpty ? 'example_screen'.tr : 'Example Screen'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 120, // Extra space for floating bottom bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Screen Content',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This is an example screen that uses the floating bottom bar. The YAMAA logo at the bottom allows users to return to the main navigation from any screen.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Example usage instructions
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'How to Use',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '1. Import the FloatingBottomBar component\n'
                        '2. Add it to your Stack widget\n'
                        '3. Choose from different styles:\n'
                        '   • FloatingBottomBar (full featured)\n'
                        '   • CompactFloatingBottomBar (minimal)\n'
                        '   • FloatingActionBottomBar (FAB style)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade700,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Multiple example cards
                ...List.generate(3, (index) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card ${index + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is example content for card ${index + 1}. You can scroll through this content while the floating bottom bar remains accessible.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          
          // Floating Bottom Bar - Choose one of these styles:
          
          // Style 1: Full featured floating bar
          const FloatingBottomBar(
            showBackButton: true,
            customText: 'More',
          ),
          
          // Style 2: Compact version (uncomment to use instead)
          // const CompactFloatingBottomBar(),
          
          // Style 3: Floating Action Button style (uncomment to use instead)
          // const FloatingActionBottomBar(),
        ],
      ),
    );
  }
}

// Example of how to navigate to a screen with floating bottom bar
class ExampleUsageHelper {
  static void navigateToScreenWithFloatingBar() {
    Get.to(() => const ExampleScreenWithFloatingBar());
  }
  
  static void navigateToScreenWithCompactBar() {
    Get.to(() => const ExampleScreenWithCompactBar());
  }
  
  static void navigateToScreenWithFABBar() {
    Get.to(() => const ExampleScreenWithFABBar());
  }
}

// Example screens with different floating bar styles
class ExampleScreenWithCompactBar extends StatelessWidget {
  const ExampleScreenWithCompactBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Compact Bar Example'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'This screen uses the CompactFloatingBottomBar style.\n\nIt shows a minimal back button and home logo in the bottom right corner.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const CompactFloatingBottomBar(),
        ],
      ),
    );
  }
}

class ExampleScreenWithFABBar extends StatelessWidget {
  const ExampleScreenWithFABBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('FAB Style Example'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'This screen uses the FloatingActionBottomBar style.\n\nIt shows only the YAMAA logo as a floating action button to return home.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const FloatingActionBottomBar(),
        ],
      ),
    );
  }
}