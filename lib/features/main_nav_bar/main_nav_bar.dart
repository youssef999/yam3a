

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/home/home_view.dart';
import 'package:shop_app/features/orders/orders_view.dart';
import 'package:shop_app/features/chat/chat_list_view.dart';
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
          {'icon': Icons.shopping_bag_rounded, 'label': 'orders'.tr},
          {'icon': Icons.chat_rounded, 'label': 'chats'.tr},
          {'icon': Icons.person_rounded, 'label': 'profile'.tr},
        ];

        return Scaffold(
        
          body: IndexedStack(
            index: controller.currentIndex,
            children: const [
              // Home Tab - Service Home View
              HomeView(),
              
              // Orders Tab - Orders View
              OrdersView(),

              // Chat Tab - Chat List View
              ChatListView(),

              // Profile Tab - Profile View
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
              borderRadius:BorderRadius.circular(12),
              border: Border(
                top: BorderSide(color:primaryColor, width: 0.1),
              ),
            ),
            child: SafeArea(
              child: Container(
                height: 112,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Home navigation item
                    Expanded(
                      flex: 1,
                      child: _buildBottomNavItem(
                        controller: controller,
                        index: 0,
                        icon: navItems[0]['icon'] as IconData,
                        label: navItems[0]['label'] as String,
                        isSelected: controller.currentIndex == 0,
                      ),
                    ),
                    
                    // Orders navigation item
                    Expanded(
                      flex: 1,
                      child: _buildBottomNavItem(
                        controller: controller,
                        index: 1,
                        icon: navItems[1]['icon'] as IconData,
                        label: navItems[1]['label'] as String,
                        isSelected: controller.currentIndex == 1,
                      ),
                    ),
                    
                    // Center logo (still navigates to home)
                    Expanded(
                      flex: 1,
                      child: _buildCenterLogo(controller),
                    ),
                    
                    // Chat navigation item with badge
                    Expanded(
                      flex: 1,
                      child: _buildChatNavItem(
                        controller: controller,
                        index: 2,
                        icon: navItems[2]['icon'] as IconData,
                        label: navItems[2]['label'] as String,
                        isSelected: controller.currentIndex == 2,
                      ),
                    ),
                    
                    // Profile navigation item
                    Expanded(
                      flex: 1,
                      child: _buildBottomNavItem(
                        controller: controller,
                        index: 3,
                        icon: navItems[3]['icon'] as IconData,
                        label: navItems[3]['label'] as String,
                        isSelected: controller.currentIndex == 3,
                      ),
                    ),
                  ],
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

    return InkWell(
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
    );
  }

  Widget _buildChatNavItem({
    required ServiceBottomBarController controller,
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final Color resolvedButtonColor =
      buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    final Color inactiveGrey = Colors.grey.shade400;

    return InkWell(
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
              Stack(
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
                  // Unread messages badge placeholder - can be enhanced later
                  const SizedBox.shrink(),
                ],
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
    );
  }

  Widget _buildCenterLogo(ServiceBottomBarController controller) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    final bool isHomeSelected = controller.currentIndex == 0;
    
    return InkWell(
        onTap: () => controller.changeIndex(0), // Navigate to home (index 0)
        borderRadius: BorderRadius.circular(30),
        splashColor: resolvedButtonColor.withOpacity(0.1),
        highlightColor: resolvedButtonColor.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo container with enhanced styling and selection indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: isHomeSelected ? 54 : 48,
                width: isHomeSelected ? 54 : 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isHomeSelected 
                          ? resolvedButtonColor.withOpacity(0.3)
                          : resolvedButtonColor.withOpacity(0.15),
                      blurRadius: isHomeSelected ? 16 : 10,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: isHomeSelected 
                        ? resolvedButtonColor.withOpacity(0.6)
                        : resolvedButtonColor.withOpacity(0.25),
                    width: isHomeSelected ? 2.5 : 2,
                  ),
                ),
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(isHomeSelected ? 9 : 8),
                    child: Image.asset(
                      'assets/images/yamaLogo1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Brand text with selection animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  fontFamily: 'fs_albert',
                  fontSize: isHomeSelected ? 10 : 9,
                  fontWeight: isHomeSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isHomeSelected 
                      ? resolvedButtonColor 
                      : resolvedButtonColor.withOpacity(0.7),
                  letterSpacing: 0.8,
                ),
                child: const Text('YAMAA'),
              ),
              // Selection indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 2,
                width: isHomeSelected ? 20 : 0,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: resolvedButtonColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
    );
  }

 
}
