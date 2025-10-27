
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/features/home/models/cat_service.dart';
import 'package:shop_app/core/models/service.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<CatService> catServices = [];
  final List<Service> services = [];
  final List<Brand> brands = [];
  bool isLoading = false;
  String? errorMessage;

  List<CatService> get categories => catServices;


  int selectedCategory = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeHomeData();
    //testUpdateBrandsDeliveryTime();
  }


/*************  ✨ Windsurf Command ⭐  *************/
  /// Initialize home data by fetching all categories from Firestore.
/*******  91ac3aa0-0650-4e13-b272-009f6d4cb9a2  *******/  Future<void> _initializeHomeData() async {
    await fetchCatServices();
  }

  Future<void> fetchCatServices() async {
    try {
      isLoading = true;
      update();

      final snapshot = await _firestore
          .collection('catServices')
          .orderBy('name')
          .get();

      catServices
        ..clear()
        ..addAll(snapshot.docs.map(CatService.fromDocument));

      errorMessage = null;
    } catch (e, stackTrace) {
      errorMessage = e.toString();
      debugPrint('Failed to fetch catServices: $e');
      debugPrint(stackTrace.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchServices() async {
    try {
      final snapshot = await _firestore
          .collection('services')
          .orderBy('name')
          .get();

      services
        ..clear()
        ..addAll(snapshot.docs.map(Service.fromDocument));
      update();
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch services: $e');
      debugPrint(stackTrace.toString());
    }
  }

  Future<void> fetchBrands() async {
    try {
      final snapshot = await _firestore
          .collection('brands')
          .orderBy('name')
          .get();

      brands
        ..clear()
        ..addAll(snapshot.docs.map(Brand.fromDocument));
      update();
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch brands: $e');
      debugPrint(stackTrace.toString());
    }
  }

  void selectCategory(int index) {
    if (index < 0 || index >= catServices.length) return;
    selectedCategory = index;
    update();
  }

  Future<void> seedTestServices({bool overwrite = false}) async {
    if (catServices.isEmpty) {
      await fetchCatServices();
    }

    for (final category in catServices) {
      for (var i = 0; i < 10; i++) {
        final serviceId = '${category.id}_service_${i + 1}';
        final docRef = _firestore.collection('services').doc(serviceId);

        if (!overwrite) {
          final exists = await docRef.get();
          if (exists.exists) {
            continue;
          }
        }

        final service = Service(
          id: serviceId,
          image:'',
          name: 'خدمة ${category.name} رقم ${i + 1}',
          nameEn: '${category.name} Service ${i + 1}',
          description:
              'خدمة مميزة ضمن فئة ${category.name} تلبي احتياجات مناسبتك.',
          descriptionEn:
              'Premium ${category.name} service number ${i + 1} crafted for your events.',
          minDays: 1 + (i % 3),
          price: 150 + (i * 35),
          category: category.name,
          categoryEn: category.name,
          brandName: '${category.name} Experts ${i + 1}',
          brandEmail: '${category.id.replaceAll('_', '.')}.$i@yamaa.app',
          brandImage: category.image,
        );

        final data = service.toMap()
          ..['catId'] = category.id
          ..['createdAt'] = FieldValue.serverTimestamp();

        await docRef.set(data, SetOptions(merge: true));
      }
    }

    debugPrint('services seeding complete');
  }

  // Future<void> seedTestBrands({bool overwrite = false}) async {
  //   if (catServices.isEmpty) {
  //     await fetchCatServices();
  //   }

  //   for (final category in catServices) {
  //     for (var i = 0; i < 3; i++) {
  //       final brandId = '${category.id}_brand_${i + 1}';
  //       final docRef = _firestore.collection('brands').doc(brandId);

  //       if (!overwrite) {
  //         final exists = await docRef.get();
  //         if (exists.exists) {
  //           continue;
  //         }
  //       }

  //       final brand = Brand(
  //         id: brandId,
  //         name: '${category.name} Creators ${i + 1}',
  //         nameAr: 'مبدعو ${category.nameAr} ${i + 1}',
  //         image: category.image,
  //         description:
  //             'علامة تقدم حلول ${category.name} مع فريق متخصص وخبرة واسعة.',
  //         descriptionEn:
  //             '${category.name} specialists delivering tailored experiences.',
  //         category: category.name,
  //         categoryEn: category.name,
  //       );

  //       final data = brand.toMap()
  //         ..['catId'] = category.id
  //         ..['createdAt'] = FieldValue.serverTimestamp();

  //       await docRef.set(data, SetOptions(merge: true));
  //     }
  //   }

  //   debugPrint('brands seeding complete');
  // }

  Future<void> updateBrandsWithNameAr() async {
    try {
      debugPrint('Starting to update brands with nameAr...');
      
      final snapshot = await _firestore.collection('brands').get();
      
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final brandName = data['name'] as String? ?? '';
        
        // Generate Arabic name based on existing name
        String nameAr = '';
        if (brandName.contains('Creators')) {
          nameAr = brandName.replaceAll('Creators', 'مبدعو');
        } else if (brandName.contains('Experts')) {
          nameAr = brandName.replaceAll('Experts', 'خبراء');
        } else {
          nameAr = 'علامة $brandName';
        }
        
        // Update the document with nameAr field
        await doc.reference.update({
          'nameAr': nameAr,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        debugPrint('Updated brand ${doc.id} with nameAr: $nameAr');
      }
      
      debugPrint('Successfully updated ${snapshot.docs.length} brands with nameAr');
      
    } catch (e, stackTrace) {
      debugPrint('Failed to update brands with nameAr: $e');
      debugPrint(stackTrace.toString());
    }
  }

  /// Test function to add deliveryTime field to all brands
  Future<void> testUpdateBrandsDeliveryTime() async {
    try {
      debugPrint('🚀 Starting to update all brands with deliveryTime...');
      
      final snapshot = await _firestore.collection('brands').get();
      
      if (snapshot.docs.isEmpty) {
        debugPrint('⚠️ No brands found in collection');
        return;
      }
      
      int updatedCount = 0;
      int errorCount = 0;
      
      for (final doc in snapshot.docs) {
        try {
          // Update the document with deliveryTime field
          await doc.reference.update({
            'deliveryTime': 2,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          
          updatedCount++;
          debugPrint('✅ Updated brand ${doc.id} with deliveryTime: 2');
          
        } catch (e) {
          errorCount++;
          debugPrint('❌ Failed to update brand ${doc.id}: $e');
        }
      }
      
      debugPrint('🎉 Update complete!');
      debugPrint('📊 Total documents: ${snapshot.docs.length}');
      debugPrint('✅ Successfully updated: $updatedCount');
      debugPrint('❌ Failed updates: $errorCount');
      
    } catch (e, stackTrace) {
      debugPrint('💥 Failed to update brands with deliveryTime: $e');
      debugPrint(stackTrace.toString());
    }
  }
}