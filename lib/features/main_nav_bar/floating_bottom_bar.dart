import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

class FloatingBottomBar extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String? customText;
  
  const FloatingBottomBar({
    Key? key,
    this.showBackButton = true,
    this.onBackPressed,
    this.customText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: resolvedButtonColor.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back button (optional)
              if (showBackButton) ...[
                _buildBackButton(resolvedButtonColor),
                const SizedBox(width: 16),
              ],
              
              // Center logo button
              _buildCenterLogoButton(resolvedButtonColor),
              
              // Optional custom action button
              if (customText != null) ...[
                const SizedBox(width: 16),
                _buildCustomButton(resolvedButtonColor),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(Color buttonColor) {
    return InkWell(
      onTap: onBackPressed ?? () => Get.back(),
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildCenterLogoButton(Color buttonColor) {
    return InkWell(
      onTap: () {
        // Navigate to main navigation bar (home screen)
        Get.offAll(() => const AppBottomBar());
      },
      borderRadius: BorderRadius.circular(30),
      splashColor: buttonColor.withOpacity(0.1),
      highlightColor: buttonColor.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo container
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: buttonColor.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: buttonColor.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/yamaLogo1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Brand text
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YAMAA',
                  style: TextStyle(
                    fontFamily: 'fs_albert',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'return_home'.tr.isNotEmpty ? 'return_home'.tr : 'Return Home',
                  style: TextStyle(
                    fontFamily: 'fs_albert',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(Color buttonColor) {
    return InkWell(
      onTap: () {
        // Custom action if needed
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: buttonColor.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: buttonColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.more_horiz_rounded,
          size: 20,
          color: buttonColor,
        ),
      ),
    );
  }
}

// Compact version for minimal screens
class CompactFloatingBottomBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  
  const CompactFloatingBottomBar({
    Key? key,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    
    return Positioned(
      bottom: 30,
      right: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Back button
          InkWell(
            onTap: onBackPressed ?? () => Get.back(),
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Home logo button
          InkWell(
            onTap: () {
              Get.offAll(() => const AppBottomBar());
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: resolvedButtonColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: resolvedButtonColor.withOpacity(0.5),
                  width: 2.5,
                ),
              ),
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/yamaLogo1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Floating Action Button style version
class FloatingActionBottomBar extends StatelessWidget {
  const FloatingActionBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
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
      ),
    );
  }
}