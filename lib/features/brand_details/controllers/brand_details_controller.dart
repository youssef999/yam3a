import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/core/models/package.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/features/chat/chat_view.dart';


class BrandDetailsController extends GetxController {
	BrandDetailsController({required this.brand});

	final FirebaseFirestore _firestore = FirebaseFirestore.instance;
	final Brand brand;

	final List<Service> services = [];
	final List<Service> selectedServices = [];
	final List<Package> packages = [];
	final List<Package> selectedPackages = [];
	bool isLoading = false;
	bool isLoadingPackages = false;
	String? errorMessage;
	DateTime? selectedReceiveDate;

	@override
	void onInit() {
		super.onInit();
		fetchServices();
		fetchPackages();
		fetchMinPriceFromFireStore();
    checkUserPayForContact();
	}

  num minValueForOrderPercetage=0;

   bool userContactPay=false;

 checkUserPayForContact() async {
   try {
     String email = storage.userEmail ?? '';
     print("User email from local DB: $email");
     
     if (email.isEmpty) {
       print("❌ No email found in local DB");
       return;
     }
     
     // Query contact_pay collection for matching email
     final snapshot = await _firestore
         .collection('contact_pay')
         .where('email', isEqualTo: email)
         .get();
     
     if (snapshot.docs.isNotEmpty) {
       print("✅ Email found in contact_pay collection");
       print("📄 Documents found: ${snapshot.docs.length}");

       userContactPay=true;
       
       // Print details of found documents
       for (int i = 0; i < snapshot.docs.length; i++) {
         final doc = snapshot.docs[i];
         print("   Document ${i + 1} ID: ${doc.id}");
         print("   Document ${i + 1} data: ${doc.data()}");
       }
     } else {
       print("❌ Email not found in contact_pay collection");
     }
     
   } catch (e, stackTrace) {
     print("💥 Error checking contact_pay collection: $e");
     debugPrint(stackTrace.toString());
   }
   update();
 }


 Future<void> makePhoneCall() async {
   try {
     if (brand.phone.isEmpty) {
       Get.snackbar(
         'error'.tr,
         'phone_not_available'.tr,
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red[100],
         colorText: Colors.red[800],
         icon: Icon(Icons.error_outline, color: Colors.red[800]),
       );
       return;
     }

     final phoneNumber = brand.phone;
     final uri = Uri.parse('tel:$phoneNumber');
     
     if (await canLaunchUrl(uri)) {
       await launchUrl(uri);
       print('📞 Phone call initiated to: $phoneNumber');
     } else {
      await launchUrl(uri);
      //  Get.snackbar(
      //    'error'.tr,
      //    'cannot_make_call'.tr,
      //    snackPosition: SnackPosition.BOTTOM,
      //    backgroundColor: Colors.red[100],
      //    colorText: Colors.red[800],
      //    icon: Icon(Icons.error_outline, color: Colors.red[800]),
      //  );
     }
   } catch (e) {
     print('💥 Error making phone call: $e');
     Get.snackbar(
       'error'.tr,
       'phone_call_failed'.tr,
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.red[100],
       colorText: Colors.red[800],
       icon: Icon(Icons.error_outline, color: Colors.red[800]),
     );
   }
 }

 Future<void> openWhatsAppChat() async {

   try {
     if (brand.phone.isEmpty) {
       Get.snackbar(
         'error'.tr,
         'phone_not_available'.tr,
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red[100],
         colorText: Colors.red[800],
         icon: Icon(Icons.error_outline, color: Colors.red[800]),
       );
       return;
     }

     // Clean phone number (remove spaces, dashes, etc.)
     String cleanPhone = brand.phone.replaceAll(RegExp(r'[^\d+]'), '');
     
     // Add country code if not present (assuming Bahrain +973)
     if (!cleanPhone.startsWith('+')) {
       if (cleanPhone.startsWith('973')) {
         cleanPhone = '+$cleanPhone';
       } else {
         cleanPhone = '+973$cleanPhone';
       }
     }
     cleanPhone = cleanPhone.replaceAll('+973', '');
     print("Clean phone number for WhatsApp: $cleanPhone");

     final message = Uri.encodeComponent('Hello! I\'m interested in your services from ${brand.name}.');
     final whatsappUrl = 'https://wa.me/$cleanPhone?text=$message';
     final uri = Uri.parse(whatsappUrl);
     
     if (await canLaunchUrl(uri)) {
       await launchUrl(uri, mode: LaunchMode.externalApplication);
       print('💬 WhatsApp chat opened to: $cleanPhone');
     } else {
       // Fallback to SMS if WhatsApp is not available
       final smsUri = Uri.parse('sms:$cleanPhone?body=${Uri.encodeComponent('Hello! I\'m interested in your services from ${brand.name}.')}');
       if (await canLaunchUrl(smsUri)) {
         await launchUrl(smsUri);
         print('📱 SMS opened to: $cleanPhone');
       } else {
         await launchUrl(uri, mode: LaunchMode.externalApplication);
       
       }
     }
   } catch (e) {
     print('💥 Error opening WhatsApp: $e');
     Get.snackbar(
       'error'.tr,
       'whatsapp_failed'.tr,
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.red[100],
       colorText: Colors.red[800],
       icon: Icon(Icons.error_outline, color: Colors.red[800]),
     );
   }
 }

 /// Open chat with brand (replaces WhatsApp when user has paid for contact)
 Future<void> openChatWithBrand() async {
   try {
     if (brand.email.isEmpty) {
       Get.snackbar(
         'error'.tr,
         'brand_email_not_available'.tr,
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red[100],
         colorText: Colors.red[800],
         icon: Icon(Icons.error_outline, color: Colors.red[800]),
       );
       return;
     }

     print('💬 Opening chat with brand: ${brand.name} (${brand.email})');
     
     // Navigate to chat view with smooth animation
     Get.to(
       () => ChatView(brand: brand),
       transition: Transition.rightToLeft,
       duration: const Duration(milliseconds: 300),
     );
     
   } catch (e) {
     print('💥 Error opening chat: $e');
     Get.snackbar(
       'error'.tr,
       'failed_to_open_chat'.tr,
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.red[100],
       colorText: Colors.red[800],
       icon: Icon(Icons.error_outline, color: Colors.red[800]),
     );
   }
 }  fetchMinPriceFromFireStore() async {
    try {
      final snapshot = await _firestore
          .collection('minPrice')
          .doc('qhxZDYbnbBwevwZ7Waku')
          .get();
      
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        minValueForOrderPercetage = data['price'] ?? 0;
      } else {
        minValueForOrderPercetage = 0;
      }
      
      update();
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch min price: $e');
      debugPrint(stackTrace.toString());
      minValueForOrderPercetage = 0;
    }
    print('minValueForOrderPercetage: $minValueForOrderPercetage');
  }

  num totalPriceWithMinValue=0;

  getOrderMinTotal(num totalOrder) {
    if (minValueForOrderPercetage > 0 && totalOrder < minValueForOrderPercetage) {
      totalPriceWithMinValue = totalOrder *(minValueForOrderPercetage / 100);
      //minValueForOrderPercetage;
    } else {
      totalPriceWithMinValue = totalOrder *(minValueForOrderPercetage / 100);
     // totalPriceWithMinValue = totalOrder;
    }
    return totalPriceWithMinValue;
  }


	Future<void> fetchServices() async {
    print('Fetching services for brand: ${brand.email}');
		try {
			isLoading = true;
			update();

			final snapshot = await _firestore
					.collection('services')
					.where('brandEmail', isEqualTo: brand.email)
					.get();

			services
				..clear()
				..addAll(snapshot.docs.map(Service.fromDocument));

			errorMessage = null;
			} catch (e, stackTrace) {
				errorMessage = e.toString();
			debugPrint('Brand services fetch failed: $e');
			debugPrint(stackTrace.toString());
		} finally {
			isLoading = false;
			update();
		}
	}

	double? get startingPrice {
		if (services.isEmpty) return null;
		return services.map((service) => service.price).reduce(min);
	}

	int? get minPreparationDays {
		if (services.isEmpty) return null;
		return services.map((service) => service.minDays).reduce(min);
	}

	List<String> get serviceCategories {
		final categories = <String>{};
		for (final service in services) {
			if (service.categoryEn.isNotEmpty) categories.add(service.categoryEn);
			if (service.category.isNotEmpty) categories.add(service.category);
		}
		return categories.toList();
	}

	// Checkbox functionality for services
	bool isServiceSelected(Service service) {
		return selectedServices.any((selected) => selected.id == service.id);
	}

	void toggleServiceSelection(Service service) {
		if (isServiceSelected(service)) {
			selectedServices.removeWhere((selected) => selected.id == service.id);
		} else {
			selectedServices.add(service);
		}
		update();
	}

	void clearSelectedServices() {
		selectedServices.clear();
		update();
	}

	double get totalSelectedPrice {
		return selectedServices.fold(0.0, (total, service) => total + service.price);
	}

	int get selectedServicesCount {
		return selectedServices.length;
	}

	// Package functionality
	Future<void> fetchPackages() async {
		try {
			isLoadingPackages = true;
			update();

			final snapshot = await _firestore
					.collection('packages')
					.where('brandName', isEqualTo: brand.name)
					.get();

			packages
				..clear()
				..addAll(snapshot.docs.map(Package.fromDocument));

			} catch (e, stackTrace) {
			debugPrint('Brand packages fetch failed: $e');
			debugPrint(stackTrace.toString());
		} finally {
			isLoadingPackages = false;
			update();
		}
	}

	// Package selection functionality
	bool isPackageSelected(Package package) {
		return selectedPackages.any((selected) => selected.id == package.id);
	}

	void togglePackageSelection(Package package) {
		if (isPackageSelected(package)) {
			selectedPackages.removeWhere((selected) => selected.id == package.id);
		} else {
			selectedPackages.add(package);
		}
		update();
	}

	void clearSelectedPackages() {
		selectedPackages.clear();
		update();
	}

	double get totalSelectedPackagePrice {
		return selectedPackages.fold(0.0, (total, package) => total + package.price);
	}

	int get selectedPackagesCount {
		return selectedPackages.length;
	}

	// Date picker functionality
	Future<bool> selectReceiveDate() async {
		final now = DateTime.now();
		// Use brand's deliveryTime to determine the minimum selectable date
		final minDeliveryDays = brand.deliveryTime; // Get deliveryTime from brand model
		final firstDate = now.add(Duration(days: minDeliveryDays)); // Can't select before deliveryTime days
		final lastDate = now.add(const Duration(days: 365)); // Up to 1 year in future
		if (kDebugMode) {
			print('📅 Date picker setup:');
			print('Brand delivery time: $minDeliveryDays days');
			print('First selectable date: ${firstDate.day}/${firstDate.month}/${firstDate.year}');
		}
		
		final pickedDate = await showDatePicker(
			context: Get.context!,
			initialDate: firstDate,
			firstDate: firstDate,
			lastDate: lastDate,
			helpText: 'select_receive_date'.tr,
			fieldLabelText: 'receive_date'.tr,
			builder: (context, child) {
				return Theme(
					data: Theme.of(context).copyWith(
						colorScheme: ColorScheme.light(
							primary: const Color(0xffE28743),
							onPrimary: Colors.white,
							onSurface: Colors.black,
						),
					),
					child: child!,
				);
			},
		);
		
		if (pickedDate != null) {
			selectedReceiveDate = pickedDate;
			update();
			return true;
		}
		
		return false;
	}

	String get formattedReceiveDate {
		if (selectedReceiveDate == null) return 'not_selected'.tr;
		
		final day = selectedReceiveDate!.day.toString().padLeft(2, '0');
		final month = selectedReceiveDate!.month.toString().padLeft(2, '0');
		final year = selectedReceiveDate!.year;
		
		return '$day/$month/$year';
	}

	void clearReceiveDate() {
		selectedReceiveDate = null;
		update();
	}

	/// Get the minimum delivery date based on brand's deliveryTime
	DateTime get minimumDeliveryDate {
		final now = DateTime.now();
		return now.add(Duration(days: brand.deliveryTime));
	}

	/// Get delivery information text
	String get deliveryInfoText {
		if (brand.deliveryTime <= 1) {
			return 'available_next_day'.tr;
		} else {
			return 'available_after_days'.trParams({
				'days': brand.deliveryTime.toString()
			});
		}
	}

	/// Check if a date is valid for delivery
	bool isValidDeliveryDate(DateTime date) {
		final minDate = minimumDeliveryDate;
		return date.isAfter(minDate) || date.isAtSameMomentAs(minDate);
	}


}
