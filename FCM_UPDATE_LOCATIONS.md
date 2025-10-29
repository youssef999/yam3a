# 🎯 Visual Guide: Where to Update Credentials

## 📍 Location 1: `lib/core/noti/send_noti_controller.dart`

### Line ~10: Update Project ID

```dart
import 'package:googleapis_auth/auth_io.dart' as auth;

class FCMNotificationSender extends GetxController {
  // ⬇️ UPDATE THIS LINE ⬇️
  static const String _projectId = 'servicesapp2024';  // ← REPLACE 'servicesapp2024' with YOUR project ID
  // ⬆️ UPDATE THIS LINE ⬆️
  
  static String get _fcmEndpoint => 
      'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send';
```

---

### Lines ~18-30: Update Service Account JSON

```dart
  /// Get OAuth2 access token using service account credentials
  static Future<String> _getAccessToken() async {
    // ⬇️ REPLACE THIS ENTIRE BLOCK ⬇️
    final serviceAccountJson = {
      "type": "service_account",                                     // ✅ Keep as-is
      "project_id": "servicesapp2024",                              // 🔄 REPLACE
      "private_key_id": "df386a6ac15f7c3f874c60e597b1ed8de74f6b0e", // 🔄 REPLACE
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIE...",        // 🔄 REPLACE (keep \n)
      "client_email": "firebase-adminsdk@...iam.gserviceaccount.com", // 🔄 REPLACE
      "client_id": "106720475042112540398",                         // 🔄 REPLACE
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",      // ✅ Keep as-is
      "token_uri": "https://oauth2.googleapis.com/token",           // ✅ Keep as-is
      "auth_provider_x509_cert_url": "https://...",                 // ✅ Keep as-is
      "client_x509_cert_url": "https://www.googleapis.com/robot...", // 🔄 REPLACE
      "universe_domain": "googleapis.com"                            // ✅ Keep as-is
    };
    // ⬆️ REPLACE THIS ENTIRE BLOCK ⬆️
```

---

## 📍 Location 2: `lib/core/noti/noti_service.dart`

### Lines ~30-50: Update Service Account JSON

```dart
class NotificationService {
  static Future<String> getAccessToken() async {
    // ⬇️ REPLACE THIS ENTIRE BLOCK ⬇️
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "servicesapp2024",                              // 🔄 REPLACE
      "private_key_id": "df386a6ac15f7c3f874c60e597b1ed8de74f6b0e", // 🔄 REPLACE
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIE...",        // 🔄 REPLACE (keep \n)
      "client_email": "firebase-adminsdk@...iam.gserviceaccount.com", // 🔄 REPLACE
      "client_id": "106720475042112540398",                         // 🔄 REPLACE
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",      // ✅ Keep as-is
      "token_uri": "https://oauth2.googleapis.com/token",           // ✅ Keep as-is
      "auth_provider_x509_cert_url": "https://...",                 // ✅ Keep as-is
      "client_x509_cert_url": "https://www.googleapis.com/robot...", // 🔄 REPLACE
      "universe_domain": "googleapis.com"                            // ✅ Keep as-is
    };
    // ⬆️ REPLACE THIS ENTIRE BLOCK ⬆️
```

---

## 🔑 Key Mapping: JSON File → Your Code

### Your Downloaded JSON File:
```json
{
  "type": "service_account",
  "project_id": "my-app-12345",           ← Copy this
  "private_key_id": "abc123...",          ← Copy this
  "private_key": "-----BEGIN...",         ← Copy this (ALL of it, with \n)
  "client_email": "firebase-admin...",    ← Copy this
  "client_id": "987654321...",            ← Copy this
  "client_x509_cert_url": "https://..."   ← Copy this
}
```

### In Your Code:
```dart
final serviceAccountJson = {
  "type": "service_account",
  "project_id": "my-app-12345",           ← Paste here
  "private_key_id": "abc123...",          ← Paste here
  "private_key": "-----BEGIN...",         ← Paste here (with \n)
  "client_email": "firebase-admin...",    ← Paste here
  "client_id": "987654321...",            ← Paste here
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://..."   ← Paste here
  "universe_domain": "googleapis.com"
};
```

---

## ⚠️ Special Note: private_key

### In JSON File:
```json
"private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIB...\n-----END PRIVATE KEY-----\n"
```

### Important:
- **Keep the `\n` characters** - they represent line breaks
- **Copy the ENTIRE value** - it's very long (~1600 characters)
- **Include quotes** - start with `"-----BEGIN` and end with `-----\n"`
- **Don't modify** - copy exactly as-is

### Example (shortened):
```dart
"private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQE...(1600 chars)...END PRIVATE KEY-----\n",
```

---

## 🎨 Color Legend

- 🔄 **Orange** = REPLACE with your values
- ✅ **Green** = Keep as-is (don't change)

---

## 📝 Step-by-Step Process

### Step 1: Open your downloaded JSON file
```bash
# Your file is named something like:
# my-project-firebase-adminsdk-xxxxx-xxxxxxxxxx.json
```

### Step 2: Open code editor
```bash
# File 1:
lib/core/noti/send_noti_controller.dart

# File 2:
lib/core/noti/noti_service.dart
```

### Step 3: For each 🔄 marked field:
1. Find the field in your JSON file
2. Copy the value (include quotes)
3. Paste into your code
4. Verify it matches exactly

### Step 4: Update project_id constant
```dart
// In send_noti_controller.dart, line ~10
static const String _projectId = 'YOUR_PROJECT_ID'; // ← Same as "project_id" from JSON
```

---

## ✅ Verification

### Before Running:
Check these match your JSON:
- [ ] project_id (in 2 places)
- [ ] private_key_id
- [ ] private_key (with all \n characters)
- [ ] client_email
- [ ] client_id
- [ ] client_x509_cert_url

### After Running:
Console should show:
```
✅ OAuth2 access token obtained successfully
```

---

## 🚫 Common Mistakes

### ❌ Wrong:
```dart
"private_key": "-----BEGIN PRIVATE KEY-----
MIIE...                                    ← Missing \n
-----END PRIVATE KEY-----"                 ← Missing \n
```

### ✅ Correct:
```dart
"private_key": "-----BEGIN PRIVATE KEY-----\nMIIE...\n-----END PRIVATE KEY-----\n"
                                          ↑ Keep these \n characters
```

---

### ❌ Wrong:
```dart
"project_id": "servicesapp2024",  ← Old value, not yours!
```

### ✅ Correct:
```dart
"project_id": "my-actual-project-id",  ← Your actual project ID
```

---

## 🎯 Quick Checklist

Update these in **2 files**:

**File 1:** `lib/core/noti/send_noti_controller.dart`
- [ ] Line ~10: `_projectId`
- [ ] Lines ~18-30: Full `serviceAccountJson` block

**File 2:** `lib/core/noti/noti_service.dart`
- [ ] Lines ~30-50: Full `serviceAccountJson` block

**Values to Update:**
- [ ] project_id (3 times total)
- [ ] private_key_id (2 times)
- [ ] private_key (2 times - keep \n)
- [ ] client_email (2 times)
- [ ] client_id (2 times)
- [ ] client_x509_cert_url (2 times)

---

## 🆘 Still Confused?

### Option 1: Copy Entire JSON
1. Copy your **entire downloaded JSON file contents**
2. Paste to replace the **entire serviceAccountJson block**
3. Make sure to keep the variable name: `final serviceAccountJson = { ... }`

### Option 2: Use Find & Replace
1. Open downloaded JSON in text editor
2. For each field, use Find & Replace in your code:
   - Find: `"project_id": "servicesapp2024"`
   - Replace with: `"project_id": "YOUR_VALUE_FROM_JSON"`

---

**Ready to update?** Open both files and start copying! 🚀