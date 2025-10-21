# Search Feature - Quick Start Guide

## How to Use

### 1. Navigate to Search Screen

```dart
import 'package:shop_app/features/search/search_view.dart';

// From anywhere in your app
Get.to(() => const SearchView());
```

### 2. Add Search Button to AppBar

```dart
AppBar(
  title: Text('home'.tr),
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => Get.to(() => const SearchView()),
    ),
  ],
)
```

### 3. Add Search to Drawer Menu

```dart
ListTile(
  leading: Icon(Icons.search, color: primaryColor),
  title: Text('search'.tr),
  onTap: () {
    Get.back(); // Close drawer
    Get.to(() => const SearchView());
  },
)
```

### 4. Add Search FAB (Floating Action Button)

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(
    onPressed: () => Get.to(() => const SearchView()),
    backgroundColor: primaryColor,
    child: const Icon(Icons.search),
  ),
  body: YourBody(),
)
```

## What Users Can Search For

### ✅ Brand Names (English)
- "Nike"
- "Adidas"
- "Apple"
- "Samsung"

### ✅ Brand Names (Arabic)
- "نايك"
- "أديداس"
- "أبل"
- "سامسونج"

### ✅ Category Names (English)
- "Electronics"
- "Fashion"
- "Sports"
- "Food"

### ✅ Category Names (Arabic)
- "إلكترونيات"
- "أزياء"
- "رياضة"
- "طعام"

## Search Behavior

### Real-time Search
- Results appear **instantly** as you type
- No need to press "Enter" or "Search" button
- Clears automatically when you clear the text

### Case Insensitive
```dart
"NIKE" = "nike" = "Nike" = "نايك" ✅
```

### Partial Matching
```dart
"nik" → finds "Nike" ✅
"سام" → finds "سامسونج" ✅
```

### Multi-field Search
Searches in **4 fields simultaneously**:
1. `name` (English brand name)
2. `nameAr` (Arabic brand name)
3. `category` (English category)
4. `categoryEn` (English category alternate)

## UI States

### 1. Initial State (Before Search)
- 🔍 Large search icon
- "Start Searching" message
- Search tips card with 3 helpful hints

### 2. Loading State
- ⏳ Circular progress indicator
- "Loading brands..." message

### 3. Results State
- 📊 Results count header
- List of matching brands
- BrandCard components

### 4. Empty State
- 🔍❌ "No results found" message
- Shows what you searched for
- Suggestion to try different keywords

### 5. Error State
- ⚠️ Error icon
- Error message
- "Retry" button

## Controller Methods (Advanced)

If you need to control search programmatically:

```dart
// Get controller instance
final controller = Get.find<BrandSearchController>();

// Perform search
controller.searchBrands('nike');

// Clear search
controller.clearSearch();

// Get results count
int count = controller.resultsCount;

// Check if has results
bool hasResults = controller.hasResults;

// Retry after error
controller.retry();
```

## Customization Examples

### Change Search Placeholder
```dart
// In search_view.dart
hintText: 'your_custom_text'.tr,
```

### Add More Search Fields
```dart
// In search_controller.dart, searchBrands() method
searchResults = allBrands.where((brand) {
  final name = brand.name.toLowerCase();
  final nameAr = brand.nameAr.toLowerCase();
  final description = brand.description.toLowerCase(); // NEW
  
  return name.contains(lowerQuery) ||
         nameAr.contains(lowerQuery) ||
         description.contains(lowerQuery); // NEW
}).toList();
```

### Change Theme Colors
```dart
// Already uses app theme colors from app_colors.dart
primaryColor      // Main accent color
backgroundColor   // Background color
txtColor         // Text color
buttonColor      // Button color
```

## Performance Tips

### ✅ Already Optimized
- Loads all brands once on init
- Searches in memory (very fast)
- Only rebuilds when needed (GetBuilder)
- Lazy loading with ListView.builder

### ⚠️ Large Datasets
If you have 1000+ brands, consider:

1. **Server-side search** (Firestore queries)
2. **Pagination** (Load more as user scrolls)
3. **Debouncing** (Wait before searching)

## Troubleshooting

### Issue: No Results Found
**Solutions:**
- ✅ Check if brands exist in Firestore
- ✅ Verify field names match: `name`, `nameAr`, `category`, `categoryEn`
- ✅ Try simpler search terms
- ✅ Check network connection

### Issue: Loading Forever
**Solutions:**
- ✅ Check Firestore connection
- ✅ Verify collection name is "brands"
- ✅ Check Firestore rules allow read access
- ✅ Look at error logs

### Issue: Not Showing Arabic Results
**Solutions:**
- ✅ Verify `nameAr` field exists in Firestore
- ✅ Check Brand model includes `nameAr`
- ✅ Ensure proper UTF-8 encoding

### Issue: Search Not Working
**Solutions:**
- ✅ Verify BrandSearchController is initialized
- ✅ Check if `loadAllBrands()` completed
- ✅ Look for errors in debug console
- ✅ Try retry button if error state shown

## Integration Checklist

- [ ] Import SearchView where needed
- [ ] Add navigation to search (button/menu/fab)
- [ ] Test with English brand names
- [ ] Test with Arabic brand names
- [ ] Test with category names
- [ ] Test empty search
- [ ] Test error handling
- [ ] Test on different screen sizes
- [ ] Test with slow network
- [ ] Verify BrandCard navigation works

## Example: Complete Integration

```dart
// home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/search/search_view.dart';
import 'package:shop_app/core/res/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        backgroundColor: appBarColor,
        actions: [
          // Search button in AppBar
          IconButton(
            icon: Icon(Icons.search, color: primaryColor),
            onPressed: () => Get.to(() => const SearchView()),
            tooltip: 'search'.tr,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search card in body
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => Get.to(() => const SearchView()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Text(
                      'search_brands'.tr,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Your other home content
          Expanded(
            child: YourHomeContent(),
          ),
        ],
      ),
    );
  }
}
```

## Screenshot Guide

### Initial State
```
┌──────────────────────────────────────┐
│  ← Search                            │
├──────────────────────────────────────┤
│  🔍 Search for brands...             │
├──────────────────────────────────────┤
│                                      │
│         🔍                           │
│                                      │
│    Start Searching                   │
│                                      │
│  Search for your favorite brands     │
│  by name or category                 │
│                                      │
│  ┌────────────────────────────────┐ │
│  │ 💡 Search Tips                 │ │
│  │ • Search by brand name AR/EN   │ │
│  │ • Try searching by category    │ │
│  │ • Use simple keywords          │ │
│  └────────────────────────────────┘ │
│                                      │
└──────────────────────────────────────┘
```

### With Results
```
┌──────────────────────────────────────┐
│  ← Search                            │
├──────────────────────────────────────┤
│  🔍 nike                          ✕  │
├──────────────────────────────────────┤
│  🔍 3 results found for "nike"       │
├──────────────────────────────────────┤
│  ┌────────────────────────────────┐ │
│  │ [IMG] Nike                   → │ │
│  │ Sports & Lifestyle Brand       │ │
│  │ [Sports]                       │ │
│  └────────────────────────────────┘ │
│                                      │
│  ┌────────────────────────────────┐ │
│  │ [IMG] Nike Air                → │ │
│  │ Premium Shoes Collection       │ │
│  │ [Footwear]                     │ │
│  └────────────────────────────────┘ │
│                                      │
└──────────────────────────────────────┘
```

### No Results
```
┌──────────────────────────────────────┐
│  ← Search                            │
├──────────────────────────────────────┤
│  🔍 xyz123                        ✕  │
├──────────────────────────────────────┤
│                                      │
│         🔍❌                          │
│                                      │
│    No Results Found                  │
│                                      │
│  No results for "xyz123"             │
│                                      │
│  ┌────────────────────────────────┐ │
│  │ ℹ️  Try different or more      │ │
│  │    general keywords            │ │
│  └────────────────────────────────┘ │
│                                      │
└──────────────────────────────────────┘
```

## That's It! 🎉

Your search feature is ready to use. Users can now easily search for brands by name or category in both Arabic and English with a beautiful, professional interface.

**Need help?** Check `SEARCH_FEATURE_GUIDE.md` for detailed documentation.
