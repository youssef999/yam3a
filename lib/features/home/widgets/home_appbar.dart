import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/features/search/search_view.dart';

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
        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 0),
        child: CircleAvatar(
          radius: 75,
          backgroundImage:  AssetImage(appLogo),
        ),
    
        // Image.asset(
        //           appLogo,
        //           height: 28,
        //         ),
      ),
	title: CustomTextLarge( 'YAMMA',
      
       color: primaryColor, fontWeight: FontWeight.w500),


			actions: [
				IconButton(
					icon:  Icon(Icons.search, color: appBarIconColor),
					onPressed: () {
            Get.to(const SearchView());
          },
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


