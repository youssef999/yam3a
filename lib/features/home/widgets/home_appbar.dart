import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/custom_text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
	const HomeAppBar({super.key});

	@override
	Size get preferredSize => const Size.fromHeight(kToolbarHeight);

	@override
	Widget build(BuildContext context) {
		return AppBar(
			backgroundColor: appBarColor,
			elevation: 0.8,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
                  appLogo,
                  height: 28,
                ),
      ),
			title: CustomTextLarge( 'Yamaa'.tr,
       color: txtColor, fontWeight: FontWeight.bold),
			actions: [
				IconButton(
					icon:  Icon(Icons.search, color: appBarIconColor),
					onPressed: () {},
				),
				IconButton(
					icon:  Icon(Icons.settings, color: appBarIconColor),
					onPressed: () {},
				),
				IconButton(
					icon: Icon(Icons.notifications_outlined, color: appBarIconColor),
					onPressed: () {},
				),
			],
		);
	}
}


