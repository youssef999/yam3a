


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
		final minDays = controller.minPreparationDays;

		return Column(
			children: [
				// Quick Actions Row
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						_QuickActionTile(
							title: 'delivery_charges'.tr,
							value: 'BD0',
							icon: Icons.local_shipping_outlined,
							accentColor: accent,
						),
						_QuickActionTile(
							title: 'advance'.tr,
							value: '10%',
							icon: Icons.payments_outlined,
							accentColor: accent,
						),
					],
				),
				const SizedBox(height: 20),
				// Highlights Strip
				Container(
					padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
					decoration: BoxDecoration(
						color: Colors.white,
						borderRadius: BorderRadius.circular(20),
						boxShadow: [
							BoxShadow(
								color: Colors.black.withOpacity(0.05),
								blurRadius: 16,
								offset: const Offset(0, 10),
							),
						],
					),
					child: Row(
						children: [
							_HighlightItem(
								icon: Icons.price_change_outlined,
								label: 'starting_from'.tr,
								value: price == null ? '--' : 'BD${price.toStringAsFixed(2)}',
								accentColor: accent,
							),
							_HighlightDivider(accent: accent),
							_HighlightItem(
								icon: Icons.schedule,
								label: 'preparation'.tr,
								value: minDays == null ? '--' : '$minDays ${'days'.tr}',
								accentColor: accent,
							),
							_HighlightDivider(accent: accent),
							_HighlightItem(
								icon: Icons.handshake_outlined,
								label: 'certifications'.tr,
								value: 'verified'.tr,
								accentColor: accent,
							),
						],
					),
				),
			],
		);
	}
}

class _QuickActionTile extends StatelessWidget {
	const _QuickActionTile({
		required this.title,
		required this.value,
		required this.icon,
		required this.accentColor,
	});

	final String title;
	final String value;
	final IconData icon;
	final Color accentColor;

	@override
	Widget build(BuildContext context) {
		return Expanded(
			child: Container(
				padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
				margin: const EdgeInsets.symmetric(horizontal: 4),
				decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.circular(18),
					border: Border.all(color: Colors.grey.shade200),
				),
				child: Column(
					children: [
						Icon(icon, size: 22, color: iconColor),
						const SizedBox(height: 10),
						Text(
							title,
							textAlign: TextAlign.center,
							style: const TextStyle(
								fontSize: 12,
								fontWeight: FontWeight.w600,
							),
						),
						const SizedBox(height: 6),
						Text(
							value,
							style: TextStyle(
								fontSize: 12,
								fontWeight: FontWeight.w700,
								color: accentColor,
							),
						),
					],
				),
			),
		);
	}
}

class _HighlightItem extends StatelessWidget {
	const _HighlightItem({
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
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Icon(icon, color: iconColor, size: 22),
					const SizedBox(height: 12),
					Text(
						label,
						style: const TextStyle(
							fontSize: 12,
							color: Colors.black54,
						),
					),
					const SizedBox(height: 6),
					Text(
						value,
						style: const TextStyle(
							fontSize: 14,
							fontWeight: FontWeight.w700,
						),
					),
				],
			),
		);
	}
}

class _HighlightDivider extends StatelessWidget {
	const _HighlightDivider({required this.accent});

	final Color accent;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: 1,
			height: 54,
			margin: const EdgeInsets.symmetric(horizontal: 14),
			color: accent.withOpacity(.2),
		);
	}
}