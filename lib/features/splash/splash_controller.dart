import 'dart:async';
import 'package:get/get.dart';
import 'package:shop_app/features/login/login_view.dart';

/// Controller for the splash screen with navigation logic
class SplashController extends GetxController {
  // Timer for splash screen duration
  Timer? _splashTimer;
  
  // Animation controllers
  final RxDouble logoOpacity = 0.0.obs;
  final RxDouble logoScale = 0.5.obs;
  final RxDouble textOpacity = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    _startSplashAnimations();
    _initSplashTimer();
  }

  /// Initialize animations for the splash screen elements
  void _startSplashAnimations() {
    // Initial delay before starting animations
    Future.delayed(const Duration(milliseconds: 200), () {
      // Logo fade in and scale up
      logoOpacity.value = 1.0;
      logoScale.value = 1.0;
      
      // Text fade in after logo animation
      Future.delayed(const Duration(milliseconds: 800), () {
        textOpacity.value = 1.0;
      });
    });
  }

  /// Initialize the splash screen timer
  void _initSplashTimer() {
    _splashTimer = Timer(const Duration(seconds: 4), () {
      _navigateToNextScreen();
    });
  }

  /// Navigate to the appropriate next screen
  void _navigateToNextScreen() {
    print('Splash logic done');
    
    // Navigate to the login screen after splash
    Get.off(() => const LoginView());
  }

  @override
  void onClose() {
    // Cancel the timer to prevent memory leaks
    _splashTimer?.cancel();
    super.onClose();
  }
}