// import 'package:get/get.dart';
// import 'payment_controller.dart';

// /// Example usage of PaymentController
// void main() {
//   // Example 1: $100 payment
//   print('=== EXAMPLE 1: \$100 Payment ===');
//   PaymentController payment1 = PaymentController(totalMoney: 100.0);
  
//   print('\nAccessing individual values:');
//   print('App Commission: \$${payment1.getAppCommission().toStringAsFixed(2)} (${payment1.getAppCommissionRate()}%)');
//   print('Bank Fee: \$${payment1.getBankFee().toStringAsFixed(2)} (${payment1.getBankFeeRate()}%)');
//   print('Vendor Profit: \$${payment1.getVendorProfit().toStringAsFixed(2)} (${payment1.getVendorProfitRate()}%)');
  
//   print('\n' + '='*50 + '\n');
  
//   // Example 2: $500 payment
//   print('=== EXAMPLE 2: \$500 Payment ===');
//   PaymentController payment2 = PaymentController(totalMoney: 500.0);
  
//   print('\n' + '='*50 + '\n');
  
//   // Example 3: $1000 payment
//   print('=== EXAMPLE 3: \$1000 Payment ===');
//   PaymentController payment3 = PaymentController(totalMoney: 1000.0);
  
//   // Get breakdown as map
//   print('\nPayment breakdown as map:');
//   Map<String, dynamic> breakdown = payment3.getPaymentBreakdownMap();
//   print(breakdown);
  
//   print('\n' + '='*50 + '\n');
  
//   // Example 4: Small payment
//   print('=== EXAMPLE 4: \$25.50 Payment ===');
//   PaymentController payment4 = PaymentController(totalMoney: 25.50);
// }

// /// How to use with GetX in a Flutter app
// class PaymentExample extends GetxController {
//   PaymentController? paymentController;
  
//   void calculatePayment(double amount) {
//     // Dispose previous controller if exists
//     paymentController?.dispose();
    
//     // Create new payment controller
//     paymentController = PaymentController(totalMoney: amount);
    
//     // Use the calculated values in your UI
//     update(); // Notify GetX listeners
//   }
  
//   double getAppCommission() => paymentController?.getAppCommission() ?? 0.0;
//   double getBankFee() => paymentController?.getBankFee() ?? 0.0;
//   double getVendorProfit() => paymentController?.getVendorProfit() ?? 0.0;
// }