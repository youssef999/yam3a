import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyLocaleController extends GetxController {

  final box=GetStorage();

  void changeLang(String codeLang){
    final box=GetStorage();
    Locale currentLocal=Locale(codeLang);
    Get.updateLocale(currentLocal);
    box.write('locale', codeLang);
  }
}
