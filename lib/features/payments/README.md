# PaymentController Documentation

## Overview
The PaymentController calculates payment breakdown with the following commission structure:
- **App Commission**: 2% of total amount
- **Bank Fee**: 0.5% of total amount  
- **Vendor Profit**: 97.5% of total amount

## Constructor
```dart
PaymentController({required double totalMoney})
```

## Features
- ✅ Automatic calculation on initialization
- ✅ Console printing of breakdown
- ✅ Getter methods for individual amounts
- ✅ Percentage rate getters
- ✅ Payment breakdown as Map
- ✅ Input validation
- ✅ GetX controller lifecycle management

## Usage Examples

### Basic Usage
```dart
// Create payment controller with $100
PaymentController payment = PaymentController(totalMoney: 100.0);

// Automatically prints:
// === PAYMENT BREAKDOWN ===
// Total Money: $100.00
// 
// App Commission (2%): $2.00
// Bank Fee (0.5%): $0.50
// Vendor Profit (97.5%): $97.50
// 
// Verification:
// Total: $100.00
// Match: true
// ========================
```

### Accessing Individual Values
```dart
PaymentController payment = PaymentController(totalMoney: 500.0);

double appCommission = payment.getAppCommission(); // $10.00
double bankFee = payment.getBankFee(); // $2.50
double vendorProfit = payment.getVendorProfit(); // $487.50

double appRate = payment.getAppCommissionRate(); // 2.0
double bankRate = payment.getBankFeeRate(); // 0.5
double vendorRate = payment.getVendorProfitRate(); // 97.5
```

### Getting Breakdown as Map
```dart
PaymentController payment = PaymentController(totalMoney: 1000.0);
Map<String, dynamic> breakdown = payment.getPaymentBreakdownMap();

// Returns:
// {
//   'totalMoney': 1000.0,
//   'appCommission': {'amount': 20.0, 'percentage': 2.0},
//   'bankFee': {'amount': 5.0, 'percentage': 0.5},
//   'vendorProfit': {'amount': 975.0, 'percentage': 97.5}
// }
```

### Using with GetX in Flutter
```dart
class MyController extends GetxController {
  PaymentController? paymentController;
  
  void processPayment(double amount) {
    paymentController = PaymentController(totalMoney: amount);
    update(); // Notify UI listeners
  }
  
  String get formattedAppCommission => 
    '\$${paymentController?.getAppCommission().toStringAsFixed(2) ?? '0.00'}';
}
```

### In a Widget
```dart
class PaymentSummaryWidget extends StatelessWidget {
  final double totalAmount;
  
  const PaymentSummaryWidget({Key? key, required this.totalAmount}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final payment = PaymentController(totalMoney: totalAmount);
    
    return Column(
      children: [
        Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
        Text('App Commission: \$${payment.getAppCommission().toStringAsFixed(2)}'),
        Text('Bank Fee: \$${payment.getBankFee().toStringAsFixed(2)}'),
        Text('Vendor Profit: \$${payment.getVendorProfit().toStringAsFixed(2)}'),
      ],
    );
  }
}
```

## Sample Outputs

### $100 Payment
```
=== PAYMENT BREAKDOWN ===
Total Money: $100.00

App Commission (2%): $2.00
Bank Fee (0.5%): $0.50
Vendor Profit (97.5%): $97.50

Verification:
Total: $100.00
Match: true
========================
```

### $1,000 Payment
```
=== PAYMENT BREAKDOWN ===
Total Money: $1000.00

App Commission (2%): $20.00
Bank Fee (0.5%): $5.00
Vendor Profit (97.5%): $975.00

Verification:
Total: $1000.00
Match: true
========================
```

## Commission Structure
| Component | Percentage | Example ($100) |
|-----------|------------|----------------|
| App Commission | 2.0% | $2.00 |
| Bank Fee | 0.5% | $0.50 |
| Vendor Profit | 97.5% | $97.50 |
| **Total** | **100%** | **$100.00** |

## Methods Reference

### Getters
- `getAppCommission()` → double: Returns app commission amount
- `getBankFee()` → double: Returns bank fee amount  
- `getVendorProfit()` → double: Returns vendor profit amount
- `getAppCommissionRate()` → double: Returns app commission percentage (2.0)
- `getBankFeeRate()` → double: Returns bank fee percentage (0.5)
- `getVendorProfitRate()` → double: Returns vendor profit percentage (97.5)

### Utility Methods
- `printPaymentBreakdown()` → void: Prints detailed breakdown to console
- `getPaymentBreakdownMap()` → Map<String, dynamic>: Returns breakdown as map
- `updateTotalMoney(double)` → void: Shows how to update (creates new instance needed)

## Notes
- All calculations are done automatically on initialization
- Breakdown is printed to console automatically
- Total money is immutable (final) - create new instance to change
- Includes verification that all components add up to total
- Uses proper rounding to 2 decimal places