import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';

class BrandSearchController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // State variables
  List<Brand> allBrands = [];
  List<Brand> searchResults = [];
  String searchQuery = '';
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  bool hasSearched = false;

  @override
  void onInit() {
    super.onInit();
    loadAllBrands();
  }

  /// Load all brands from Firestore on initialization
  Future<void> loadAllBrands() async {
    try {
      isLoading = true;
      hasError = false;
      update();

      final snapshot = await _firestore.collection('brands').get();
      
      allBrands = snapshot.docs
          .map((doc) => Brand.fromDocument(doc))
          .toList();

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = 'failed_to_load_brands'.tr;
      update();
    }
  }

  /// Perform search based on query
  void searchBrands(String query) {
    searchQuery = query.trim();
    hasSearched = true;

    if (searchQuery.isEmpty) {
      searchResults.clear();
      update();
      return;
    }

    // Search in both name and nameAr fields (case-insensitive)
    final lowerQuery = searchQuery.toLowerCase();
    
    searchResults = allBrands.where((brand) {
      final name = brand.name.toLowerCase();
      final nameAr = brand.nameAr.toLowerCase();
      final category = brand.category.toLowerCase();
      final categoryEn = brand.categoryEn.toLowerCase();
      
      return name.contains(lowerQuery) ||
             nameAr.contains(lowerQuery) ||
             category.contains(lowerQuery) ||
             categoryEn.contains(lowerQuery);
    }).toList();

    update();
  }

  /// Clear search and reset state
  void clearSearch() {
    searchQuery = '';
    searchResults.clear();
    hasSearched = false;
    update();
  }

  /// Retry loading brands after error
  void retry() {
    loadAllBrands();
  }

  /// Get search results count
  int get resultsCount => searchResults.length;

  /// Check if search has results
  bool get hasResults => searchResults.isNotEmpty;

  /// Check if showing empty state
  bool get showEmptyState => hasSearched && searchQuery.isNotEmpty && searchResults.isEmpty;
}
