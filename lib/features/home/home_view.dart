
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/home/home_controller.dart';
import 'package:shop_app/features/home/widgets/cat_service_card.dart';
import 'package:shop_app/features/home/widgets/home_appbar.dart';
import 'package:shop_app/features/test_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  void initState() {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController()); 
    }
    addDeviceTokenToAllBrands();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Initialize the home controller
return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Categories grid
              GetBuilder<HomeController>(
                builder: (controller) {
                  if (controller.isLoading && controller.catServices.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: controller.catServices.length,
                    itemBuilder: (context, index) {
                      final catService = controller.catServices[index];
                      return catServiceCard(
                        catService: catService
                      );
                    },
                  );
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


}