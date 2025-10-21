# Save Order Controller Documentation

## Overview
The `SaveOrderController` handles checkout functionality for both services and packages in the brand details view. It saves complete order information to Firestore including user data, location, order items, and pricing.

## Features

### 1. **Order Model** (`lib/core/models/order.dart`)
Complete order data structure including:
- User information (email, name, location)
- Order metadata (type, date, status, total price)
- Brand information (name, email, image)
- Order items (services or packages as list of maps)
- GPS coordinates (latitude, longitude)
- Full address details

### 2. **SaveOrderController Methods**

#### `saveOrder()`
Main method that saves order to Firestore.

**Parameters:**
- `orderType`: 'service' or 'package'
- `items`: List<Service> or List<Package>
- `totalPrice`: double
- `brandName`: String
- `brandEmail`: String
- `brandImage`: String
- `notes`: String? (optional)

**Returns:** `Future<bool>` - true if successful

**Features:**
- Fetches user data from local storage (`LocalStorageService`)
- Converts items to map format
- Saves to Firestore 'orders' collection
- Shows success/error snackbar
- Includes loading state management

#### `checkoutServices()`
Simplified wrapper for service orders.

**Usage:**
```dart
final success = await controller.checkoutServices(
  services: selectedServices,
  totalPrice: 150.0,
  brandName: 'Brand Name',
  brandEmail: 'info@brand.com',
  brandImage: 'https://...',
  notes: 'Special instructions', // optional
);
```

#### `checkoutPackages()`
Simplified wrapper for package orders.

**Usage:**
```dart
final success = await controller.checkoutPackages(
  packages: selectedPackages,
  totalPrice: 200.0,
  brandName: 'Brand Name',
  brandEmail: 'info@brand.com',
  brandImage: 'https://...',
);
```

## Integration in BrandDetailsView

### Initialization
Controller is initialized in `initState()`:
```dart
Get.put(SaveOrderController());
```

### Checkout Bar Implementation
The checkout button in `_CheckoutBar` widget:

1. **Checks conditions:**
   - Has selections (services or packages)
   - Not currently loading

2. **On button press:**
   - Calls appropriate checkout method based on tab
   - Passes all selected items with brand info
   - Shows loading indicator during processing
   - Clears selections on success
   - Shows success/error message

3. **UI States:**
   - Disabled: No selections
   - Loading: Shows circular progress indicator
   - Active: Ready to checkout

## Data Flow

```
User Selects Items
    ↓
Clicks Checkout Button
    ↓
SaveOrderController.checkoutServices/Packages()
    ↓
Fetches user data from LocalStorageService
    ↓
Converts items to maps
    ↓
Creates order document with all data
    ↓
Saves to Firestore 'orders' collection
    ↓
Shows success message & clears selections
```

## Firestore Structure

### Collection: `orders`

**Document Fields:**
```json
{
  "userId": "user@example.com",
  "userEmail": "user@example.com",
  "userName": "John Doe",
  "orderType": "service", // or "package"
  "orderDate": "2025-10-21T10:30:00.000Z",
  "totalPrice": 150.0,
  "status": "pending",
  "userCountry": "Bahrain",
  "userCity": "Manama",
  "userLatitude": 26.2285,
  "userLongitude": 50.5860,
  "userLocationName": "Home",
  "userFullAddress": "Building 123, Road 456...",
  "brandName": "Brand Name",
  "brandEmail": "info@brand.com",
  "brandImage": "https://...",
  "items": [
    {
      "id": "service_id",
      "name": "Service Name",
      "nameEn": "Service Name EN",
      "price": 50.0,
      // ... other service/package fields
    }
  ],
  "notes": "Optional notes",
  "createdAt": ServerTimestamp
}
```

## User Data Integration

User information is automatically fetched from `LocalStorageService`:
- Email (userId)
- Name
- Country
- City
- Latitude
- Longitude
- Location name
- Full address

If user data is not available, defaults to:
- Email: "guest@example.com"
- Name: "Guest User"

## Error Handling

1. **Try-Catch Block:** All Firestore operations wrapped
2. **Loading State:** Prevents multiple submissions
3. **User Feedback:** Snackbar messages for success/error
4. **Debug Logging:** Console logs for development

## Usage Example

```dart
// In brand_details.dart
ElevatedButton(
  onPressed: () async {
    final orderController = Get.find<SaveOrderController>();
    
    bool success = await orderController.checkoutServices(
      services: controller.selectedServices,
      totalPrice: controller.totalSelectedPrice,
      brandName: brand.name,
      brandEmail: 'info@${brand.name}.com',
      brandImage: brand.image,
    );
    
    if (success) {
      controller.clearSelectedServices();
    }
  },
  child: Text('Checkout'),
)
```

## Translation Keys Required

Add to `local.dart`:
```dart
'order_placed_successfully': 'Order placed successfully!',
'failed_to_place_order': 'Failed to place order. Please try again.',
```

## Future Enhancements

1. **Order Confirmation Screen:** Navigate to order details after checkout
2. **Payment Integration:** Add payment gateway support
3. **Order Tracking:** Real-time order status updates
4. **Order History:** View past orders
5. **Push Notifications:** Order status notifications
6. **Invoice Generation:** PDF invoice creation
7. **Discount Codes:** Apply promo codes
8. **Delivery Options:** Select delivery time slots

## Testing

Test the following scenarios:
1. ✅ Checkout with services only
2. ✅ Checkout with packages only
3. ✅ Checkout without user data (guest mode)
4. ✅ Network error handling
5. ✅ Loading state during submission
6. ✅ Success message display
7. ✅ Selection clear after success
8. ✅ Button disabled states

## Notes

- Order status defaults to 'pending'
- Server timestamp added automatically
- Brand email derived from brand name if not available
- All prices in BHD (Bahraini Dinar)
- Order items stored as complete serialized objects for reference
