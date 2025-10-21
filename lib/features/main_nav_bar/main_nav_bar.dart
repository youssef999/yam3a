

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/home/home_view.dart';
import 'package:shop_app/features/orders/orders_view.dart';
import 'package:shop_app/features/profile/profile_view.dart';


class ServiceBottomBarController extends GetxController {
  int currentIndex = 0;
  
  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}

class AppBottomBar extends StatelessWidget {

  const AppBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceBottomBarController());
    
    return GetBuilder<ServiceBottomBarController>(
      builder: (controller) {
        final navItems = [
          {'icon': Icons.home_rounded, 'label': 'home'.tr},
          {'icon': Icons.favorite_rounded, 'label': 'favorites'.tr},
          {'icon': Icons.shopping_bag_rounded, 'label': 'orders'.tr},
          {'icon': Icons.person_rounded, 'label': 'profile'.tr},
        ];

        return Scaffold(
        
          body: IndexedStack(
            index: controller.currentIndex,
            children: const [
              // Home Tab - Service Home View
             HomeView(),
              
              // Favorites Tab - Favorites View
              HomeView(),

              OrdersView(),

              ProfileView(),
              
             
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
              border: Border(
                top: BorderSide(color: Colors.grey[200]!, width: 0.5),
              ),
            ),
            child: SafeArea(
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Row(
                  children: navItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return _buildBottomNavItem(
                      controller: controller,
                      index: index,
                      icon: data['icon'] as IconData,
                      label: data['label'] as String,
                      isSelected: controller.currentIndex == index,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavItem({
    required ServiceBottomBarController controller,
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
  final Color resolvedButtonColor =
    buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
  final Color inactiveGrey = Colors.grey.shade400;

    return Expanded(
      child: InkWell(
        onTap: () => controller.changeIndex(index),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? resolvedButtonColor.withOpacity(0.16)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: isSelected ? 43 : 39,
                width: isSelected ? 42 : 39,
                decoration: BoxDecoration(
                  color: isSelected ? resolvedButtonColor : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: resolvedButtonColor.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                  ],
                  border: Border.all(
                    color:
                        isSelected ? resolvedButtonColor : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  size: isSelected ? 19 : 17,
                  color: isSelected ? Colors.white : inactiveGrey,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  fontFamily: 'fs_albert',
                  fontSize: isSelected ? 12 : 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? resolvedButtonColor
                      : inactiveGrey,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 2,
                  width: isSelected ? 26 : 0,
                decoration: BoxDecoration(
                  color: resolvedButtonColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
