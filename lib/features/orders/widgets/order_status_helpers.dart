import 'package:flutter/material.dart';

class OrderStatusHelpers {
  OrderStatusHelpers._();

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'done':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.access_time;
      case 'accepted':
        return Icons.check_circle;
      case 'done':
        return Icons.done_all;
      case 'canceled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
