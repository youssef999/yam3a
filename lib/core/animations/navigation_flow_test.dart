import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/home/widgets/cat_service_card.dart';
import 'package:shop_app/features/home/models/cat_service.dart';

class NavigationFlowTest extends StatelessWidget {
  const NavigationFlowTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Flow Test'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Test Complete Navigation Flow',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 30),
            
            // Test Category Service Card Animation
            Text(
              'Category → Brands → Brand Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            
            // Sample category card
            SizedBox(
              height: 180,
              child: catServiceCard(
                catService: CatService(
                  id: 'test-1',
                  name: 'Test Category',
                  nameAr: 'فئة تجريبية',
                  image: 'assets/images/category_placeholder.png',
                  icon: 'assets/icons/category_icon.png',
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Test individual animations
            const Text(
              'Individual Animation Tests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            _buildTestButton(
              'Test Slide Right (Category Style)',
              () => AnimatedGet.toWithSlideRight(const TestScreen(title: 'Slide Right')),
              Colors.blue,
            ),
            
            _buildTestButton(
              'Test Scale Animation (Premium Style)',
              () => AnimatedGet.toWithScale(const TestScreen(title: 'Scale Animation')),
              Colors.orange,
            ),
            
            _buildTestButton(
              'Test Slide Up (Modal Style)',
              () => AnimatedGet.toWithSlideUp(const TestScreen(title: 'Slide Up')),
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(String title, VoidCallback onPressed, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(title, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  final String title;

  const TestScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            Text(
              '$title Test',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Animation completed successfully!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}