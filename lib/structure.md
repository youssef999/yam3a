

lib/
│
├── core/                          # Global/shared code
│   ├── constants/                 # App-wide constants
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── app_assets.dart
│   │   └── app_styles.dart
│   │
│   ├── utils/                    # Shared functions/helpers
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── extensions.dart        # (StringExtension, DateExtension, etc.)
│   │
│   ├── widgets/                   # Shared/reusable widgets
│   │   ├── custom_button.dart
│   │   ├── custom_textfield.dart
│   │   └── loading_indicator.dart
│   │
│   ├── errors/                    # Error handling
│   │   ├── failure.dart
│   │   └── exceptions.dart
│   │
│   ├── network/                   # Networking layer
│   │   ├── api_client.dart
│   │   ├── endpoints.dart
│   │   └── interceptors.dart
│   │
│   └── di/                        # Dependency Injection setup (get_it, etc.)
│       └── injector.dart
│
├── features/                      # App features
│   ├── auth/                      # Authentication feature
│   │   ├── cubit/                 # Cubits & States
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   │
│   │   ├── models/                # Data models
│   │   │   └── user_model.dart
│   │   │
│   │   ├── pages/                 # Screens
│   │   │   ├── login_page.dart
│   │   │   └── register_page.dart
│   │   │
│   │   └── widgets/               # Feature-specific widgets
│   │       └── login_form.dart
│   │
│   ├── home/                      # Example: Home feature
│   │   ├── cubit/
│   │   │   ├── home_cubit.dart
│   │   │   └── home_state.dart
│   │   ├── models/
│   │   ├── pages/
│   │   │   └── home_page.dart
│   │   └── widgets/
│   │       └── home_header.dart
│   │
│   └── ...                        # Other features
│
├── app.dart                       # Root App widget (MaterialApp, themes, routes)
├── router.dart                    # App router (GoRouter / AutoRoute / etc.)
└── main.dart                      # Entry point
