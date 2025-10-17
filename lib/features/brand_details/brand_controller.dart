import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/models/service.dart';

class BrandDetailsController extends GetxController {
	BrandDetailsController({required this.brand});

	final FirebaseFirestore _firestore = FirebaseFirestore.instance;
	final Brand brand;

	final List<Service> services = [];
	bool isLoading = false;
	String? errorMessage;

	@override
	void onInit() {
		super.onInit();
		fetchServices();
	}

	Future<void> fetchServices() async {
		try {
			isLoading = true;
			update();

			final snapshot = await _firestore
					.collection('services')
					.where('brandName', isEqualTo: brand.name)
					.get();

			services
				..clear()
				..addAll(snapshot.docs.map(Service.fromDocument));

			errorMessage = null;
			} catch (e, stackTrace) {
				errorMessage = e.toString();
			debugPrint('Brand services fetch failed: $e');
			debugPrint(stackTrace.toString());
		} finally {
			isLoading = false;
			update();
		}
	}

	double? get startingPrice {
		if (services.isEmpty) return null;
		return services.map((service) => service.price).reduce(min);
	}

	int? get minPreparationDays {
		if (services.isEmpty) return null;
		return services.map((service) => service.minDays).reduce(min);
	}

	List<String> get serviceCategories {
		final categories = <String>{};
		for (final service in services) {
			if (service.categoryEn.isNotEmpty) categories.add(service.categoryEn);
			if (service.category.isNotEmpty) categories.add(service.category);
		}
		return categories.toList();
	}
}
