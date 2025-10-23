


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/brand_details/controllers/brand_details_controller.dart';

class BrandInfoWidget extends StatelessWidget {
	const BrandInfoWidget({super.key, required this.brand, required this.controller});

	final Brand brand;
	final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		final price = controller.startingPrice;

		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(14),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withValues(alpha: 0.06),
						blurRadius: 12,
						offset: const Offset(0, 3),
					),
				],
			),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: [
					_CompactInfoTile(
						icon: Icons.local_shipping_outlined,
						label: 'delivery_charges'.tr,
						value: 'BD0',
						accentColor: accent,
					),
					_CompactDivider(accent: accent),
					_CompactInfoTile(
						icon: Icons.price_change_outlined,
						label: 'starting_from'.tr,
						value: price == null ? '--' : 'BD${price.toStringAsFixed(2)}',
						accentColor: accent,
					),
					_CompactDivider(accent: accent),
					_CompactInfoTile(
						icon: Icons.verified_user_outlined,
						label: 'certifications'.tr,
						value: 'verified'.tr,
						accentColor: accent,
					),
				],
			),
		);
	}
}

class _CompactInfoTile extends StatelessWidget {
	const _CompactInfoTile({
		required this.icon,
		required this.label,
		required this.value,
		required this.accentColor,
	});

	final IconData icon;
	final String label;
	final String value;
	final Color accentColor;

	@override
	Widget build(BuildContext context) {
		return Expanded(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Icon(icon, size: 20, color: accentColor),
					const SizedBox(height: 6),
					Text(
						label,
						textAlign: TextAlign.center,
						style: const TextStyle(
							fontSize: 11,
							color: Colors.grey,
							fontWeight: FontWeight.w500,
						),
						maxLines: 1,
						overflow: TextOverflow.ellipsis,
					),
					const SizedBox(height: 4),
					Text(
						value,
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 13,
							fontWeight: FontWeight.w700,
							color: txtColor,
						),
						maxLines: 1,
						overflow: TextOverflow.ellipsis,
					),
				],
			),
		);
	}
}

class _CompactDivider extends StatelessWidget {
	const _CompactDivider({required this.accent});

	final Color accent;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: 1,
			height: 40,
			margin: const EdgeInsets.symmetric(horizontal: 8),
			color: accent.withValues(alpha: 0.15),
		);
	}
}