# 🔥 Firebase Cloud Messaging (FCM) Configuration Guide

## 📋 Overview

This guide explains how to configure FCM notifications using **OAuth2 Service Account** authentication (HTTP v1 API) instead of the legacy Server Key method.

---

## 🔑 Required Keys and Where to Get Them

### **1. Service Account JSON File**

You need to obtain your Firebase Service Account credentials from the Firebase Console.

#### **Steps to Get Service Account JSON:**

1. **Open Firebase Console**
   - Go to: https://console.firebase.google.com/
   - Select your project

2. **Navigate to Project Settings**
   - Click the ⚙️ gear icon (top left) → "Project settings"

3. **Go to Service Accounts Tab**
   - Click on "Service accounts" tab
   - You should see "Firebase Admin SDK"

4. **Generate New Private Key**
   - Click "Generate new private key" button
   - Confirm by clicking "Generate key"
   - A JSON file will be downloaded

5. **Important:** Keep this file **SECURE** - never commit it to version control!

---

## 📝 Keys You Need to Replace

The following keys from your downloaded JSON file need to be updated in your code:

### **Location in Code:**
- File: `lib/core/noti/send_noti_controller.dart`
- File: `lib/core/noti/noti_service.dart`

### **Keys to Replace:**

```dart
final serviceAccountJson = {
  "type": "service_account",                    // ✅ Keep as-is
  "project_id": "YOUR_PROJECT_ID",              // 🔄 REPLACE
  "private_key_id": "YOUR_PRIVATE_KEY_ID",      // 🔄 REPLACE
  "private_key": "YOUR_PRIVATE_KEY",            // 🔄 REPLACE (multi-line)
  "client_email": "YOUR_CLIENT_EMAIL",          // 🔄 REPLACE
  "client_id": "YOUR_CLIENT_ID",                // 🔄 REPLACE
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",           // ✅ Keep as-is
  "token_uri": "https://oauth2.googleapis.com/token",                // ✅ Keep as-is
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs", // ✅ Keep as-is
  "client_x509_cert_url": "YOUR_CLIENT_CERT_URL", // 🔄 REPLACE
  "universe_domain": "googleapis.com"           // ✅ Keep as-is
};
```

---

## 🔄 Detailed Key Replacement

### **1. project_id**
```dart
"project_id": "servicesapp2024",  // Replace with YOUR project ID
```
- **Where to find:** Firebase Console → Project Settings → General → Project ID
- **Example:** `"my-awesome-app-2024"`

---

### **2. private_key_id**
```dart
"private_key_id": "df386a6ac15f7c3f874c60e597b1ed8de74f6b0e",
```
- **Where to find:** In the downloaded JSON file
- **Format:** 40-character hexadecimal string
- **Example:** `"abc123def456..."`

---

### **3. private_key**
```dart
"private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIB...\n-----END PRIVATE KEY-----\n",
```
- **Where to find:** In the downloaded JSON file
- **Important:** Keep all `\n` characters - they represent line breaks
- **Security:** This is the most sensitive key - never expose it publicly!
- **Format:** Multi-line RSA private key wrapped in BEGIN/END markers

---

### **4. client_email**
```dart
"client_email": "firebase-adminsdk-a1s4s@servicesapp2024.iam.gserviceaccount.com",
```
- **Where to find:** In the downloaded JSON file
- **Format:** `firebase-adminsdk-xxxxx@YOUR_PROJECT_ID.iam.gserviceaccount.com`
- **Example:** `"firebase-adminsdk-abc12@my-app.iam.gserviceaccount.com"`

---

### **5. client_id**
```dart
"client_id": "106720475042112540398",
```
- **Where to find:** In the downloaded JSON file
- **Format:** Long numerical string (21 digits)
- **Example:** `"123456789012345678901"`

---

### **6. client_x509_cert_url**
```dart
"client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-a1s4s%40servicesapp2024.iam.gserviceaccount.com",
```
- **Where to find:** In the downloaded JSON file
- **Format:** URL with your service account email encoded
- **Note:** The `@` symbol is URL-encoded as `%40`

---

## 🛠️ Implementation Steps

### **Step 1: Update Project ID**

In both files, update the project ID constant:

```dart
// lib/core/noti/send_noti_controller.dart
static const String _projectId = 'YOUR_PROJECT_ID'; // 🔄 REPLACE
```

### **Step 2: Update Service Account JSON**

Replace the entire `serviceAccountJson` map with values from your downloaded JSON file in:
- `lib/core/noti/send_noti_controller.dart` (line ~12-30)
- `lib/core/noti/noti_service.dart` (line ~10-30)

### **Step 3: Verify OAuth Scopes**

Ensure these scopes are present (they should be):

```dart
List<String> scopes = [
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/firebase.database",
  "https://www.googleapis.com/auth/firebase.messaging"
];
```

---

## 🔒 Security Best Practices

### **❌ DON'T:**
- ❌ Commit service account JSON to Git
- ❌ Share private keys publicly
- ❌ Hard-code credentials in production apps
- ❌ Store credentials in client-side code for production

### **✅ DO:**
- ✅ Use environment variables for production
- ✅ Store credentials in secure backend servers
- ✅ Use `.gitignore` to exclude credential files
- ✅ Rotate keys periodically
- ✅ Use Firebase Admin SDK on backend instead of client-side for production

### **Recommended Production Approach:**

```
Client App (Flutter)
    ↓ (Send request with user data)
Your Backend Server (Node.js, Python, etc.)
    ↓ (Uses Service Account to send FCM)
Firebase Cloud Messaging
    ↓ (Delivers notification)
User's Device
```

---

## 📦 Required Dependencies

Make sure these are in your `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.1.0
  googleapis_auth: ^1.4.1
  get: ^4.6.6
  firebase_core: ^2.24.0
  firebase_messaging: ^14.7.0
  flutter_local_notifications: ^16.2.0
```

Run after updating:
```bash
flutter pub get
```

---

## 🧪 Testing Your Configuration

### **Test 1: Check Access Token Generation**

```dart
// This should print a valid token
final token = await FCMNotificationSender._getAccessToken();
print('Access Token: $token');
```

Expected output:
```
✅ OAuth2 access token obtained successfully
```

### **Test 2: Send Test Notification**

Use the test notifications screen:
1. Navigate to `/test_notifications`
2. Click "Test Simple Notification"
3. Check console for success messages

Expected console output:
```
📤 Sending FCM notification (HTTP v1 API)...
📱 To device: abc123...
✅ Notification sent successfully
```

---

## 🐛 Troubleshooting

### **Error: "Invalid credentials"**
- ✅ Verify all keys match your downloaded JSON exactly
- ✅ Check for extra spaces or missing characters
- ✅ Ensure `\n` characters are preserved in private_key

### **Error: "Project not found"**
- ✅ Verify `project_id` is correct
- ✅ Ensure project exists in Firebase Console
- ✅ Check FCM is enabled for your project

### **Error: "Permission denied"**
- ✅ Verify OAuth scopes include FCM messaging scope
- ✅ Check service account has "Firebase Cloud Messaging Admin" role
- ✅ In Firebase Console: IAM & Admin → Check service account permissions

### **Error: "Invalid token"**
- ✅ Device token might be expired or invalid
- ✅ Try refreshing device token
- ✅ Verify device has granted notification permissions

---

## 📊 Comparison: Old vs New Method

| Feature | Legacy (Server Key) | New (OAuth2 v1) |
|---------|-------------------|-----------------|
| **API** | FCM Legacy API | FCM HTTP v1 API |
| **Authentication** | Server Key | OAuth2 Service Account |
| **Security** | Less secure | More secure |
| **Token Expiry** | Never | 1 hour (auto-refresh) |
| **Message Format** | Legacy JSON | Structured JSON |
| **Batch Sending** | Supported | Not directly supported |
| **Google Recommendation** | ❌ Deprecated | ✅ Recommended |
| **Future Support** | Limited | Full support |

---

## 📱 Notification Payload Structure (HTTP v1)

```json
{
  "message": {
    "token": "device_fcm_token_here",
    "notification": {
      "title": "Notification Title",
      "body": "Notification Body"
    },
    "data": {
      "key1": "value1",
      "key2": "value2"
    },
    "android": {
      "priority": "high",
      "notification": {
        "channel_id": "yamaa_notifications",
        "sound": "default"
      }
    },
    "apns": {
      "headers": {
        "apns-priority": "10"
      },
      "payload": {
        "aps": {
          "sound": "default",
          "badge": 1
        }
      }
    }
  }
}
```

---

## 🎯 Quick Start Checklist

- [ ] Download Service Account JSON from Firebase Console
- [ ] Replace `project_id` in code
- [ ] Replace `private_key_id` in code
- [ ] Replace `private_key` in code (keep `\n` characters)
- [ ] Replace `client_email` in code
- [ ] Replace `client_id` in code
- [ ] Replace `client_x509_cert_url` in code
- [ ] Add `googleapis_auth` to pubspec.yaml
- [ ] Run `flutter pub get`
- [ ] Test notification sending
- [ ] Verify notifications are received
- [ ] Check console logs for success messages

---

## 🔗 Useful Links

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [FCM HTTP v1 API Reference](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages)
- [Service Account Authentication](https://cloud.google.com/docs/authentication/getting-started)
- [OAuth2 Scopes for Firebase](https://developers.google.com/identity/protocols/oauth2/scopes#firebase)

---

## 💡 Additional Notes

### **For Production Apps:**
Move service account credentials to a backend server and create an API endpoint:

```
POST /api/send-notification
Headers: Authorization: Bearer <user_token>
Body: {
  "device_token": "...",
  "title": "...",
  "body": "..."
}
```

Your backend then uses the service account to send FCM notifications securely.

### **Cost Considerations:**
- FCM is **free** for standard notifications
- No limit on number of messages
- OAuth2 tokens are cached and reused for 1 hour

---

## ✅ Verification

After configuration, you should see in console:

```
✅ FCM Notifications initialized successfully
✅ OAuth2 access token obtained successfully
📤 Sending FCM notification (HTTP v1 API)...
✅ Notification sent successfully
🔊 Playing notification sound for foreground message
```

---

**Last Updated:** October 29, 2025  
**Version:** 1.0.0  
**Compatibility:** Flutter 3.x, Firebase 10.x+