import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/login/login_controller.dart';
import 'package:shop_app/features/login/widgets/login_buttons.dart';
import 'package:shop_app/features/login/widgets/login_form.dart';
import 'package:shop_app/features/login/widgets/login_header.dart';
import 'package:shop_app/features/login/widgets/register_link_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the controller using find (controller is initialized through bindings)
    //final loginController = Get.find<LoginController>();
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:AppBar(
        backgroundColor:primaryColor,
        toolbarHeight: 3,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<LoginController>(
              builder: (ctrl) => Form(
                key: ctrl.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    
                 const LoginHeader(),
                  
                  const SizedBox(height: 12),
                  LoginForm(controller: controller),
                 
                  
                  // Login button
                  LoginButtons(controller: controller),
                   
                  RegisterLinkField(controller: controller),
                
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
  


}
