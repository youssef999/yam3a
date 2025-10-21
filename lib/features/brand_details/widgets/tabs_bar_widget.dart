import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';

class TabsBarController extends GetxController {
	var selectedTab = 0.obs;
	
	void changeTab(int index) {
		selectedTab.value = index;
    update();
	}
}

class TabsBarWidget extends StatelessWidget {
	const TabsBarWidget({super.key});

	@override
	Widget build(BuildContext context) {
		final controller = Get.find<TabsBarController>();
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		return Obx(() => Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: Colors.grey.shade200),
			),
			child: Row(
				children: [
					Expanded(
						child: GestureDetector(
							onTap: () => controller.changeTab(0),
							child: Container(
								padding: const EdgeInsets.symmetric(vertical: 14),
								decoration: BoxDecoration(
									color: controller.selectedTab.value == 0 ? accent : Colors.transparent,
									borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
								),
								alignment: Alignment.center,
								child: Text(
									'services'.tr,
									style: TextStyle(
										color: controller.selectedTab.value == 0 ? Colors.white : Colors.grey.shade600,
										fontWeight: FontWeight.w700,
									),
								),
							),
						),
					),
					Expanded(
						child: GestureDetector(
							onTap: () => controller.changeTab(1),
							child: Container(
								padding: const EdgeInsets.symmetric(vertical: 14),
								decoration: BoxDecoration(
									color: controller.selectedTab.value == 1 ? accent : Colors.transparent,
									borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
								),
								alignment: Alignment.center,
								child: Text(
									'packages'.tr,
									style: TextStyle(
										color: controller.selectedTab.value == 1 ? Colors.white : Colors.grey.shade600,
										fontWeight: FontWeight.w600,
									),
								),
							),
						),
					),
				],
			),
		));
	}
}