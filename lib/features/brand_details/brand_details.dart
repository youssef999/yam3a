import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/contact_pay/premium_view.dart';
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
import 'package:shop_app/core/widgets/floating_yamaa_button.dart';

class BrandDetailsView extends StatefulWidget {
	const BrandDetailsView({super.key, required this.brand});
	final Brand brand;
	@override
	State<BrandDetailsView> createState() => _BrandDetailsViewState();
}

class _BrandDetailsViewState extends State<BrandDetailsView> {
	final ScrollController _scrollController = ScrollController();
	bool _showAppBar = false;

	@override
	void initState() {
		super.initState();
		Get.put(BrandDetailsController(brand: widget.brand), tag: widget.brand.id);
		// Ensure TabsBarController is initialized
		Get.put(TabsBarController());
		// Initialize SaveOrderController
		Get.put(SaveOrderController());
		
		// Listen to scroll changes
		_scrollController.addListener(_onScroll);
	}

	void _onScroll() {
		const threshold = 200.0; // Show app bar after scrolling 200px
		if (_scrollController.offset > threshold && !_showAppBar) {
			setState(() => _showAppBar = true);
		} else if (_scrollController.offset <= threshold && _showAppBar) {
			setState(() => _showAppBar = false);
		}
	}

	PreferredSizeWidget _buildScrollAppBar() {
		return AppBar(
			backgroundColor: appBarColor,
			elevation: 0.5,
			shadowColor: Colors.grey[100],
			leading: Container(
				margin: const EdgeInsets.all(8),
				decoration: BoxDecoration(
					color: Colors.grey[50],
					borderRadius: BorderRadius.circular(8),
				),
				child: IconButton(
					icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700], size: 20),
					onPressed: () => Get.back(),
				),
			),
			title: Text(
				widget.brand.name,
				style: const TextStyle(
					color: Colors.white,
					fontSize: 16,
					fontWeight: FontWeight.w500,
				),
				maxLines: 1,
				overflow: TextOverflow.ellipsis,
			),
			actions: [
        const SizedBox(width:10),
				Container(
				  margin: const EdgeInsets.only(right: 2),
				  decoration: BoxDecoration(
				    color: Colors.grey[50],
				    borderRadius: BorderRadius.circular(8),
				  ),
				  child: IconButton(
				    icon: Icon(Icons.phone, color: Colors.grey[700], size: 19),
				    onPressed: (){
				      	final controller=Get.find<BrandDetailsController>(tag: widget.brand.id);
				              
				              if( controller.userContactPay==false){
				                 print("Need to pay");
				                 AnimatedGet.toWithScale(const PremiumView());
				              }else{
				                 print("Making phone call from app bar");
				                 controller.makePhoneCall();
				              }
				    },
				    tooltip: 'call_brand'.tr,
				  ),
				),
            const SizedBox(width: 10),
				Container(
				  margin: const EdgeInsets.only(right: 2),
				  decoration: BoxDecoration(
				    color: Colors.grey[50],
				    borderRadius: BorderRadius.circular(8),
				  ),
				  child: IconButton(
				    icon: Icon(Icons.email, color: Colors.grey[700], size: 19),
				    onPressed: (){
				      	final controller=Get.find<BrandDetailsController>(tag: widget.brand.id);
				              
				              if( controller.userContactPay==false){
				                 print("Need to pay");
				                 AnimatedGet.toWithScale(const PremiumView());
				              }else{
				                 print("Opening WhatsApp chat from app bar");
				                 controller.openWhatsAppChat();
				              }
				    },
				    tooltip: 'message_brand'.tr,
				  ),
				),
        const SizedBox(width: 10),
			],
		);
	}

	@override
	void dispose() {
		_scrollController.removeListener(_onScroll);
		_scrollController.dispose();
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
			backgroundColor: backgroundColor,
			appBar:
       _showAppBar 
				? PreferredSize(
						preferredSize: const Size.fromHeight(kToolbarHeight),
						child: AnimatedOpacity(
							opacity: _showAppBar ? 1.0 : 0.0,
							duration: const Duration(milliseconds: 200),
							child: _buildScrollAppBar(),
						),
					)
				: null,
			body: SafeArea(
				child: GetBuilder<BrandDetailsController>(
					tag: widget.brand.id,
					builder: (controller) {
						return RefreshIndicator(
							color: buttonColor,
							onRefresh: controller.fetchServices,
							child: CustomScrollView(
								controller: _scrollController,
								physics: const AlwaysScrollableScrollPhysics(),
								slivers: [
									SliverToBoxAdapter(child: BrandHeaderWidget(brand: widget.brand, controller: controller)),
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
														const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for floating button
													],
												);
											} else {
												// Packages tab content
												return SliverMainAxisGroup(
													slivers: [
														SliverToBoxAdapter(
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
														),
														const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for floating button
													],
												);
											}
										},
									),
								],
							),
						);
					},
				),
			).withFloatingYamaaButton(bottomOffset: 120, size: 65),
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

