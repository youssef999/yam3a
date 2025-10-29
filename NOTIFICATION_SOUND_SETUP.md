# Notification Sound Setup Guide

## 🔊 Adding Custom Notification Sounds

### For Android:

1. **Create the raw folder** (if it doesn't exist):
   ```
   android/app/src/main/res/raw/
   ```

2. **Add your sound file**:
   - Place your sound file (e.g., `notification.wav`, `notification.mp3`) in the `raw` folder
   - Supported formats: WAV, MP3, OGG
   - Recommended: Short duration (1-3 seconds)

3. **File naming**:
   - Use lowercase letters only
   - No spaces or special characters
   - Example: `notification.wav`, `alert_sound.mp3`

4. **Update the code** (already done in recieve_noti.dart):
   ```dart
   sound: RawResourceAndroidNotificationSound('notification'), // without extension
   ```

### For iOS:

1. **Add sound file to iOS bundle**:
   - Place your sound file in `ios/Runner/`
   - Add it to the Xcode project
   - Supported formats: AIFF, CAF, WAV (recommended: CAF format)

2. **Update Info.plist** (if needed):
   ```xml
   <key>UISounds</key>
   <dict>
       <key>notification</key>
       <string>notification.caf</string>
   </dict>
   ```

## 🎵 Default System Sounds

If you don't want custom sounds, the app will use system default sounds:

### Android:
```dart
// Remove the sound parameter or set to null for default
sound: null, // Uses system default sound
```

### iOS:
```dart
sound: 'default', // Uses iOS default sound
```

## 🧪 Testing Sounds

1. Use the "Test Sound" button in the test notifications screen
2. Check device volume settings
3. Ensure "Do Not Disturb" mode is off
4. Test with app in foreground and background

## 🔧 Troubleshooting

### No Sound Playing:
1. Check notification permissions
2. Verify device volume is up
3. Check "Do Not Disturb" settings
4. Ensure sound file exists and is properly named
5. Try using default system sound first

### Android Specific:
- Check notification channel settings
- Some devices have per-app notification settings
- Custom ROMs may have different sound handling

### iOS Specific:
- Check iOS notification settings for the app
- Verify sound file is in correct format (CAF recommended)
- Check device silent/ringer switch

## 📱 Current Configuration

The app is currently configured to:
- ✅ Play sounds for all notifications
- ✅ Use maximum importance/priority
- ✅ Work in foreground and background
- ✅ Support custom sounds (if files are added)
- ✅ Fall back to system default if custom sound missing

## 🎯 Recommended Sound Files

For best results, use:
- **Duration**: 1-3 seconds
- **Format**: WAV (Android), CAF (iOS)
- **Sample Rate**: 44.1kHz
- **Bit Depth**: 16-bit
- **Channels**: Mono or Stereo
- **Volume**: Normalized, not too loud