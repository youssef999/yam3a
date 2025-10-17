

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/login/login_controller.dart';

class RegisterLinkField extends StatelessWidget {
      final LoginController controller;
  const RegisterLinkField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          // Register link
                  Center(
                    child: GestureDetector(
                      onTap: () => controller.goToRegister(),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: txtColor,
                            fontFamily: 'fs_albert',
                          ),
                          children: [
                            TextSpan(text: '${'dont_have_account'.tr} '),
                            TextSpan(
                              text: 'register'.tr,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
    ],);
  }
}