# Location View Documentation

## Overview
The Location View is a professional, simple interface for users to input and save their location details including city, GPS coordinates, area, floor, apartment number, phone, and notes.

## Features

### 1. **City Selection**
- Clean dropdown with all major cities in Bahrain
- Pre-filled if location was previously saved
- Required field with validation

### 2. **GPS Location**
- "Open Map & Get Location" button to fetch current GPS coordinates
- Automatic permission handling
- Loading state during location fetch
- Success/error feedback
- Displays latitude and longitude after successful fetch

### 3. **Address Details**
- **Area/District**: Required text field for neighborhood or district name
- **Floor**: Optional number field
- **Apartment Number**: Optional number field
- **Phone**: Required phone field with validation
- **Notes**: Optional multiline text field for additional instructions

### 4. **Data Persistence**
- Automatically loads saved location on view open
- Saves all data to local storage using `LocalStorageService`
- Builds complete formatted address from all fields

## Controller (`LocationController`)

### Properties
```dart
// Text Controllers
final areaController = TextEditingController();
final floorController = TextEditingController();
final apartmentController = TextEditingController();
final notesController = TextEditingController();
final phoneController = TextEditingController();

// Location Data
String? selectedCity;
double? latitude;
double? longitude;
bool isLoading = false;
bool isLoadingSavedLocation = false;

// Cities List
final List<String> cities = ['Manama', 'Riffa', 'Muharraq', ...];
```

### Key Methods

#### `loadSavedLocation()`
Loads previously saved location data from local storage.
- Fetches city, coordinates, and location name
- Pre-fills form fields
- Called automatically in `onInit()`

#### `getCurrentLocation()`
Gets current GPS location from device.
- Checks and requests location permission
- Verifies location services are enabled
- Fetches high-accuracy coordinates
- Shows success/error messages
- Updates UI with loading states

#### `selectCity(String? city)`
Updates selected city and rebuilds UI.

#### `validateForm()`
Validates all required fields before saving:
- City selection
- GPS coordinates
- Area name
- Phone number

Returns `true` if valid, shows error message if not.

#### `saveLocation()`
Saves complete location data to local storage.
- Validates form first
- Builds full address from all fields
- Saves to `LocalStorageService`
- Shows success/error feedback
- Returns `bool` indicating success

#### `clearForm()`
Clears all form fields and resets state.

## View (`LocationView`)

### UI Structure

```
AppBar
  └─ "Location" title with back button

Body (SingleChildScrollView)
  ├─ Location Details Section
  │   ├─ Section Header (icon + title)
  │   ├─ City Dropdown
  │   ├─ "Open Map & Get Location" Button
  │   └─ Coordinates Display Card (if available)
  │
  ├─ Address Details Section
  │   ├─ Section Header
  │   ├─ Area Field (required)
  │   ├─ Floor Field (optional)
  │   └─ Apartment Field (optional)
  │
  ├─ Contact Section
  │   ├─ Section Header
  │   ├─ Phone Field (required)
  │   └─ Notes Field (optional, multiline)
  │
  └─ Save Button
```

### Key Widgets

#### `_buildSectionHeader()`
Creates consistent section headers with icon and title.

#### `_buildCityDropdown()`
Professional dropdown with:
- City icon
- Clean white container
- Subtle shadow
- Orange accent color
- Custom styling

#### `_buildMapButton()`
Location button with:
- Loading indicator when fetching
- Location icon
- Clear call-to-action text
- Disabled state handling

#### `_buildCoordinatesCard()`
Success card showing:
- Check icon
- "Location Detected" message
- Latitude value
- Longitude value
- Subtle orange background

## Data Flow

```
1. View Opens
   ↓
2. Controller Initializes
   ↓
3. Load Saved Location (if exists)
   ↓
4. Pre-fill Form Fields
   ↓
5. User Selects City
   ↓
6. User Clicks "Get Location" Button
   ↓
7. Request GPS Permission (if needed)
   ↓
8. Fetch GPS Coordinates
   ↓
9. Display Coordinates Card
   ↓
10. User Fills Address Details
    ↓
11. User Clicks "Save Location"
    ↓
12. Validate Form
    ↓
13. Build Full Address
    ↓
14. Save to Local Storage
    ↓
15. Show Success Message
    ↓
16. Navigate Back
```

## Local Storage Integration

### Saved Fields
```dart
await storage.saveLocationData(
  country: 'Bahrain',
  city: selectedCity,
  latitude: latitude,
  longitude: longitude,
  locationName: areaController.text,
  fullAddress: fullAddress,
);
```

### Retrieved Fields
```dart
final savedCity = storage.userCity;
final savedLat = storage.userLatitude;
final savedLng = storage.userLongitude;
final savedLocationName = storage.userLocationName;
```

## Full Address Format

Built from multiple fields:
```
"Apartment 5, Floor 2, Manama City Center, Manama, Bahrain"
```

Components (if provided):
1. Apartment number
2. Floor number
3. Area/district
4. City
5. Country (always "Bahrain")

## Validation Rules

### Required Fields
- ✅ City selection
- ✅ GPS coordinates (latitude & longitude)
- ✅ Area/district name
- ✅ Phone number

### Optional Fields
- Floor
- Apartment number
- Notes

## UI/UX Features

### Professional Design
- Clean white cards with subtle shadows
- Consistent spacing and padding
- Section headers with icons
- Orange accent color throughout
- Rounded corners (16px radius)

### Loading States
- Circular progress on initial load
- Button loading indicator during GPS fetch
- Disabled states during operations

### User Feedback
- Success snackbars for completed actions
- Error snackbars with clear messages
- Visual confirmation of location detection
- Coordinates display after successful fetch

### Form Validation
- Real-time validation on save
- Clear error messages
- Required field indicators
- Phone number format validation

## Dependencies

### Required Packages
```yaml
dependencies:
  get: ^4.6.5
  geolocator: ^10.0.0
  get_storage: ^2.1.1
```

### Permissions Required

**iOS** (`Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide better service</string>
```

**Android** (`AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

## Usage Example

### Navigate to Location View
```dart
Get.to(() => const LocationView());
```

### Check if Location is Saved
```dart
final hasLocation = storage.hasLocationData();
if (!hasLocation) {
  Get.to(() => const LocationView());
}
```

### Retrieve Saved Location
```dart
final city = storage.userCity;
final lat = storage.userLatitude;
final lng = storage.userLongitude;
final fullAddress = storage.userFullAddress;
```

## Translation Keys

### Required in `local.dart`

**Arabic:**
```dart
'location': 'الموقع',
'location_details': 'تفاصيل الموقع',
'select_city': 'اختر المدينة',
'open_map_get_location': 'افتح الخريطة واحصل على الموقع',
'getting_location': 'جاري الحصول على الموقع...',
'location_detected': 'تم اكتشاف الموقع!',
'latitude': 'خط العرض',
'longitude': 'خط الطول',
'address_details': 'تفاصيل العنوان',
'area_district': 'المنطقة / الحي',
'enter_area': 'أدخل المنطقة',
'floor': 'الطابق',
'enter_floor': 'أدخل الطابق',
'apartment_number': 'رقم الشقة',
'enter_apartment': 'أدخل رقم الشقة',
'contact_notes': 'الاتصال والملاحظات',
'phone': 'رقم الهاتف',
'enter_phone': 'أدخل رقم الهاتف',
'additional_notes': 'ملاحظات إضافية',
'enter_notes': 'أدخل ملاحظات',
'save_location': 'حفظ الموقع',
'please_select_city': 'يرجى اختيار المدينة',
'please_select_location_first': 'يرجى اختيار موقع أولاً',
'area_is_required': 'المنطقة مطلوبة',
'phone_is_required': 'رقم الهاتف مطلوب',
'location_saved': 'تم حفظ الموقع بنجاح',
'location_save_error': 'حدث خطأ أثناء حفظ الموقع',
```

**English:** Similar keys with English values

## Error Handling

### GPS Errors
- Permission denied → Show permission message
- Permission denied forever → Guide to settings
- Location services disabled → Request enable
- Network/timeout errors → Show retry option

### Validation Errors
- Missing city → "Please select city"
- Missing coordinates → "Please select location first"
- Missing area → "Area is required"
- Missing phone → "Phone is required"

### Save Errors
- Storage failure → Show error message with retry

## Testing Checklist

- [ ] City dropdown displays all cities
- [ ] GPS button requests permission
- [ ] Coordinates display after successful location fetch
- [ ] Form validation prevents incomplete submissions
- [ ] All fields save correctly
- [ ] Saved data loads on reopen
- [ ] Full address builds correctly
- [ ] Loading states work properly
- [ ] Error messages display correctly
- [ ] Back button works
- [ ] Phone validation works
- [ ] Multiline notes field expands
- [ ] Success message shows after save
- [ ] Navigation back after successful save

## Future Enhancements

1. **Map Integration**: Add Google Maps/Apple Maps for visual location selection
2. **Address Autocomplete**: Use geocoding API for address suggestions
3. **Multiple Locations**: Save and manage multiple addresses
4. **Location Labels**: Add "Home", "Work", "Other" labels
5. **GPS Accuracy**: Show accuracy level of coordinates
6. **Distance Calculation**: Calculate distance from saved location
7. **Location Sharing**: Share location with others
8. **Offline Support**: Better handling of offline scenarios
