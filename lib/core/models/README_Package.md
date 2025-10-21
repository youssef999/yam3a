# Package Model and Test Data Documentation

This document explains the Package model implementation and how to add test package data to Firestore.

## Package Model Overview

The Package model represents service packages offered by brands, allowing customers to purchase bundled services at discounted prices.

### Package Model Fields

```dart
class Package {
  final String id;                    // Unique package identifier
  final String name;                  // Package name in Arabic
  final String nameEn;                // Package name in English
  final String description;           // Package description in Arabic
  final String descriptionEn;         // Package description in English
  final int minDays;                  // Minimum days to complete package
  final double price;                 // Current discounted price
  final double discountPrice;         // Original price before discount
  final String category;              // Package category in Arabic
  final String categoryEn;            // Package category in English
  final String brandName;             // Associated brand name
  final String brandEmail;            // Brand contact email
  final String brandImage;            // Brand logo/image URL
  final String image;                 // Package-specific image URL
  final List<String> includedServices; // List of service IDs included
  final bool isPopular;               // Mark as popular package
  final int validityDays;             // Package validity period
}
```

### Key Features

- **Discount System**: Supports original price (`discountPrice`) and sale price (`price`)
- **Service Bundling**: Can include multiple services via `includedServices`
- **Multilingual**: Arabic and English support for names and descriptions
- **Brand Association**: Connected to specific brands
- **Popularity Marking**: Can mark packages as popular for UI highlighting
- **Validity Period**: Configurable package expiration

## Brand Controller Integration

### New Package Functionality Added

```dart
// Package data storage
final List<Package> packages = [];
final List<Package> selectedPackages = [];
bool isLoadingPackages = false;

// Package management methods
Future<void> fetchPackages()           // Fetch packages by brand
bool isPackageSelected(Package)        // Check selection status
void togglePackageSelection(Package)   // Toggle package selection
void clearSelectedPackages()           // Clear all selections
double get totalSelectedPackagePrice   // Calculate total price
int get selectedPackagesCount          // Count selected packages
Future<void> addTestPackageData()      // Add test data to Firestore
```

## Test Data Generation

### Sample Package Types

The test data generator creates 5 different package types:

1. **Complete Cleaning Package** (Popular)
   - Price: BD 45.00 (was BD 60.00)
   - Category: Cleaning
   - Duration: 1 day
   - Validity: 30 days

2. **Basic Maintenance Package**
   - Price: BD 80.00 (was BD 100.00)
   - Category: Maintenance  
   - Duration: 2 days
   - Validity: 60 days

3. **Integrated Home Services Package** (Popular)
   - Price: BD 120.00 (was BD 160.00)
   - Category: Integrated Services
   - Duration: 3 days
   - Validity: 90 days

4. **Kitchen Services Package**
   - Price: BD 35.00 (was BD 50.00)
   - Category: Kitchen
   - Duration: 1 day
   - Validity: 45 days

5. **Bathroom Services Package**
   - Price: BD 55.00 (was BD 75.00)
   - Category: Bathrooms
   - Duration: 2 days
   - Validity: 30 days

## Usage Instructions

### Method 1: Using Test UI (Recommended)

1. Navigate to `PackageTestDataScreen`
2. Select a brand from the dropdown
3. Click "Add Package Test Data"
4. Monitor the status for success/failure

### Method 2: Direct Controller Method

```dart
// Create controller with brand
final controller = BrandDetailsController(brand: selectedBrand);

// Add test package data
await controller.addTestPackageData();

// Fetch packages to verify
await controller.fetchPackages();
```

### Method 3: Manual Firestore Integration

```dart
// Direct Firestore access
final packagesCollection = FirebaseFirestore.instance.collection('packages');
final packageData = {
  'name': 'باقة التنظيف الشامل',
  'nameEn': 'Complete Cleaning Package',
  'price': 45.0,
  'discountPrice': 60.0,
  'brandName': 'YourBrandName',
  // ... other fields
};
await packagesCollection.add(packageData);
```

## Database Structure

### Firestore Collection: `packages`

```
packages/
├── {packageId1}/
│   ├── name: "باقة التنظيف الشامل"
│   ├── nameEn: "Complete Cleaning Package"
│   ├── price: 45.0
│   ├── discountPrice: 60.0
│   ├── brandName: "CleanCo"
│   ├── isPopular: true
│   └── ... other fields
├── {packageId2}/
│   └── ... package data
└── ...
```

### Querying Packages by Brand

```dart
final snapshot = await FirebaseFirestore.instance
    .collection('packages')
    .where('brandName', isEqualTo: brandName)
    .get();
```

## Integration with Brand Details

### Brand-Package Connection

Packages are connected to brands through the `brandName` field:

```dart
// In BrandDetailsController
Future<void> fetchPackages() async {
  final snapshot = await _firestore
      .collection('packages')
      .where('brandName', isEqualTo: brand.name)  // Brand connection
      .get();
  
  packages.addAll(snapshot.docs.map(Package.fromDocument));
}
```

### Usage in Brand Details View

```dart
// Display packages for selected brand
ListView.builder(
  itemCount: controller.packages.length,
  itemBuilder: (context, index) {
    final package = controller.packages[index];
    return PackageCard(
      package: package,
      isSelected: controller.isPackageSelected(package),
      onTap: () => controller.togglePackageSelection(package),
    );
  },
);
```

## Helper Methods

### Discount Calculation

```dart
// Built-in helper methods in Package model
double get discountPercentage => ((discountPrice - price) / discountPrice * 100);
bool get hasDiscount => discountPrice > price && discountPrice > 0;

// Usage example
if (package.hasDiscount) {
  Text('${package.discountPercentage.toStringAsFixed(0)}% OFF');
}
```

## Files Created/Modified

### New Files
- `lib/core/models/package.dart` - Package model
- `lib/features/test_data_update/package_test_data_screen.dart` - Test UI

### Modified Files
- `lib/features/brand_details/brand_controller.dart` - Added package functionality

## Next Steps

1. **Create Package UI Components**: Build package cards and list widgets
2. **Add Package Selection Flow**: Implement package booking/purchasing
3. **Service Integration**: Connect packages with actual service IDs
4. **Payment Integration**: Add package payment processing
5. **Admin Panel**: Create package management interface

## Safety Notes

⚠️ **Testing Environment Only**
- Test data functions should only be used in development
- Always backup Firestore data before running test functions
- Verify data in Firebase Console after generation

✅ **Production Ready Features**
- Package model is production-ready
- Database queries are optimized
- Error handling is implemented
- Multilingual support included

The Package system is now ready for integration with your brand details view and can display packages based on the selected brand!