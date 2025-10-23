import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/brand_details/controllers/brand_details_controller.dart';
import 'package:shop_app/features/brand_details/controllers/save_order_controller.dart';
import 'package:shop_app/features/brand_details/widgets/brand_info_card.dart';
import 'package:shop_app/features/brand_details/widgets/brand_info_card_widget.dart';
import 'package:shop_app/features/brand_details/widgets/brand_header_widget.dart';
import 'package:shop_app/features/brand_details/widgets/checkout_bar.dart';
import 'package:shop_app/features/brand_details/widgets/tabs_bar_widget.dart';
import 'package:shop_app/features/brand_details/widgets/service_categories_chips_widget.dart';
import 'package:shop_app/features/brand_details/widgets/services_list_widget.dart';
import 'package:shop_app/features/brand_details/widgets/packages_list_widget.dart';
import 'package:shop_app/features/location/service/location_navigator.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';
import 'package:shop_app/features/checkout/checkout_view.dart';

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
		// Ensure TabsBarController is initialized
		Get.put(TabsBarController());
		// Initialize SaveOrderController
		Get.put(SaveOrderController());
	}

	@override
	void dispose() {
		if (Get.isRegistered<BrandDetailsController>(tag: widget.brand.id)) {
			Get.delete<BrandDetailsController>(tag: widget.brand.id);
		}
		if (Get.isRegistered<TabsBarController>()) {
			Get.delete<TabsBarController>();
		}
		if (Get.isRegistered<SaveOrderController>()) {
			Get.delete<SaveOrderController>();
		}
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: backgroundColor ,
			body: SafeArea(
				child: GetBuilder<BrandDetailsController>(
					tag: widget.brand.id,
					builder: (controller) {
						return RefreshIndicator(
							color: buttonColor ,
							onRefresh: controller.fetchServices,
							child: CustomScrollView(
								physics: const AlwaysScrollableScrollPhysics(),
								slivers: [
									SliverToBoxAdapter(child: BrandHeaderWidget(brand: widget.brand)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: BrandInfoCard(brand: widget.brand),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 20)),
									SliverToBoxAdapter(
										child: Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20),
											child: BrandInfoWidget(brand: widget.brand, controller: controller),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 9)),
									const SliverToBoxAdapter(
										child: Padding(
											padding: EdgeInsets.symmetric(horizontal: 20),
											child: TabsBarWidget(),
										),
									),
									const SliverToBoxAdapter(child: SizedBox(height: 18)),
									// Conditional content based on selected tab
									GetBuilder<TabsBarController>(
										builder: (tabController) {
											final isServicesTab = tabController.selectedTab.value == 0;
											if (isServicesTab) {
												// Services tab - return multiple slivers
												return SliverMainAxisGroup(
													slivers: [
														SliverToBoxAdapter(
															child: Padding(
																padding: const EdgeInsets.symmetric(horizontal: 20),
																child: ServiceCategoriesChipsWidget(controller: controller),
															),
														),
														const SliverToBoxAdapter(child: SizedBox(height: 18)),
														SliverToBoxAdapter(
															child: Padding(
																padding: const EdgeInsets.symmetric(horizontal: 20),
																child: ServicesListWidget(
																	controller: controller,
																	services: controller.services,
																	accentColor: const Color(0xffE28743),
																),
															),
														),
													],
												);
											} else {
												// Packages tab content
												return SliverToBoxAdapter(
													child: Padding(
														padding: const EdgeInsets.symmetric(horizontal: 20),
														child: controller.isLoadingPackages
															? const Center(
																	child: Padding(
																		padding: EdgeInsets.all(40),
																		child: CircularProgressIndicator(),
																	),
																)
															: PackagesListWidget(
																	controller: controller,
																	packages: controller.packages,
																	accentColor: const Color(0xffE28743),
																),
													),
												);
											}
										},
									),
								],
							),
						);
					},
				),
			),
			bottomNavigationBar: GetBuilder<TabsBarController>(
				builder: (tabController) => GetBuilder<BrandDetailsController>(
					tag: widget.brand.id,
					builder: (controller) => CheckoutBar(
						accentColor: buttonColor,
						controller: controller,
						tabController: tabController,
						brand: widget.brand,
					),
				),
			),
			
			
		);
	}
}

