import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/features/home/models/cat_service.dart';

class BrandsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Brand> brands = [];
  bool isLoading = false;
  String? errorMessage;
  late final CatService category;

  BrandsController({required this.category});

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading = true;
      update();

      final snapshot = await _firestore
          .collection('brands')
          .where('cat', isEqualTo: category.name)
          //.orderBy('name')
          .get();

      brands
        ..clear()
        ..addAll(snapshot.docs.map(Brand.fromDocument));

      errorMessage = null;
    } catch (e, stackTrace) {
      errorMessage = e.toString();
      debugPrint('Failed to fetch brands: $e');
      debugPrint(stackTrace.toString());
    } finally {
      print("Fetched ${brands.length} brands for category $category");
      isLoading = false;
      update();
    }
  }
}
