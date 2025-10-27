import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';

class ReviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReviewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('rate_and_review'.tr),
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}