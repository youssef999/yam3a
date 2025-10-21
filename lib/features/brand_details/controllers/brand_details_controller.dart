import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/core/models/package.dart';

class BrandDetailsController extends GetxController {
	BrandDetailsController({required this.brand});

	final FirebaseFirestore _firestore = FirebaseFirestore.instance;
	final Brand brand;

	final List<Service> services = [];
	final List<Service> selectedServices = [];
	final List<Package> packages = [];
	final List<Package> selectedPackages = [];
	bool isLoading = false;
	bool isLoadingPackages = false;
	String? errorMessage;

	@override
	void onInit() {
		super.onInit();
		fetchServices();
		fetchPackages();
  
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

	// Checkbox functionality for services
	bool isServiceSelected(Service service) {
		return selectedServices.any((selected) => selected.id == service.id);
	}

	void toggleServiceSelection(Service service) {
		if (isServiceSelected(service)) {
			selectedServices.removeWhere((selected) => selected.id == service.id);
		} else {
			selectedServices.add(service);
		}
		update();
	}

	void clearSelectedServices() {
		selectedServices.clear();
		update();
	}

	double get totalSelectedPrice {
		return selectedServices.fold(0.0, (total, service) => total + service.price);
	}

	int get selectedServicesCount {
		return selectedServices.length;
	}

	// Package functionality
	Future<void> fetchPackages() async {
		try {
			isLoadingPackages = true;
			update();

			final snapshot = await _firestore
					.collection('packages')
					.where('brandName', isEqualTo: brand.name)
					.get();

			packages
				..clear()
				..addAll(snapshot.docs.map(Package.fromDocument));

			} catch (e, stackTrace) {
			debugPrint('Brand packages fetch failed: $e');
			debugPrint(stackTrace.toString());
		} finally {
			isLoadingPackages = false;
			update();
		}
	}

	// Package selection functionality
	bool isPackageSelected(Package package) {
		return selectedPackages.any((selected) => selected.id == package.id);
	}

	void togglePackageSelection(Package package) {
		if (isPackageSelected(package)) {
			selectedPackages.removeWhere((selected) => selected.id == package.id);
		} else {
			selectedPackages.add(package);
		}
		update();
	}

	void clearSelectedPackages() {
		selectedPackages.clear();
		update();
	}

	double get totalSelectedPackagePrice {
		return selectedPackages.fold(0.0, (total, package) => total + package.price);
	}

	int get selectedPackagesCount {
		return selectedPackages.length;
	}




}
