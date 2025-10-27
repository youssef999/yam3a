# User Name Auto-Fetching Implementation

## Overview
This implementation automatically checks if the user name is empty or null in local storage and fetches it from Firebase Firestore if needed.

## Features
- ✅ **Automatic Detection**: Detects when user name is missing or invalid
- ✅ **Firebase Integration**: Fetches from Firestore user collection
- ✅ **Fallback Handling**: Creates user document if it doesn't exist
- ✅ **Error Recovery**: Sets fallback names when Firebase fails
- ✅ **Real-time Updates**: Updates UI immediately when name is fetched

## Components

### 1. Local Storage Helper Methods (`local_db.dart`)
```dart
/// Check if user name needs to be fetched
bool needsUserNameFetch() {
  final name = userName;
  return name == null || name.isEmpty || name == 'user' || name == 'المستخدم';
}

/// Check if user has complete profile data
bool hasCompleteUserData() {
  return userName != null && userName!.isNotEmpty && 
         userEmail != null && userEmail!.isNotEmpty &&
         userName != 'user' && userName != 'المستخدم';
}
```

### 2. User Data Manager (`user_data_manager.dart`)
```dart
/// Check and fetch user name if missing
static Future<void> ensureUserNameIsAvailable() async {
  if (storage.needsUserNameFetch()) {
    await _fetchUserNameFromFirebase();
  }
}

/// Get current user name, fetch if needed
static Future<String> getUserName() async {
  if (storage.needsUserNameFetch()) {
    await ensureUserNameIsAvailable();
  }
  return storage.userName ?? 'User';
}
```

### 3. Profile Controller Integration
```dart
void loadUserData() {
  userName = storage.userName ?? 'user'.tr;
  userEmail = storage.userEmail ?? '';
  
  // If user name is empty or null, fetch it from Firebase
  if (storage.needsUserNameFetch()) {
    _ensureUserNameLoaded();
  }
  
  update();
}
```

## Usage Examples

### 1. In Profile View
```dart
// The profile view automatically shows "Loading name..." while fetching
Text(
  controller.userName.isEmpty || controller.userName == 'user'.tr
      ? 'loading_name'.tr
      : controller.userName,
  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
)
```

### 2. Anywhere in the App
```dart
// Get user name with automatic fetching
final userName = await UserDataManager.getUserName();

// Check if user data is complete
if (UserDataManager.isUserDataComplete()) {
  // User has complete profile
} else {
  // Need to fetch or update user data
  await UserDataManager.ensureUserNameIsAvailable();
}
```

### 3. On App Startup
```dart
// In main.dart or splash screen
await UserDataManager.ensureUserNameIsAvailable();
```

## Fetch Logic Flow

```
1. Check if user name is empty/null/default
   ↓
2. Get user email from local storage
   ↓
3. Query Firebase: users/{email}
   ↓
4. If document exists:
   - Extract name/userName/displayName
   - Save to local storage
   - Update UI
   ↓
5. If document doesn't exist:
   - Create basic user document
   - Use email prefix as name
   - Save to local storage
   ↓
6. If Firebase fails:
   - Use email prefix as fallback
   - Save to local storage
```

## Firebase Document Structure
```json
{
  "email": "user@example.com",
  "name": "User Name",
  "createdAt": "2025-10-27T...",
  "updatedAt": "2025-10-27T..."
}
```

## Error Handling

### Network Issues
- Falls back to email-based name generation
- Saves fallback name to prevent repeated attempts
- Shows user-friendly loading states

### Missing User Document
- Automatically creates basic document in Firebase
- Uses email prefix as initial name
- User can update later through profile

### Invalid Email
- Sets generic "User" fallback
- Logs error for debugging
- Continues app functionality

## Localization Support

### Arabic
```dart
'loading_name': 'جارٍ تحميل الاسم...',
'user': 'مستخدم',
```

### English
```dart
'loading_name': 'Loading name...',
'user': 'User',
```

## Best Practices

### Performance
- Only fetches when actually needed
- Caches result in local storage
- Avoids repeated Firebase calls

### User Experience
- Shows loading state during fetch
- Updates UI immediately when complete
- Graceful fallbacks for all error cases

### Data Consistency
- Single source of truth in local storage
- Firebase as backup/sync mechanism
- Automatic recovery from data issues

## Testing

### Test Missing Name
```dart
// Clear local storage
await storage.deleteUserName();

// Trigger fetch
await UserDataManager.ensureUserNameIsAvailable();

// Verify name was fetched and saved
expect(storage.userName, isNotEmpty);
```

### Test Fallback Scenarios
```dart
// Test with invalid email
await storage.saveUserEmail('invalid-email');
await UserDataManager.ensureUserNameIsAvailable();

// Should set fallback name
expect(storage.userName, equals('invalid-email'));
```

---

**Status**: ✅ Implemented and Ready
**Firebase Integration**: ✅ Complete
**Error Handling**: ✅ Robust
**UI Updates**: ✅ Real-time