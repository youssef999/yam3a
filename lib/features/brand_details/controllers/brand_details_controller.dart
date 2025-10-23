import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
	DateTime? selectedReceiveDate;

	@override
	void onInit() {
		super.onInit();
		fetchServices();
		fetchPackages();
		fetchMinPriceFromFireStore();
	}

  num minValueForOrderPercetage=0;


  fetchMinPriceFromFireStore() async {
    try {
      final snapshot = await _firestore
          .collection('minPrice')
          .doc('qhxZDYbnbBwevwZ7Waku')
          .get();
      
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        minValueForOrderPercetage = data['price'] ?? 0;
      } else {
        minValueForOrderPercetage = 0;
      }
      
      update();
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch min price: $e');
      debugPrint(stackTrace.toString());
      minValueForOrderPercetage = 0;
    }
    print('minValueForOrderPercetage: $minValueForOrderPercetage');
  }

  num totalPriceWithMinValue=0;

  getOrderMinTotal(num totalOrder) {
    if (minValueForOrderPercetage > 0 && totalOrder < minValueForOrderPercetage) {
      totalPriceWithMinValue = totalOrder *(minValueForOrderPercetage / 100);
      //minValueForOrderPercetage;
    } else {
      totalPriceWithMinValue = totalOrder *(minValueForOrderPercetage / 100);
     // totalPriceWithMinValue = totalOrder;
    }
    return totalPriceWithMinValue;
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

	// Date picker functionality
	Future<bool> selectReceiveDate() async {
		final now = DateTime.now();
		final firstDate = now.add(const Duration(days: 1)); // Can't select today or past dates
		final lastDate = now.add(const Duration(days: 365)); // Up to 1 year in future
		
		final pickedDate = await showDatePicker(
			context: Get.context!,
			initialDate: firstDate,
			firstDate: firstDate,
			lastDate: lastDate,
			builder: (context, child) {
				return Theme(
					data: Theme.of(context).copyWith(
						colorScheme: ColorScheme.light(
							primary: const Color(0xffE28743),
							onPrimary: Colors.white,
							onSurface: Colors.black,
						),
					),
					child: child!,
				);
			},
		);
		
		if (pickedDate != null) {
			selectedReceiveDate = pickedDate;
			update();
			return true;
		}
		
		return false;
	}

	String get formattedReceiveDate {
		if (selectedReceiveDate == null) return 'not_selected'.tr;
		
		final day = selectedReceiveDate!.day.toString().padLeft(2, '0');
		final month = selectedReceiveDate!.month.toString().padLeft(2, '0');
		final year = selectedReceiveDate!.year;
		
		return '$day/$month/$year';
	}

	void clearReceiveDate() {
		selectedReceiveDate = null;
		update();
	}


}
