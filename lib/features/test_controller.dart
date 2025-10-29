



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> addDeviceTokenToAllBrands() async {
  final token = await FirebaseMessaging.instance.getToken();
  if (token == null) {
    print('No device token available');
    return;
  }

  final brands = await FirebaseFirestore.instance.collection('brands').get();
  for (final doc in brands.docs) {
    await doc.reference.update({
      'deviceTokens': FieldValue.arrayUnion([token])
    });
  }
  print('Device token added to all brands!');
}