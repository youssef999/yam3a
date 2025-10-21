

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/core/widgets/custom_textformfield.dart';
import 'package:shop_app/features/login/login_controller.dart';

class LoginForm extends StatelessWidget {

  final LoginController controller;
  const LoginForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

       // Login to continue text
                  Center(
                    child: CustomTextMedium(
                      'login_to_continue'.tr,
                      color: txtColor,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                    // Email field
                  CustomTextFormField.email(
                    hint: 'Email'.tr,
                    controller: controller.emailController,
                    color: primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_email'.tr;
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'please_enter_valid_email'.tr;
                      }
                      return null;
                    },
                  ),                  const SizedBox(height: 20),
                  
                  // Password field
                  CustomTextFormField.password(
                    hint: 'Password'.tr,
                    controller: controller.passwordController,
                    color: primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_password'.tr;
                      }
                      if (value.length < 6) {
                        return 'password_min_length'.tr;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => controller.goToForgotPassword(),
                      child: CustomTextMedium(
                        'forgot_password'.tr,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),

    ],);
  }
}