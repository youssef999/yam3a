import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/features/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              primaryColor.withOpacity(0.88),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Obx(() => AnimatedOpacity(
                opacity: controller.logoOpacity.value,
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                child: AnimatedScale(
                  scale: controller.logoScale.value,
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.elasticOut,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.71,
                    height: MediaQuery.of(context).size.height * 0.56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        appLogo,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  primaryGradientStart,
                                  primaryGradientEnd,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'YAMAA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Obx(() => AnimatedOpacity(
                opacity: controller.textOpacity.value,
                duration: const Duration(milliseconds: 1200),
                child: Column(
                  children: [
                    const CustomTextLarge(
                      'YAMAA',
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),
                    CustomTextSmall(
                      'professional_services'.tr,
                      color: Colors.white70,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

}