import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop_app/features/orders/order_model.dart';

class OrderBrandInfo extends StatelessWidget {
  final OrderModel order;

  const OrderBrandInfo({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildBrandImage(),
        const SizedBox(width: 12),
        Expanded(
          child: _buildBrandDetails(),
        ),
      ],
    );
  }

  Widget _buildBrandImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: order.brandImage,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBrandDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          order.brandName,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _buildOrderMetaInfo(),
      ],
    );
  }

  Widget _buildOrderMetaInfo() {
    return Row(
      children: [
        Icon(
          order.orderType == 'SERVICE' ? Icons.build : Icons.inventory_2,
          size: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          order.orderType,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.shopping_bag,
          size: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          '${order.itemsCount} ${'items'.tr}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
