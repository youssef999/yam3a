import 'package:flutter/material.dart';
import 'package:shop_app/core/res/app_colors.dart';

/// Modern refresh button for AppBar actions
class RefreshActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? tooltip;

  const RefreshActionButton({
    Key? key,
    required this.onPressed,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
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
          onTap: onPressed,
          child:  Icon(
            Icons.refresh_rounded,
            size: 18,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}