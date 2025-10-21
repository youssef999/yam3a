# Location Navigation Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      BrandDetailsView                            │
│                    (Checkout Button)                             │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            │ User clicks CHECKOUT
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              LocationNavigator.navigateToLocationScreen()        │
│                                                                  │
│  1. Get user email from LocalStorageService                     │
│  2. Query Firestore: user_locations/{email}                     │
│  3. Check if document exists                                    │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                ┌───────────┴───────────┐
                │                       │
        Has Location?             No Location?
                │                       │
                ▼                       ▼
┌───────────────────────────┐  ┌──────────────────────────┐
│  PreviousLocationView     │  │    LocationView          │
│  (Display Saved Location) │  │  (New Location Entry)    │
└───────────┬───────────────┘  └──────────┬───────────────┘
            │                              │
    ┌───────┴────────┐                    │
    │                │                    │
Edit Button    Delete Button              │
    │                │                    │
    │                ▼                    │
    │    ┌─────────────────────┐         │
    │    │ Confirmation Dialog │         │
    │    └──────────┬──────────┘         │
    │               │                    │
    │          Confirm Delete            │
    │               │                    │
    │               ▼                    │
    │    ┌──────────────────────┐       │
    │    │ Delete from:         │       │
    │    │ - Firestore          │       │
    │    │ - Local Storage      │       │
    │    └──────────┬───────────┘       │
    │               │                    │
    │               ▼                    │
    │    ┌──────────────────────┐       │
    │    │ Navigate Back        │       │
    │    └──────────────────────┘       │
    │                                    │
    └──────────────┬─────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │    LocationView      │
        │  (Edit Mode)         │
        │                      │
        │ Form pre-filled with │
        │ existing data        │
        └──────────┬───────────┘
                   │
            User saves location
                   │
                   ▼
        ┌──────────────────────┐
        │ Update Firestore:    │
        │ - All fields         │
        │ - updatedAt          │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │ Update Local Storage │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │ Success Message      │
        │ Navigate Back        │
        └──────────────────────┘


═══════════════════════════════════════════════════════════════════
                        DATA FLOW DETAILS
═══════════════════════════════════════════════════════════════════

┌─────────────────────────────────────────────────────────────────┐
│                    Firestore Structure                           │
├─────────────────────────────────────────────────────────────────┤
│  Collection: user_locations                                      │
│  Document ID: user@example.com                                   │
│                                                                  │
│  {                                                               │
│    "userEmail": "user@example.com",                             │
│    "country": "Bahrain",                                         │
│    "city": "Manama",              ← Translated name             │
│    "cityKey": "city_manama",      ← Translation key             │
│    "latitude": 26.2285,                                          │
│    "longitude": 50.5860,                                         │
│    "area": "Seef District",                                      │
│    "floor": "3",                                                 │
│    "apartment": "12A",                                           │
│    "phone": "+973 1234 5678",                                    │
│    "notes": "Near City Center",                                  │
│    "fullAddress": "Apartment 12A, Floor 3, Seef District...",   │
│    "updatedAt": Timestamp,                                       │
│    "createdAt": Timestamp                                        │
│  }                                                               │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  Local Storage Structure                         │
├─────────────────────────────────────────────────────────────────┤
│  GetStorage Keys:                                                │
│                                                                  │
│  'user_country' → "Bahrain"                                      │
│  'user_city' → "city_manama"       ← Stores KEY not translation │
│  'user_latitude' → 26.2285                                       │
│  'user_longitude' → 50.5860                                      │
│  'user_location_name' → "Seef District"                          │
│  'user_full_address' → "Apartment 12A, Floor 3..."              │
│  'last_location_update' → "2025-10-21T..."                       │
└─────────────────────────────────────────────────────────────────┘


═══════════════════════════════════════════════════════════════════
                      STATE MANAGEMENT FLOW
═══════════════════════════════════════════════════════════════════

PreviousLocationController:

    onInit()
       │
       ▼
    loadLocationFromFirestore()
       │
       ├─ Set isLoading = true
       ├─ Call update()
       ├─ Get userEmail from storage
       ├─ Query Firestore
       ├─ Set locationData = doc.data()
       ├─ Set isLoading = false
       └─ Call update()

    deleteLocation()
       │
       ├─ Set isDeleting = true
       ├─ Call update()
       ├─ Delete from Firestore
       ├─ Clear local storage
       ├─ Show success snackbar
       ├─ Set locationData = null
       ├─ Call update()
       ├─ Navigate back
       ├─ Set isDeleting = false
       └─ Call update()


LocationNavigator:

    navigateToLocationScreen()
       │
       ├─ Get userEmail from storage
       │    │
       │    └─ If null → Navigate to LocationView
       │
       ├─ Query Firestore for user_locations/{email}
       │    │
       │    ├─ If doc exists → Navigate to PreviousLocationView
       │    └─ If doc not exists → Navigate to LocationView
       │
       └─ On error → Navigate to LocationView (fallback)


═══════════════════════════════════════════════════════════════════
                      UI COMPONENT STRUCTURE
═══════════════════════════════════════════════════════════════════

PreviousLocationView
│
├─ Scaffold
│  ├─ CustomAppBar('your_saved_location')
│  │
│  └─ Body: GetBuilder<PreviousLocationController>
│     │
│     ├─ Loading State: CircularProgressIndicator
│     │
│     ├─ Empty State (locationData == null):
│     │  ├─ Icon (location_off)
│     │  ├─ Title: 'no_saved_location_found'
│     │  ├─ Subtitle: 'add_location_to_get_started'
│     │  └─ Button: 'add_new_location' → Navigate to LocationView
│     │
│     └─ Data State (locationData != null):
│        ├─ _buildLocationCard()
│        │  ├─ Gradient Container
│        │  ├─ Location Icon
│        │  ├─ City Name
│        │  ├─ "Active" Badge
│        │  └─ Full Address
│        │
│        ├─ _buildLocationDetails()
│        │  ├─ Section Title: 'location_details'
│        │  ├─ Detail Rows:
│        │  │  ├─ City
│        │  │  ├─ Area
│        │  │  ├─ Floor (if exists)
│        │  │  ├─ Apartment (if exists)
│        │  │  ├─ Phone (if exists)
│        │  │  └─ Notes (if exists)
│        │  └─ Coordinates Display
│        │
│        └─ _buildActionButtons()
│           ├─ CustomButton: 'edit_location'
│           └─ OutlinedButton: 'delete_location'
│              └─ On press → Show confirmation dialog
│                 ├─ Cancel → Close dialog
│                 └─ Confirm → Call controller.deleteLocation()
