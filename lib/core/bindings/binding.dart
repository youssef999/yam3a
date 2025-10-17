
import 'package:get/get.dart';
import 'package:shop_app/features/home/home_controller.dart';
import 'package:shop_app/features/login/login_controller.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';
import 'package:shop_app/features/splash/splash_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // Auth feature controllers
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SplashController>(() => SplashController());
    
    // Home and navigation controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ServiceBottomBarController>(() => ServiceBottomBarController());
  }
}