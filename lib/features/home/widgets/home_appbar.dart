import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/res/app_images.dart';
import 'package:shop_app/core/widgets/custom_text.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/notifications/noti_controller.dart';
import 'package:shop_app/features/notifications/noti_view.dart';
import 'package:shop_app/features/search/search_view.dart';
import 'package:shop_app/features/test_notifications/test_notifications_view.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
	const HomeAppBar({super.key});

	@override
	Size get preferredSize => const Size.fromHeight(kToolbarHeight);

	@override
	State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
	int unreadCount = 0;

	@override
	void initState() {
		super.initState();
		_loadUnreadCount();
		// Refresh count every 30 seconds for real-time updates
		_startPeriodicRefresh();
	}

  void _startPeriodicRefresh() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        _loadUnreadCount();
        _startPeriodicRefresh();
      }
    });
  }

	Future<void> _loadUnreadCount() async {
		final count = await NotificationController.getUnreadNotificationsCount();
		if (mounted) {
			setState(() {
				unreadCount = count;
			});
		}
	}

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
      ),
	title: const CustomTextLarge( 'YAMMA',
       color:Colors.white, fontWeight: FontWeight.w500),

			actions: [
				IconButton(
					icon:  Icon(Icons.search, color: appBarIconColor),
					onPressed: () {
            Get.to(const TestNotificationsView());
            //AnimatedGet.toWithSlideRight(const SearchView());
          },
				),
				_buildNotificationIcon(),
			],
		);
	}

	Widget _buildNotificationIcon() {
		return Stack(
			children: [
				IconButton(
					icon: Icon(
            unreadCount > 0 ? Icons.notifications : Icons.notifications_outlined, 
            color: appBarIconColor,
            size: 26,
          ),
					onPressed: () async {
            // Show loading indicator
            setState(() {
              unreadCount = 0; // Reset immediately for better UX
            });
            
						await AnimatedGet.toWithSlideUp(const NotificationView());
						// Refresh unread count when returning from notifications
						_loadUnreadCount();
					},
				),
				if (unreadCount > 0)
					Positioned(
						right: 8,
						top: 8,
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
							decoration: BoxDecoration(
								color: Colors.red,
								borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
							),
							constraints: const BoxConstraints(
								minWidth: 18,
								minHeight: 18,
							),
							child: Text(
								unreadCount > 99 ? '99+' : unreadCount.toString(),
								style: const TextStyle(
									color: Colors.white,
									fontSize: 10,
									fontWeight: FontWeight.bold,
								),
								textAlign: TextAlign.center,
							),
						),
					),
			],
		);
	}
}


