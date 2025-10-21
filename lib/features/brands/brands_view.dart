import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/brands/brands_controller.dart';
import 'package:shop_app/features/brands/widgets/brand_card.dart';
import 'package:shop_app/features/home/models/cat_service.dart';

class BrandsView extends StatefulWidget {
	final CatService category;

	const BrandsView({super.key, required this.category});

	@override
	State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
	late final BrandsController controller;

	@override
	void initState() {
		super.initState();
		controller = Get.put(BrandsController(category: widget.category));
	}

	@override
	void dispose() {
		if (Get.isRegistered<BrandsController>()) {
			Get.delete<BrandsController>();
		}
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      //appbar
			appBar: CustomAppBar(
        Get.locale?.languageCode == 'ar' ? widget.category.nameAr : widget.category.name, 
        true
      ),
      
     
			body: GetBuilder<BrandsController>(
				builder: (ctrl) {
					if (ctrl.isLoading && ctrl.brands.isEmpty) {
						return const Center(child: CircularProgressIndicator());
					}

					if (ctrl.errorMessage != null && ctrl.brands.isEmpty) {
						return Center(
							child: Padding(
								padding: const EdgeInsets.symmetric(horizontal: 24.0),
								child: Text(
									ctrl.errorMessage!,
									textAlign: TextAlign.center,
									style: const TextStyle(color: Colors.red, fontSize: 14),
								),
							),
						);
					}

					if (ctrl.brands.isEmpty) {
						return Center(
							child: Text(
								'no_brands_available'.tr,
								style: const TextStyle(fontSize: 14),
							),
						);
					}

					return RefreshIndicator(
						onRefresh: () => ctrl.fetchBrands(),
						child: ListView.separated(
							padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
							itemCount: ctrl.brands.length,
							separatorBuilder: (_, __) => const SizedBox(height: 12),
							itemBuilder: (context, index) {
								final brand = ctrl.brands[index];
								return BrandCard(brand: brand,);
							},
						),
					);
				},
			),
		);
	
}


}
