


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/custom_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Logo
        // Center(
        //   child: Container(
        //     height: 80,
        //     width: 80,
        //     decoration: BoxDecoration(
        //       color: primaryColor.withOpacity(0.1),
        //       shape: BoxShape.circle,
        //     ),
        //     child: Center(
        //       child: Image.asset(
        //         appLogo, // Use constant from app_images.dart
        //         height: 60,
        //         width: 60,
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   ),
        // ),

        CircleAvatar(
          radius: 70,
          backgroundImage:  AssetImage(appLogo),
        ),
        
        const SizedBox(height: 30),
        
        // Welcome back text
        Center(
          child: CustomTextLarge(
            'welcome_back'.tr,
            fontWeight: FontWeight.bold,
            color: txtColor,
          ),
        ),
      ],
    );
  }
}