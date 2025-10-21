import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';

class BrandHeaderWidget extends StatelessWidget {
  const BrandHeaderWidget({super.key, required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    final accentColor = buttonColor is Color
        ? buttonColor as Color
        : const Color(0xFFE47B39);

    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: brand.image.isEmpty
                ? null
                : DecorationImage(
                    image: NetworkImage(brand.image),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Container(
          height: 240,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black45],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        (Get.locale?.languageCode == 'en')
            ? Positioned(
                top: 16,
                left: 16,
                child: Tooltip(
                  message: 'back'.tr,
                  child: _CircularIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
              )
            : Positioned(
                top: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'call'.tr,
                      child: _CircularIconButton(
                        icon: Icons.phone_outlined,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message: 'chat'.tr,
                      child: _CircularIconButton(
                        icon: Icons.chat_bubble_outline,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message: 'share'.tr,
                      child: _CircularIconButton(
                        icon: Icons.ios_share,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
        (Get.locale?.languageCode == 'en')
            ? Positioned(
                top: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'call'.tr,
                      child: _CircularIconButton(
                        icon: Icons.phone_outlined,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message: 'chat'.tr,
                      child: _CircularIconButton(
                        icon: Icons.chat_bubble_outline,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message: 'share'.tr,
                      child: _CircularIconButton(
                        icon: Icons.ios_share,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )
            : Positioned(
                top: 16,
                right: 16,
                child: Tooltip(
                  message: 'back'.tr,
                  child: _CircularIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
        Positioned(
          bottom: 16,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  '4.8 (120)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }
}