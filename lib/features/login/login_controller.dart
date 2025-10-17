import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/core/utils/app_message.dart';
import 'package:shop_app/core/constants/app_routes.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

/// Controller for login screen that handles all login-related logic
class LoginController extends GetxController {
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Loading state
  bool isLoading = false;
  
  // Form key for validation
  final formKey = GlobalKey<FormState>();
  
  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  void onClose() {
    // Clean up controllers
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  /// Login with email and password
  Future<void> loginWithEmailPassword(BuildContext context) async {
    // Check if formKey.currentState is null before validating
    print('Login attempt with formKey: $formKey');
    
    if (formKey.currentState == null) {
      print('Form state is null');
      appMessageFail(context: context, text: 'form_not_initialized'.tr);
      return;
    }
    
    // Force revalidation of the entire form
    final isValid = formKey.currentState!.validate();
    print('Form validation result: $isValid');
    
    if (!isValid) return;
    
    isLoading = true;
    update();
    
    try {
      // Validate that email and password are not empty
      final email = emailController.text.trim();
      final password = passwordController.text;
      
      if (email.isEmpty || password.isEmpty) {
        appMessageFail(context: context, text: email.isEmpty ? 'please_enter_email'.tr : 'please_enter_password'.tr);
        return;
      }
      
      print('Attempting login with email: $email');
      
      // Sign in with email and password
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user != null) {
        print('Login successful for user: ${userCredential.user!.uid}');
        await storeUserInfo(userCredential.user!);
        // ignore: use_build_context_synchronously
        appMessageSuccess(context: context, text: "login_successful".tr);
        //Get.offAllNamed(AppRoutes.home);
        Get.offAll(const AppBottomBar());
      } else {
        print('User credential is null after successful authentication');
        appMessageFail(context: context, text: 'user_info_error'.tr);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth errors
                  String message = 'login_error'.tr;
      
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      
      if (e.code == 'user-not-found') {
        message = 'user_not_found'.tr;
      } else if (e.code == 'wrong-password') {
        message = 'wrong_password'.tr;
      } else if (e.code == 'invalid-email') {
        message = 'invalid_email'.tr;
      } else if (e.code == 'network-request-failed') {
        message = 'network_error'.tr;
      } else {
        message = 'authentication_error'.tr + e.code;
      }      appMessageFail(context: context, text: message);
    } catch (e, stackTrace) {
      print("Error during login: $e");
      print("Stack trace: $stackTrace");
      appMessageFail(context: context, text: 'login_failed_generic'.tr + e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
  
  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    isLoading = true;
    update();
    
    try {
      // Implement Google Sign-in
      // Google sign-in would typically involve:
      // 1. Using GoogleSignIn package to get GoogleSignInAccount
      // 2. Get GoogleSignInAuthentication from account
      // 3. Create AuthCredential with the access token
      // 4. Sign in to Firebase with the credential
      
      print('Google sign in clicked');
      await Future.delayed(const Duration(seconds: 1));
      
      // Placeholder for demonstration
      Get.snackbar(
        'login_with_google'.tr,
        'Google Sign In implementation pending',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'login_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    isLoading = true;
    update();
    
    try {
      // Implement Apple Sign-in
      // Apple sign-in would typically involve:
      // 1. Creating Apple credential request
      // 2. Performing Apple sign in
      // 3. Creating Firebase credential
      // 4. Signing in to Firebase with credential
      
      print('Apple sign in clicked');
      await Future.delayed(const Duration(seconds: 1));
      
      // Placeholder for demonstration
      Get.snackbar(
        'login_with_apple'.tr,
        'Apple Sign In implementation pending',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'login_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isLoading = false;
      update();
    }
  }
  
  /// Navigate to registration page
  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }
  
  /// Navigate to forgot password page
  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
  
  /// Store user info in local storage
  Future<void> storeUserInfo(User user) async {
    // Save to local storage using LocalStorageService
    await storage.write('userId', user.uid);
    await storage.saveUserEmail(user.email ?? '');
    await storage.saveUserName(user.displayName ?? '');
    await storage.write('isLoggedIn', true);
    print('User info stored locally for userId: ${user.uid}');
  }
}
