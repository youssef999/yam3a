// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';

/// Modern Professional AppBar with clean design
PreferredSizeWidget CustomAppBar(
  String title, bool showBackButton, {
  double height = 64,
  VoidCallback? onBackPressed,
  Color? backgroundColor,
  Color? titleColor,
  List<Widget>? actions,
}) {
  // Return empty SizedBox if back button is not needed
  if (!showBackButton) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: SizedBox.shrink(),
    );
  }

  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: Container(
      decoration: BoxDecoration(
        color:  appBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Modern Back Button
              Container(
                width: 45,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onBackPressed ?? () => Get.back(),
                    child:  Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      weight: 700,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              
              // Title Section
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              
              // Action buttons or placeholder for symmetry
              if (actions != null && actions.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                )
              else
                const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    ),
  );
}