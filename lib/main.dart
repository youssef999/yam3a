import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app/core/bindings/binding.dart';
import 'package:shop_app/core/language/local.dart';
import 'package:shop_app/core/language/local_controller.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/splash/splash_view.dart';
import 'package:shop_app/core/constants/app_routes.dart';
import 'package:shop_app/features/login/login_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocalStorage(); // Setup before runApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Creates a premium text theme with professional typography
  TextTheme _buildPremiumTextTheme(BuildContext context) {
    return const TextTheme(
      // Display styles - for large text like headers
      displayLarge: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ),
      
      // Headline styles - for section headers
      headlineLarge: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
      ),
      // Title styles - for card titles and important text
      titleLarge: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      
      // Body styles - for regular content
      bodyLarge: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      
      // Label styles - for buttons and form labels
      labelLarge: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: 'fs_albert',
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    final box = GetStorage();
    String keylocal = box.read('locale') ?? 'x';
    Locale lang = const Locale('ar');
    if (keylocal != 'x') {
      lang = Locale(keylocal);
    } else {
      box.write('locale', 'ar');
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      locale: lang,
      translations: MyLocal(),
      title: 'Shop App',
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
        GetPage(name: AppRoutes.login, page: () => const LoginView()),
        // Add other routes as they are implemented
        // GetPage(name: AppRoutes.home, page: () => const HomeView()),
      ],

      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(
          secondary: primaryColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: _buildPremiumTextTheme(context),
        fontFamily: 'fs_albert',
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontFamily: 'fs_albert',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
            color: splashTextColor,
            height: 1.2,
          ),
          iconTheme: const IconThemeData(
            color: splashTextColor,
            size: 24,
          ),
          actionsIconTheme: const IconThemeData(
            color: splashTextColor,
            size: 24,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: splashTextColor,
            elevation: 2,
            shadowColor: primaryColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            textStyle: const TextStyle(
              fontFamily: 'fs_albert',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              height: 1.25,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: containerColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          labelStyle: const TextStyle(
            fontFamily: 'fs_albert',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
          ),
          hintStyle: TextStyle(
            fontFamily: 'fs_albert',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
            color: lightTxtColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: dividerColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: dividerColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: failColor,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: failColor,
              width: 2,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: lightTxtColor,
          showUnselectedLabels: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: splashTextColor,
        ),
      ),
      // Using initialRoute instead of home
    );
  }
}