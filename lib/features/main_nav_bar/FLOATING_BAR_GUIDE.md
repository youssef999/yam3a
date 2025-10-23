# Floating Bottom Bar Implementation Guide

## Overview
The Floating Bottom Bar provides a way for users to return to the main navigation from any screen that doesn't have the main bottom navigation bar. It features the YAMAA logo and maintains consistent branding throughout the app.

## Available Components

### 1. FloatingBottomBar (Full Featured)
- **Features**: Back button, YAMAA logo with text, optional custom action button
- **Best for**: Detail screens, forms, settings pages
- **Usage**:
```dart
const FloatingBottomBar(
  showBackButton: true,      // Show/hide back button
  onBackPressed: null,       // Custom back action (optional)
  customText: 'More',        // Custom action button text (optional)
)
```

### 2. CompactFloatingBottomBar (Minimal)
- **Features**: Back button and YAMAA logo only, positioned in bottom right
- **Best for**: Simple screens where you want minimal UI interference
- **Usage**:
```dart
const CompactFloatingBottomBar(
  onBackPressed: null,       // Custom back action (optional)
)
```

### 3. FloatingActionBottomBar (FAB Style)
- **Features**: Only YAMAA logo as a centered floating action button
- **Best for**: Full-screen content, galleries, media viewers
- **Usage**:
```dart
const FloatingActionBottomBar()
```

## Implementation Steps

### Step 1: Import the Component
```dart
import 'package:shop_app/features/main_nav_bar/floating_bottom_bar.dart';
```

### Step 2: Add to Your Screen
Wrap your screen content in a `Stack` and add the floating bar:

```dart
class YourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your main content here
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 120, // Space for floating bar
            ),
            child: YourContent(),
          ),
          
          // Add one of these floating bars
          const FloatingBottomBar(showBackButton: true),
          // OR
          // const CompactFloatingBottomBar(),
          // OR
          // const FloatingActionBottomBar(),
        ],
      ),
    );
  }
}
```

### Step 3: Add Bottom Padding
Always add bottom padding to your content to prevent it from being hidden behind the floating bar:
- **FloatingBottomBar**: 120px bottom padding
- **CompactFloatingBottomBar**: 100px bottom padding  
- **FloatingActionBottomBar**: 100px bottom padding

## Customization Options

### Custom Back Action
```dart
FloatingBottomBar(
  onBackPressed: () {
    // Your custom back logic
    Get.back();
    // or
    Navigator.pop(context);
  },
)
```

### Without Back Button
```dart
FloatingBottomBar(
  showBackButton: false,
)
```

### With Custom Action
```dart
FloatingBottomBar(
  customText: 'Share',
  // The custom button tap can be handled by modifying the component
)
```

## When to Use Each Style

### FloatingBottomBar (Full)
- ✅ Product detail pages
- ✅ User profile screens  
- ✅ Settings pages
- ✅ Form screens
- ✅ Any screen where you want full navigation options

### CompactFloatingBottomBar (Minimal)
- ✅ Image galleries
- ✅ Article reading screens
- ✅ Simple list views
- ✅ When you want minimal UI distraction

### FloatingActionBottomBar (FAB)
- ✅ Full-screen media viewers
- ✅ Camera screens
- ✅ Map views
- ✅ When you only need home navigation

## Design Guidelines

### Colors
- Uses the same `buttonColor` from your app theme
- Automatically adapts to your brand colors
- White background with subtle shadows for visibility

### Animations
- Smooth enter/exit animations
- Responsive touch feedback
- Consistent with main navigation bar animations

### Accessibility
- Proper touch targets (minimum 44px)
- Clear visual hierarchy
- Consistent positioning

## Example Screens

You can find example implementations in:
- `example_usage.dart` - Shows all three styles
- Look for usage patterns in existing screens

## Integration with Existing Screens

To add to your existing screens:

1. **Identify screens without main navigation**
2. **Choose appropriate floating bar style**
3. **Add Stack wrapper**
4. **Include bottom padding**
5. **Test navigation flow**

## Navigation Behavior

- **Logo tap**: Always navigates to main navigation (home)
- **Back button**: Goes to previous screen or custom action
- **Uses GetX navigation**: `Get.offAll()` for home navigation
- **Maintains navigation stack**: Properly handles back navigation

## Tips

1. **Consistent positioning**: Always use the same bottom margin (30px)
2. **Proper padding**: Don't forget bottom padding on content
3. **Test on different screen sizes**: Especially small devices
4. **Consider keyboard**: May need to hide when keyboard is visible
5. **Use appropriate style**: Match the screen's content and purpose