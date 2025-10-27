import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

class FloatingYamaaButton extends StatelessWidget {
  const FloatingYamaaButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    final bool isArabic = Get.locale?.languageCode == 'ar';
    
    return Positioned(
      bottom: 30,
      left: isArabic ? 20 : null,
      right: isArabic ? null : 20,
      child: InkWell(
        onTap: () {
          Get.offAll(() => const AppBottomBar());
        },
        borderRadius: BorderRadius.circular(35),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: resolvedButtonColor.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: resolvedButtonColor.withOpacity(0.6),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/images/yamaLogo1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}