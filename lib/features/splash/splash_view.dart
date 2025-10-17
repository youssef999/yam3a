import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/features/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SplashController controller = Get.put(SplashController());
    
    // Set system overlay style for status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    
    return Scaffold(
      // Use purple gradient background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              splashBackgroundStart, // Purple gradient start
              splashBackgroundEnd,   // Darker purple gradient end
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated logo
              Obx(() => AnimatedOpacity(
                opacity: controller.logoOpacity.value,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                child: AnimatedScale(
                  scale: controller.logoScale.value,
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutBack,
                  child: _buildLogo(),
                ),
              )),
              
              const SizedBox(height: 24),
              
              // Animated app name
              Obx(() => AnimatedOpacity(
                opacity: controller.textOpacity.value,
                duration: const Duration(milliseconds: 800),
                child: const CustomTextLarge(
                  'YAMAA',
                  color: splashTextColor,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
              )),
              
              const SizedBox(height: 8),
              
              // Animated tagline
              Obx(() => AnimatedOpacity(
                opacity: controller.textOpacity.value,
                duration: const Duration(milliseconds: 1000),
                child: const CustomTextSmall(
                  'Professional Services',
                  color: splashTextColor,
                  textAlign: TextAlign.center,
                ),
              )),
              
              const Spacer(),
              
              // Version info at bottom
              Obx(() => AnimatedOpacity(
                opacity: controller.textOpacity.value * 0.7, // Slightly less visible
                duration: const Duration(milliseconds: 1200),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: CustomTextSmall(
                    'Version 1.0.0',
                    color: Colors.white70,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the app logo
  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryGradientStart,  // Orange gradient start
              primaryGradientEnd,    // Darker orange gradient end
            ],
          ),
        ),
        child: Center(
          child: Text(
            'يـ',  // Arabic-style logo text
            style: TextStyle(
              color: Colors.white,
              fontSize: 52, 
              fontWeight: FontWeight.bold,
              fontFamily: 'fs_albert',
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}