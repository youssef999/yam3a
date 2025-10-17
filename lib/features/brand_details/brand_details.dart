import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/brand_details/brand_controller.dart';

class BrandDetailsView extends StatefulWidget {
	const BrandDetailsView({super.key, required this.brand});

	final Brand brand;

	@override
	State<BrandDetailsView> createState() => _BrandDetailsViewState();
}

class _BrandDetailsViewState extends State<BrandDetailsView> {
	@override
	void initState() {
		super.initState();
		Get.put(BrandDetailsController(brand: widget.brand), tag: widget.brand.id);
	}

	@override
	void dispose() {
		if (Get.isRegistered<BrandDetailsController>(tag: widget.brand.id)) {
			Get.delete<BrandDetailsController>(tag: widget.brand.id);
		}
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final colorScheme = Theme.of(context).colorScheme;

		return Scaffold(
			backgroundColor: backgroundColor is Color
					? backgroundColor as Color
					: colorScheme.surfaceVariant.withOpacity(.15),
			body: SafeArea(
				child: GetBuilder<BrandDetailsController>(
					tag: widget.brand.id,
					builder: (controller) {
						return RefreshIndicator(
							color: buttonColor is Color
									? buttonColor as Color
									: colorScheme.primary,
							onRefresh: controller.fetchServices,
							child: CustomScrollView(
								physics: const AlwaysScrollableScrollPhysics(),
								slivers: [
									SliverToBoxAdapter(child: _buildHeader(context)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: _BrandInfoCard(brand: widget.brand),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 20)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: _QuickActionsRow(brand: widget.brand),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 24)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 16),
											child: _HighlightsStrip(controller: controller),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 24)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: _TabsBar(),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 18)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: _ServiceCategoriesChips(controller: controller),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 18)),
									if (controller.isLoading && controller.services.isEmpty)
										const SliverFillRemaining(
											hasScrollBody: false,
											child: Center(child: CircularProgressIndicator()),
										)
									else if (controller.errorMessage != null &&
											controller.services.isEmpty)
										SliverFillRemaining(
											hasScrollBody: false,
											child: Center(
												child: Padding(
													padding: const EdgeInsets.symmetric(horizontal: 24),
													child: Text(
														controller.errorMessage ?? '',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Colors.red.shade400,
															fontSize: 14,
															height: 1.4,
														),
													),
												),
											),
										)
									else if (controller.services.isEmpty)
										SliverFillRemaining(
											hasScrollBody: false,
											child: Center(
												child: Text(
													'no_services_found'.tr,
													style: const TextStyle(
														fontSize: 14,
														fontWeight: FontWeight.w500,
													),
												),
											),
										)
									else
										SliverPadding(
											padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
											sliver: SliverList.separated(
												itemCount: controller.services.length,
												separatorBuilder: (_, __) => const SizedBox(height: 14),
												itemBuilder: (_, index) => _ServiceCard(
													service: controller.services[index],
													accentColor: buttonColor is Color
															? buttonColor as Color
															: const Color(0xFFE47B39),
												),
											),
										),
								],
							),
						);
					},
				),
			),
			bottomNavigationBar: _CheckoutBar(
				accentColor: buttonColor is Color
						? buttonColor as Color
						: const Color(0xFFE47B39),
			),
		);
	}

	Widget _buildHeader(BuildContext context) {
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
						image: widget.brand.image.isEmpty
								? null
								: DecorationImage(
										image: NetworkImage(widget.brand.image),
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
				Positioned(
					top: 16,
					left: 16,
					child: _CircularIconButton(
						icon: Icons.arrow_back_ios_new,
						onTap: () => Navigator.of(context).maybePop(),
					),
				),
				Positioned(
					top: 16,
					right: 16,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.end,
						children: [
							_CircularIconButton(
								icon: Icons.phone_outlined,
								onTap: () {},
							),
							const SizedBox(height: 12),
							_CircularIconButton(
								icon: Icons.chat_bubble_outline,
								onTap: () {},
							),
							const SizedBox(height: 12),
							_CircularIconButton(
								icon: Icons.ios_share,
								onTap: () {},
							),
						],
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

class _BrandInfoCard extends StatelessWidget {
	const _BrandInfoCard({required this.brand});

	final Brand brand;

	@override
	Widget build(BuildContext context) {
		final accentColor = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(24),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.05),
						blurRadius: 18,
						offset: const Offset(0, 12),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							CircleAvatar(
								radius: 32,
								backgroundColor: Colors.grey.shade200,
								backgroundImage:
										brand.image.isNotEmpty ? NetworkImage(brand.image) : null,
								child: brand.image.isEmpty
										? const Icon(Icons.storefront, size: 32, color: Colors.grey)
										: null,
							),
							const SizedBox(width: 16),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											brand.name,
											style: const TextStyle(
												fontSize: 20,
												fontWeight: FontWeight.w700,
											),
										),
										const SizedBox(height: 6),
										Row(
											children: [
												Icon(Icons.location_on_outlined,
														size: 18, color: accentColor),
												const SizedBox(width: 4),
												Expanded(
													child: Text(
														brand.descriptionEn.isNotEmpty
																? brand.descriptionEn
																: brand.description,
														style: const TextStyle(
															fontSize: 13,
															color: Colors.black54,
														),
													),
												),
											],
										),
									],
								),
							),
							Column(
								children: [
									Icon(Icons.facebook, color: Colors.blue.shade600, size: 24),
									const SizedBox(height: 8),
									Icon(Icons.camera_alt_outlined,
											color: Colors.pink.shade400, size: 22),
								],
							),
						],
					),
					const SizedBox(height: 16),
					const Divider(height: 1),
					const SizedBox(height: 16),
								const Wrap(
									spacing: 12,
									runSpacing: 12,
									children: [
							_OutlinedChip(icon: Icons.public, label: 'Visit Website'),
							_OutlinedChip(icon: Icons.bookmark_border, label: 'Save Vendor'),
							_OutlinedChip(icon: Icons.rate_review_outlined, label: 'Write Review'),
						],
					),
				],
			),
		);
	}
}

class _QuickActionsRow extends StatelessWidget {
	const _QuickActionsRow({required this.brand});

	final Brand brand;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				_QuickActionTile(
					title: 'Delivery Charges',
					value: 'BD0',
					icon: Icons.local_shipping_outlined,
					accentColor: accent,
				),
				_QuickActionTile(
					title: 'Minimum Days',
					value: '3 Days',
					icon: Icons.timer_outlined,
					accentColor: accent,
				),
				_QuickActionTile(
					title: 'Check Availability',
					value: 'Dates',
					icon: Icons.event_available_outlined,
					accentColor: accent,
				),
				_QuickActionTile(
					title: 'Advance',
					value: '10%',
					icon: Icons.payments_outlined,
					accentColor: accent,
				),
			],
		);
	}
}

class _HighlightsStrip extends StatelessWidget {
	const _HighlightsStrip({required this.controller});

	final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		final price = controller.startingPrice;
		final minDays = controller.minPreparationDays;

		return Container(
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
						label: 'Starting from',
						value: price == null ? '--' : 'BD${price.toStringAsFixed(2)}',
						accentColor: accent,
					),
					_HighlightDivider(accent: accent),
					_HighlightItem(
						icon: Icons.schedule,
						label: 'Preparation',
						value: minDays == null ? '--' : '$minDays days',
						accentColor: accent,
					),
					_HighlightDivider(accent: accent),
					_HighlightItem(
						icon: Icons.handshake_outlined,
						label: 'Certifications',
						value: 'Verified',
						accentColor: accent,
					),
				],
			),
		);
	}
}

class _TabsBar extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: Colors.grey.shade200),
			),
			child: Row(
				children: [
					Expanded(
						child: Container(
							padding: const EdgeInsets.symmetric(vertical: 14),
							decoration: BoxDecoration(
								color: accent,
								borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
							),
							alignment: Alignment.center,
							child: const Text(
								'Services',
								style: TextStyle(
									color: Colors.white,
									fontWeight: FontWeight.w700,
								),
							),
						),
					),
					Expanded(
						child: Container(
							padding: const EdgeInsets.symmetric(vertical: 14),
							alignment: Alignment.center,
							child: Text(
								'Packages',
								style: TextStyle(
									color: Colors.grey.shade600,
									fontWeight: FontWeight.w600,
								),
							),
						),
					),
				],
			),
		);
	}
}

class _ServiceCategoriesChips extends StatelessWidget {
	const _ServiceCategoriesChips({required this.controller});

	final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		final categories = controller.serviceCategories;
		if (categories.isEmpty) {
			return const SizedBox.shrink();
		}

		return Wrap(
			spacing: 12,
			runSpacing: 12,
			children: categories
					.map(
						(category) => Container(
							padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
							decoration: BoxDecoration(
								color: accent.withOpacity(.12),
								borderRadius: BorderRadius.circular(24),
							),
							child: Text(
								category,
								style: TextStyle(
									color: accent,
									fontWeight: FontWeight.w600,
								),
							),
						),
					)
					.toList(),
		);
	}
}

class _ServiceCard extends StatelessWidget {
	const _ServiceCard({required this.service, required this.accentColor});

	final Service service;
	final Color accentColor;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(18),
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
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											service.name.isNotEmpty ? service.name : service.nameEn,
											style: const TextStyle(
												fontSize: 17,
												fontWeight: FontWeight.w700,
											),
										),
										const SizedBox(height: 6),
										Text(
											service.description.isNotEmpty
													? service.description
													: service.descriptionEn,
											maxLines: 3,
											overflow: TextOverflow.ellipsis,
											style: const TextStyle(
												fontSize: 13.5,
												color: Colors.black54,
												height: 1.4,
											),
										),
									],
								),
							),
							const SizedBox(width: 12),
							Container(
								padding:
										const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
								decoration: BoxDecoration(
									color: accentColor.withOpacity(.14),
									borderRadius: BorderRadius.circular(16),
								),
								child: Text(
									'BD${service.price.toStringAsFixed(2)}',
									style: TextStyle(
										color: accentColor,
										fontWeight: FontWeight.w700,
									),
								),
							),
						],
					),
					const SizedBox(height: 14),
					Row(
						children: [
							Icon(Icons.timer_outlined, size: 18, color: accentColor),
							const SizedBox(width: 6),
							Text(
								'${service.minDays} days preparation',
								style: const TextStyle(fontSize: 12.5, color: Colors.black54),
							),
							const Spacer(),
							TextButton.icon(
								onPressed: () {},
								icon: const Icon(Icons.book_online_outlined, size: 18),
								label: Text('book_now'.tr),
								style: TextButton.styleFrom(
									foregroundColor: accentColor,
								),
							),
						],
					),
				],
			),
		);
	}
}

class _CheckoutBar extends StatelessWidget {
	const _CheckoutBar({required this.accentColor});

	final Color accentColor;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
			decoration: BoxDecoration(
				color: Colors.white,
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.05),
						blurRadius: 16,
						offset: const Offset(0, -6),
					),
				],
			),
			child: SizedBox(
				width: double.infinity,
				child: ElevatedButton(
					onPressed: () {},
					style: ElevatedButton.styleFrom(
						backgroundColor: accentColor,
						padding: const EdgeInsets.symmetric(vertical: 16),
						shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(16),
						),
					),
					child: const Text(
						'CHECKOUT',
						style: TextStyle(
							fontSize: 16,
							fontWeight: FontWeight.w700,
							letterSpacing: 0.6,
						),
					),
				),
			),
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
				child: Icon(icon, color: Colors.grey.shade800, size: 20),
			),
		);
	}
}

class _OutlinedChip extends StatelessWidget {
	const _OutlinedChip({required this.icon, required this.label});

	final IconData icon;
	final String label;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
			decoration: BoxDecoration(
				border: Border.all(color: accent.withOpacity(.4)),
				borderRadius: BorderRadius.circular(14),
			),
			child: Row(
				mainAxisSize: MainAxisSize.min,
				children: [
					Icon(icon, size: 18, color: accent),
					const SizedBox(width: 8),
					Text(
						label,
						style: TextStyle(
							color: accent,
							fontWeight: FontWeight.w600,
						),
					),
				],
			),
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
						Icon(icon, size: 22, color: accentColor),
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
					Icon(icon, color: accentColor, size: 22),
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
