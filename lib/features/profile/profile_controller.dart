import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/core/utils/user_data_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _box = GetStorage();
  
  bool isLoading = false;
  bool isUpdatingEmail = false;
  String userName = '';
  String userEmail = '';
  String currentLanguage = 'ar';
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadLanguage();
  }
  
  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    super.onClose();
  }
  
  void loadUserData() {
    userName = storage.userName ?? 'user'.tr;
    userEmail = storage.userEmail ?? '';
    emailController.text = userEmail;
    nameController.text = userName;
    
    // If user name is empty or null, fetch it from Firebase
    if (storage.needsUserNameFetch()) {
      _ensureUserNameLoaded();
    }
    
    update();
  }
  
  Future<void> _ensureUserNameLoaded() async {
    await UserDataManager.ensureUserNameIsAvailable();
    // Reload data after fetching
    userName = storage.userName ?? 'user'.tr;
    nameController.text = userName;
    update();
  }
  
  Future<void> fetchUserNameFromFirebase() async {
    try {
      final email = storage.userEmail;
      if (email == null || email.isEmpty) return;
      
      final doc = await _firestore.collection('users').doc(email).get();
      if (doc.exists) {
        final data = doc.data();
        final firebaseName = data?['name'] ?? data?['userName'] ?? '';
        
        if (firebaseName.isNotEmpty) {
          // Save the fetched name to local storage
          await storage.saveUserName(firebaseName);
          userName = firebaseName;
          nameController.text = firebaseName;
          update();
        }
      }
    } catch (e) {
      print('Error fetching user name from Firebase: $e');
      // If Firebase fails, you could also try other sources or keep default
    }
  }
  
  /// Initialize user data - call this when app starts or user logs in
  Future<void> initializeUserData() async {
    loadUserData();
    
    // Force fetch from Firebase if we don't have complete user data
    if (!storage.hasCompleteUserData()) {
      await fetchUserNameFromFirebase();
    }
  }
  
  /// Static method to ensure user data is available globally
  static Future<void> ensureUserDataLoaded() async {
    if (storage.needsUserNameFetch()) {
      final controller = ProfileController();
      await controller.fetchUserNameFromFirebase();
    }
  }
  
  void loadLanguage() {
    currentLanguage = _box.read('locale') ?? 'ar';
    update();
  }
  
  Future<void> changeLanguage(String langCode) async {
    try {
      currentLanguage = langCode;
      await _box.write('locale', langCode);
      
      final Locale newLocale = Locale(langCode);
      await Get.updateLocale(newLocale);
      
      Get.snackbar(
        'success'.tr,
        'language_changed_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      update();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_change_language'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  
  Future<void> updateEmail(String newEmail) async {
    if (newEmail.isEmpty || !GetUtils.isEmail(newEmail)) {
      Get.snackbar(
        'error'.tr,
        'invalid_email'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isUpdatingEmail = true;
      update();
      
      // Update in Firestore
      final oldEmail = storage.userEmail;
      if (oldEmail != null && oldEmail.isNotEmpty) {
        await _firestore.collection('users').doc(oldEmail).update({
          'email': newEmail,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      // Update local storage
      await storage.saveUserEmail(newEmail);
      userEmail = newEmail;
      emailController.text = newEmail;
      
      Get.back();
      Get.snackbar(
        'success'.tr,
        'email_updated_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      update();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_update_email'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdatingEmail = false;
      update();
    }
  }
  
  Future<void> updateName(String newName) async {
    if (newName.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'name_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading = true;
      update();
      
      // Update in Firestore
      final email = storage.userEmail;
      if (email != null && email.isNotEmpty) {
        await _firestore.collection('users').doc(email).update({
          'name': newName,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      // Update local storage
      await storage.saveUserName(newName);
      userName = newName;
      nameController.text = newName;
      
      Get.back();
      Get.snackbar(
        'success'.tr,
        'name_updated_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      update();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_update_name'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
  
  Future<void> contactUs() async {
    const email = 'support@yamaa.com';
    const subject = 'Support Request';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject',
    );
    
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_open_email'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_contact'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  
  Future<void> logout() async {
    try {
      isLoading = true;
      update();
      
      // Clear all user data from local storage
      await storage.logout();
      
      Get.snackbar(
        'success'.tr,
        'logged_out_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to login screen and clear navigation stack
      Get.offAllNamed('/login'); // Adjust route name based on your routing
      
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'logout_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
  
  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'logout_confirmation'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'logout_warning'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('cancel'.tr),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GetBuilder<ProfileController>(
                      builder: (controller) {
                        return ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () {
                                  Get.back();
                                  logout();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('logout'.tr),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void showLanguageDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff5A1E3D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Color(0xff5A1E3D),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'select_language'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLanguageOption('العربية', 'ar', '🇸🇦'),
              const SizedBox(height: 12),
              _buildLanguageOption('English', 'en', '🇺🇸'),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLanguageOption(String label, String code, String flag) {
    final isSelected = currentLanguage == code;
    
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return InkWell(
          onTap: () {
            Get.back();
            changeLanguage(code);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xff5A1E3D).withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? const Color(0xff5A1E3D)
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xff5A1E3D) : Colors.black87,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xff5A1E3D),
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  void showEmailDialog() {
    final TextEditingController dialogEmailController = TextEditingController(text: userEmail);
    
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xffE28743).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.email,
                      color: Color(0xffE28743),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'change_email'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: dialogEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'new_email'.tr,
                  hintText: 'enter_new_email'.tr,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('cancel'.tr),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GetBuilder<ProfileController>(
                      builder: (controller) {
                        return ElevatedButton(
                          onPressed: controller.isUpdatingEmail
                              ? null
                              : () => updateEmail(dialogEmailController.text),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffE28743),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isUpdatingEmail
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('update'.tr),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void showAboutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff5A1E3D), Color(0xffE28743)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'yamaa'.tr,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5A1E3D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'version'.tr + ' 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'about_app_description'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                 
                    Text(
                      '© 2025 Yamaa. All rights reserved.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A1E3D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('close'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
