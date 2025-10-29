# 🚀 Quick Start: Update FCM Credentials

## ⚡ 3-Minute Setup

### Step 1: Download Service Account JSON (2 minutes)

1. Go to: **https://console.firebase.google.com/**
2. Click: **Your Project**
3. Click: **⚙️ (Settings)** → **Project Settings**
4. Click: **Service accounts** tab
5. Click: **"Generate new private key"** button
6. Click: **"Generate key"** to confirm
7. **Save the downloaded JSON file** (keep it secure!)

---

### Step 2: Update Your Code (1 minute)

#### File 1: `lib/core/noti/send_noti_controller.dart`

**Line ~10:** Update project ID
```dart
static const String _projectId = 'YOUR_PROJECT_ID';  // ← Copy from JSON: "project_id"
```

**Lines ~18-30:** Replace the entire serviceAccountJson:
```dart
final serviceAccountJson = {
  // Copy ENTIRE contents from your downloaded JSON file
  // Make sure to keep the \n characters in private_key
};
```

#### File 2: `lib/core/noti/noti_service.dart`

**Lines ~30-50:** Replace the serviceAccountJson (same as above)

---

### Step 3: Test (30 seconds)

```bash
flutter run
```

Navigate to `/test_notifications` and click "Test Simple Notification"

---

## ✅ What to Copy from Downloaded JSON

Open your downloaded JSON file and copy these values:

```json
{
  "project_id": "← COPY THIS",
  "private_key_id": "← COPY THIS",
  "private_key": "← COPY THIS (keep all \\n characters!)",
  "client_email": "← COPY THIS",
  "client_id": "← COPY THIS",
  "client_x509_cert_url": "← COPY THIS"
}
```

---

## 🎯 Example

### Your Downloaded JSON:
```json
{
  "type": "service_account",
  "project_id": "my-awesome-app",
  "private_key_id": "abc123def456...",
  "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIE...\\n-----END PRIVATE KEY-----\\n",
  "client_email": "firebase-adminsdk@my-awesome-app.iam.gserviceaccount.com",
  "client_id": "123456789",
  "client_x509_cert_url": "https://..."
}
```

### In Your Code:
```dart
static const String _projectId = 'my-awesome-app';

final serviceAccountJson = {
  "type": "service_account",
  "project_id": "my-awesome-app",
  "private_key_id": "abc123def456...",
  "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIE...\\n-----END PRIVATE KEY-----\\n",
  "client_email": "firebase-adminsdk@my-awesome-app.iam.gserviceaccount.com",
  "client_id": "123456789",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://...",
  "universe_domain": "googleapis.com"
};
```

---

## ⚠️ Important

- **Keep `\n` characters** in private_key (they're line breaks)
- **Don't commit** the JSON file to Git
- **Don't share** your private key publicly
- **Test immediately** after updating

---

## 🔍 Verify It Works

After updating, console should show:

```
✅ OAuth2 access token obtained successfully
📤 Sending FCM notification (HTTP v1 API)...
✅ Notification sent successfully
```

---

## 🆘 Having Issues?

1. **Compile errors?** Run `flutter pub get`
2. **Invalid credentials?** Double-check you copied everything exactly
3. **Still not working?** See `FCM_CONFIGURATION_GUIDE.md` for detailed troubleshooting

---

**That's it!** 🎉 Your FCM notifications are now using the secure OAuth2 method.