import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/brand_details/brand_details.dart';


class BrandCard extends StatelessWidget {
	final Brand brand;

	const BrandCard({super.key, required this.brand});

	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: () => Get.to(() => BrandDetailsView(brand: brand)),
			borderRadius: BorderRadius.circular(16),
			child: Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.06),
						blurRadius: 12,
						offset: const Offset(0, 5),
					),
				],
			),
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						_BrandThumbnail(imageUrl: brand.image),
						const SizedBox(width: 16),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										brand.name,
										style: const TextStyle(
											fontSize: 17,
											fontWeight: FontWeight.w700,
										),
									),
									const SizedBox(height: 6),
									Text(
										brand.description,
										maxLines: 3,
										overflow: TextOverflow.ellipsis,
										style: const TextStyle(
											fontSize: 13.5,
											color: Colors.black54,
											height: 1.35,
										),
									),
									const SizedBox(height: 12),
									Wrap(
										spacing: 8,
										runSpacing: 6,
										children: [
											_PillTag(text: brand.category),
											_PillTag(text: brand.categoryEn),
										],
									),
								],
							),
						),
						const SizedBox(width: 12),
						Icon(
							Icons.arrow_forward_ios,
							size: 16,
							color: Colors.grey[500],
						),
					],
				),
			),
		),
		);
	}
}


class _BrandThumbnail extends StatelessWidget {
	final String imageUrl;

	const _BrandThumbnail({required this.imageUrl});

	@override
	Widget build(BuildContext context) {
		return ClipRRect(
			borderRadius: BorderRadius.circular(14),
			child: Container(
				height: 90,
				width: 90,
				color: Colors.grey[200],
				child: imageUrl.isEmpty
					? const Icon(Icons.storefront, size: 36, color: Colors.grey)
					: Image.network(
						imageUrl,
						fit: BoxFit.cover,
						errorBuilder: (_, __, ___) => const Icon(
							Icons.storefront,
							size: 36,
							color: Colors.grey,
						),
					),
			),
		);
	}
}

class _PillTag extends StatelessWidget {
	final String text;

	const _PillTag({required this.text});

	@override
	Widget build(BuildContext context) {
		if (text.isEmpty) return const SizedBox.shrink();

		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
			decoration: BoxDecoration(
				color: buttonColor is Color
						? (buttonColor as Color).withOpacity(0.12)
						: const Color(0xFFE47B39).withOpacity(0.12),
				borderRadius: BorderRadius.circular(20),
			),
			child: Text(
				text,
				style: TextStyle(
					fontSize: 12,
					fontWeight: FontWeight.w600,
					color: buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39),
				),
			),
		);
	}}