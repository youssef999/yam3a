

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/features/login/login_controller.dart';

class LoginButtons extends StatelessWidget {
    final LoginController controller;
  const LoginButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:28.0,right: 28.0 ),
      child: Column(children: [
      
        Center(
                      child: GetBuilder<LoginController>(
                        builder: (controller) => controller.isLoading
                            ? CircularProgressIndicator(color: buttonColor)
                            : CustomButton(
                                text: 'login'.tr,
                                width: double.infinity,
                                onPressed: () => controller.loginWithEmailPassword(context),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // // Or divider
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Divider(color: appDividerColor, thickness: 1),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 16),
                    //       child: CustomTextMedium('or'.tr, color: primaryColor),
                    //     ),
                    //     Expanded(
                    //       child: Divider(color: appDividerColor, thickness: 1),
                    //     ),
                    //   ],
                    // ),
                    
                    const SizedBox(height: 20),
                    
                    // Google login button
                    _buildSocialLoginButton(
                      onPressed: () => controller.signInWithGoogle(),
                      iconPath: googleImage,
                      text: 'login_with_google'.tr,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Apple login button
                    _buildSocialLoginButton(
                      onPressed: () => controller.signInWithApple(),
                      iconPath: appleImage, // Use constant from app_images.dart
                      text: 'login_with_apple'.tr,
                    ),
                    
                    const SizedBox(height: 30),
      ],),
    );
  }
    Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required String iconPath,
    required String text,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            CustomTextMedium(
              text,
              color: txtColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}