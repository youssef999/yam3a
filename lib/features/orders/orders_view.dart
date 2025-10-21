import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/orders/orders_controller.dart';
import 'package:shop_app/features/orders/widgets/order_status_filter_tabs.dart';
import 'package:shop_app/features/orders/widgets/order_empty_state.dart';
import 'package:shop_app/features/orders/widgets/order_card.dart';
import 'package:shop_app/features/orders/widgets/order_loading_widget.dart';
import 'package:shop_app/features/orders/widgets/order_error_widget.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController controller = Get.put(OrdersController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('my_orders'.tr),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshOrders(),
          ),
        ],
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const OrderLoadingWidget();
          }
          if (controller.hasError) {
            return OrderErrorWidget(controller: controller);
          }
          return Column(
            children: [
              OrderStatusFilterTabs(controller: controller),
              Expanded(
                child: controller.filteredOrders.isEmpty
                    ? OrderEmptyState(selectedStatus: controller.selectedStatus)
                    : RefreshIndicator(
                        onRefresh: controller.refreshOrders,
                        color: primaryColor,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.filteredOrders.length,
                          itemBuilder: (context, index) {
                            final order = controller.filteredOrders[index];
                            return OrderCard(
                              order: order,
                              controller: controller,
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
