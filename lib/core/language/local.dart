import 'package:get/get.dart';

class MyLocal implements Translations {
 
  
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {

"dont_have_account":"ليس لديك حساب؟",
"Email":"البريد الإلكتروني",
"Password":"كلمة المرور",
"Yamaa":"يمعة",
      "login_successful":'تم تسجيل الدخول بنجاح',

      // Profile translations
      'account_settings': 'إعدادات الحساب',
      'support': 'الدعم',
      'language': 'اللغة',
      'select_language': 'اختر اللغة',
      'change_email': 'تغيير البريد الإلكتروني',
      'new_email': 'البريد الإلكتروني الجديد',
      'enter_new_email': 'أدخل البريد الإلكتروني الجديد',
      'contact_us': 'اتصل بنا',
      'get_help_support': 'احصل على المساعدة والدعم',
      'about_app': 'حول التطبيق',
      'version': 'الإصدار',
      'about_app_description': 'تطبيق يمعة هو منصة متكاملة للتسوق الذكي توفر لك تجربة تسوق سهلة وآمنة مع خدمات توصيل سريعة ودعم على مدار الساعة.',
      'your_shopping_companion': 'رفيقك في التسوق الذكي',
      'secure': 'آمن',
      'yamaa': 'يمعة',
      'close': 'إغلاق',
      'cancel': 'إلغاء',
      'update': 'تحديث',
      'success': 'نجح',
      'error': 'خطأ',
      'language_changed_successfully': 'تم تغيير اللغة بنجاح',
      'failed_to_change_language': 'فشل في تغيير اللغة',
      'invalid_email': 'البريد الإلكتروني غير صالح',
      'email_updated_successfully': 'تم تحديث البريد الإلكتروني بنجاح',
      'failed_to_update_email': 'فشل في تحديث البريد الإلكتروني',
      'name_required': 'الاسم مطلوب',
      'name_updated_successfully': 'تم تحديث الاسم بنجاح',
      'failed_to_update_name': 'فشل في تحديث الاسم',
      'cannot_open_email': 'لا يمكن فتح البريد الإلكتروني',
      'failed_to_contact': 'فشل في الاتصال',
      'user': 'مستخدم',

      // Orders translations
      'my_orders': 'طلباتي',
      'loading_orders': 'جاري تحميل الطلبات',
      'failed_to_load_orders': 'فشل في تحميل الطلبات',
      'all_orders': 'كل الطلبات',
      'order_pending': 'قيد الانتظار',
      'order_accepted': 'مقبول',
      'order_completed': 'مكتمل',
      'order_canceled': 'ملغى',
      'no_orders_found': 'لا توجد طلبات',
      'no_orders_description': 'لم تقم بأي طلبات بعد',
      'no_orders_for_status': 'لا توجد طلبات بهذه الحالة',
      'order': 'طلب',
      'items': 'عناصر',
      'view_details': 'عرض التفاصيل',
      'cancel_order_title': 'إلغاء الطلب؟',
      'cancel_order_message': 'هل أنت متأكد أنك تريد إلغاء هذا الطلب؟',
      'no': 'لا',
      'yes_cancel': 'نعم، إلغاء',
      'order_status_updated': 'تم تحديث حالة الطلب',
      'failed_to_update_order': 'فشل في تحديث الطلب',
      'order_details': 'تفاصيل الطلب',
      'order_information': 'معلومات الطلب',
      'date': 'التاريخ',
      'time': 'الوقت',
      'order_type': 'نوع الطلب',
      'payment_status': 'حالة الدفع',
      'delivery_location': 'موقع التوصيل',
      'pending': 'قيد الانتظار',
      'accepted': 'مقبول',
      'completed': 'مكتمل',
      'canceled': 'ملغى',

      'product_categories': 'فئات المشتريات',
      'categories_available': 'فئة متاحة',
      'browse_service_categories_description': 'تصفح فئات الخدمات المختلفة واختر ما تحتاجه',
      
      "select_service_category":"اختر قسم الخدمة التي تريد ",
      "select_product_category":"اختر قسم المشتريات الذي تريد ",

       
      // Service Checkout Arabic translations
      'service_checkout': 'إتمام طلب الخدمة',
      'select_payment_method': 'اختر طريقة الدفع',
      'cash_on_delivery': 'الدفع عند الاستلام',
      'credit_card': 'بطاقة ائتمان',
      'debit_card': 'بطاقة خصم',
      
      // Location Detection translations
      'detect_location': 'اكتشاف الموقع',
      'location_detection': 'اكتشاف الموقع',
      'location_detection_desc': 'سنساعدك في اكتشاف موقعك الحالي لتوفير خدمات أفضل وتجربة شخصية مميزة.',
      'permission_required': 'إذن مطلوب',
      'location_permission_desc': 'إذن الموقع مطلوب لاكتشاف موقعك الحالي.',
      'grant_permission': 'منح الإذن',
      'open_app_settings': 'فتح إعدادات التطبيق',
      'locating_device': 'تحديد موقع الجهاز',
      'resolving_address': 'تحويل العنوان',
      'validating_data': 'التحقق من البيانات',
      'updating_profile': 'تحديث الملف الشخصي',
      'starting_detection': 'بدء الاكتشاف',
      'getting_gps_coordinates': 'جاري الحصول على إحداثيات GPS...',
      'converting_to_address': 'جاري التحويل إلى عنوان...',
      'validating_location_data': 'جاري التحقق من بيانات الموقع...',
      'saving_to_profile': 'جاري الحفظ في ملفك الشخصي...',
      'preparing': 'جاري التحضير...',
      'please_wait_detecting': 'يرجى الانتظار أثناء اكتشاف موقعك...',
      'same_location_detected': 'تم اكتشاف نفس الموقع!',
      'same_location_desc': 'أنت ما زلت في نفس الموقع. لا حاجة للتحديث.',
      'unchanged': 'لم يتغير',
      'force_update': 'فرض التحديث',
      'continue': 'متابعة',
      'location_available': 'الموقع متاح',
      'last_saved_location': 'آخر موقع محفوظ',
      'check_location_changed': 'هل تريد التحقق من تغيير موقعك؟',
      'check_current_location': 'فحص الموقع الحالي',
      'clear_saved_location': 'مسح الموقع المحفوظ',
      'location_updated': ' تم تحديد الموقع بنجاح ',
      //'تم تحديث الموقع!',
      'location_detected': 'تم اكتشاف الموقع!',
      'location_updated_desc': 'تم تحديث موقعك وحفظه في ملفك الشخصي.',
      'location_detected_desc': 'تم اكتشاف موقعك بنجاح وحفظه في ملفك الشخصي.',
      'moved_distance': 'انتقلت مسافة',
      'meters': 'متر',
      'location_details': 'تفاصيل الموقع',
      'updated': 'محدث',
      'new': 'جديد',
      'country': 'الدولة',
      'city': 'المدينة',
      'location': 'الموقع',
      'full_address': 'العنوان الكامل',
      'coordinates': 'الإحداثيات',
      'detect_again': 'اكتشاف مرة أخرى',
      'ready_to_detect_location': 'جاهز لاكتشاف الموقع',
      'detect_location_desc': 'اضغط على الزر أدناه لاكتشاف موقعك الحالي تلقائياً. سنحدد دولتك ومدينتك ونحفظها في ملفك الشخصي للحصول على تجربة أفضل.',
      'detect_my_location': 'اكتشف موقعي',
      'unknown': 'غير معروف',
      'current_location': 'الموقع الحالي',
      'paypal': 'باي بال',
      'apple_pay': 'أبل باي',
      'google_pay': 'جوجل باي',
      'pay_cash_on_delivery_desc': 'ادفع نقداً عند استلام الخدمة',
      'pay_with_credit_card_desc': 'ادفع بأمان باستخدام بطاقة الائتمان',
      'pay_with_debit_card_desc': 'ادفع مباشرة من حسابك البنكي',
      'pay_with_paypal_desc': 'ادفع باستخدام حساب باي بال',
      'pay_with_apple_pay_desc': 'ادفع بسرعة باستخدام أبل باي',
      'pay_with_google_pay_desc': 'ادفع بسرعة باستخدام جوجل باي',
      'service_details': 'تفاصيل الخدمة',
      'customer_details': 'بيانات العميل',
      'no_location_detected': 'لم يتم تحديد الموقع', 
       'order_data_invalid': 'بيانات الطلب غير صحيحة',
      'pricing_breakdown': 'تفصيل الأسعار',
      'service_fee': 'رسوم الخدمة',
      'tax_fee': 'الضريبة (14%)',
      'delivery_fee': 'رسوم التوصيل',
      'total_amount': 'المبلغ الإجمالي',
      'scheduled_date': 'التاريخ المجدول',
      'scheduled_time': 'الوقت المجدول',
      'not_selected': 'غير محدد',
      'place_order': 'تأكيد الطلب',
      'processing_order': 'جاري معالجة الطلب...',
      'order_placed_successfully': 'تم تأكيد الطلب بنجاح!',
      'failed_to_place_order': 'فشل في تأكيد الطلب. حاول مرة أخرى.',
      'secure_checkout': 'دفع آمن',
      'confirmation': 'التأكيد',
      'fast_delivery': 'توصيل سريع',
      '24_7_support': 'دعم ٢٤/٧',
      'total_amount': 'المبلغ الإجمالي',
      'order_protection': 'حماية الطلب',
      'secure_payment': 'دفع آمن',
      'customer_support': 'دعم العملاء',
      '24/7_support': 'دعم 24/7',
      'price_breakdown': 'تفصيل السعر',
      'delivery_fee': 'رسوم التوصيل',
      'estimated_delivery_time': 'وقت التوصيل المتوقع',
      'delivery_within_hours': 'التوصيل خلال 2-4 ساعات',
      'my_profile': 'ملفي الشخصي',
      'manage_account_preferences': 'إدارة إعدادات الحساب',
      'verified_member': 'عضو موثق',
      'quick_actions': 'إجراءات سريعة',
      'orders_history': 'تاريخ الطلبات',
      'view_order_history': 'عرض تاريخ الطلبات',
      'view_service_history': 'عرض تاريخ الخدمات',
      'support_help': 'الدعم والمساعدة',
      'about_app': 'حول التطبيق',
      'app_information': 'معلومات التطبيق',
      'made_with_love': 'صنع بحب في مصر 🇪🇬',
      'failed_to_load_user_data': 'فشل في تحميل بيانات المستخدم',
      'failed_to_create_order': 'فشل في إنشاء الطلب',
      'user_email_required': 'البريد الإلكتروني مطلوب',
      'user_name_required': 'اسم المستخدم مطلوب',
      'user_phone_required': 'رقم الهاتف مطلوب',
      'service_data_required': 'بيانات الخدمة مطلوبة',
      'location_data_required': 'بيانات الموقع مطلوبة',
      'service_order_details': 'تفاصيل طلب الخدمة',
      'order_data_incomplete': 'بيانات الطلب غير مكتملة',
      'please_complete_previous_steps': 'يرجى إكمال جميع الخطوات السابقة قبل المتابعة',
      'go_back': 'العودة للخلف',
      'address': 'العنوان',
      'name': 'الاسم',
      'egp': 'جنيه',
      'retry': 'إعادة المحاولة',

      'location_loaded_successfully': 'تم تحميل الموقع بنجاح',
      'location_selected_successfully': 'تم اختيار الموقع بنجاح',
      'please_select_location_first': 'يرجى اختيار موقع أولاً',
      'failed_to_load_locations': 'فشل في تحميل المواقع',
      'location_deleted_successfully': 'تم حذف الموقع بنجاح',
      'failed_to_delete_location': 'فشل في حذف الموقع',
      'location_archived': 'تم أرشفة الموقع',
      'location_restored': 'تم استعادة الموقع',
      'failed_to_update_location': 'فشل في تحديث الموقع',
      'unknown_date': 'تاريخ غير معروف',
      'no_coordinates_available': 'لا توجد إحداثيات متاحة',
      'no_saved_locations': 'لا توجد مواقع محفوظة',
      'saved_locations': 'مواقع محفوظة',
      'unnamed_location': 'موقع غير مسمى',

      // Regi      'Smart_shop': 'متجر ذكي',
      'your_smart_shopping_destination': 'وجهتك التسوقية الذكية',
      // Services translations
      'home_services': 'الخدمات المنزلية',
      'services': 'خدمات',
  'no_services_found': 'لم يتم العثور على خدمات',
      'no_brands_available': 'لا توجد علامات تجارية متاحة',
      'brand_details': 'تفاصيل العلامة التجارية',
      'services_by_brand': 'خدمات العلامة التجارية',
      'starting_from': 'ابتداء من',
      'minimum_days': 'الحد الأدنى للأيام',
      'days': 'أيام',
      'login_to_continue': 'سجل دخولك للمتابعة',
      'welcome_back': 'مرحباً بعودتك',
      'professional_services': 'خدمات مهنية',
      'please_enter_email': 'يرجى إدخال البريد الإلكتروني',
      'please_enter_valid_email': 'يرجى إدخال بريد إلكتروني صحيح',
      'please_enter_password': 'يرجى إدخال كلمة المرور',
      'password_min_length': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'forgot_password': 'نسيت كلمة المرور؟',
      'error': 'خطأ',
      'success': 'نجح',
      'loading': 'جاري التحميل...',
      'try_again': 'حاول مرة أخرى',
      'something_went_wrong': 'حدث خطأ ما',
      'no_internet_connection': 'لا يوجد اتصال بالإنترنت',
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'edit': 'تعديل',
      'ok': 'موافق',
      'yes': 'نعم',
      'no': 'لا',
      'back': 'رجوع',
      'next': 'التالي',
      'finish': 'إنهاء',
      'skip': 'تخطى',
      'visit_website': 'زيارة الموقع',
      'save_vendor': 'حفظ المورد',
      'write_review': 'اكتب مراجعة',
      'delivery_charges': 'رسوم التوصيل',
      'minimum_days': 'الحد الأدنى للأيام',
      'check_availability': 'فحص التوفر',
      'dates': 'التواريخ',
      'advance': 'دفعة مقدمة',
      'starting_from': 'ابتداء من',
      'preparation': 'التحضير',
      'certifications': 'الشهادات',
      'verified': 'موثق',
      'services': 'الخدمات',
      'packages': 'الباقات',
      'about': 'حول',
      'checkout': 'الدفع',
      'call': 'اتصال',
      'chat': 'محادثة', 
      'share': 'مشاركة',
      'back': 'رجوع',
      'sort_by_rating': 'ترتيب حسب التقييم',
      'sort_by_price': 'ترتيب حسب السعر',
      'book_now': 'احجز الآن',
      'view_details': 'عرض التفاصيل',
      'hide_details': 'إخفاء التفاصيل',
      'category': 'الفئة',
      'search_services': 'البحث في الخدمات',
      'search_hint': 'ابحث عن الخدمات...',
      'close': 'إغلاق',
      'book_service': 'حجز الخدمة',
      'provider': 'مقدم الخدمة',
      'confirm_booking': 'تأكيد الحجز',
      
      // Service Benefits translations
      'service_benefits': 'مزايا الخدمة',
      'within_30km': 'في نطاق ٣٠ كم',
      'fast_service': 'خدمة سريعة',
      'secure_service': 'خدمة آمنة',
      'certified_providers': 'مزودين معتمدين',
      
      // Service Details translations
      'service_description': 'وصف الخدمة',
      'service_provider': 'مقدم الخدمة',
      'professional_service_provider': 'مقدم خدمة محترف',
      'contact_feature_coming_soon': 'ميزة التواصل قريباً',
      'book_appointment': 'حجز موعد',
      'select_date': 'اختر التاريخ',
      'select_date_hint': 'اختر تاريخ الخدمة',
      'tap_to_select_time': 'انقر لتحديد الوقت',
      'service_instructions_tip': 'أضف أي متطلبات خاصة أو تفاصيل إضافية',
      'select_time': 'اختر الوقت',
      'add_special_instructions': 'أضف تعليمات خاصة للخدمة...',
      'total_price': 'السعر الإجمالي',
      'order_now': 'اطلب الآن',
      'booking_requirements': 'متطلبات الحجز',
      'please_complete_booking_requirements': 'يرجى إكمال متطلبات الحجز قبل المتابعة:',
      'select_preferred_date': 'اختر التاريخ المفضل',
      'select_preferred_time': 'اختر الوقت المفضل',
      'please_select_date': 'يرجى اختيار التاريخ',
      'please_select_time': 'يرجى اختيار الوقت',
      'service_booked_successfully': 'تم حجز الخدمة بنجاح',
      'booking_failed': 'فشل في حجز الخدمة',
      'understood': 'مفهوم',
      
      // Service Location translations
      'service_location': 'موقع الخدمة',
      'location_setup_progress': 'تقدم إعداد الموقع',
      'completed': 'مكتمل',
      'tap_to_get_current_location': 'اضغط للحصول على موقعك الحالي',
      'detecting_location': 'جاري اكتشاف الموقع...',
      'location_detected_successfully_old': 'تم اكتشاف الموقع بنجاح',
      'choose_city': 'اختر المدينة',
      'enter_full_address': 'أدخل العنوان الكامل',
      'address_required': 'العنوان مطلوب',
      'floor_apartment': 'الطابق / الشقة',
      'phone_required': 'رقم الهاتف مطلوب',
      "address":"ادخل العنوان الخاص بك ",
      'invalid_phone': 'رقم هاتف غير صحيح',
      'nearby_landmark': " علامة مميزة ",
      'landmark': 'علامة مميزة ',
      'clear_form': 'مسح النموذج',
      'clear_form_confirmation': 'هل أنت متأكد من مسح جميع البيانات؟',
      'clear': 'مسح',
      'please_enter_address': 'يرجى إدخال العنوان',
      'invalid_phone_number': 'رقم هاتف غير صحيح',
      'location_saved_successfully': 'تم حفظ الموقع بنجاح',
      'booking_summary': 'ملخص الحجز',
      'review_selected_service_details': 'مراجعة تفاصيل الخدمة المحددة',
      'booking_date_selected': 'تاريخ الحجز المحدد',
      'booking_time_selected': 'وقت الحجز المحدد',
      'order_placed_successfully': 'تم تقديم الطلب بنجاح',
      'select_location_on_map': 'اختر الموقع على الخريطة',
      'center_on_current_location': 'التمركز على الموقع الحالي',
      'tap_or_drag_marker_to_select': 'اضغط أو اسحب العلامة لاختيار الموقع',
      'selected_location': 'الموقع المحدد',
      'tap_to_select_location': 'اضغط لتحديد الموقع',
      'coordinates': 'الإحداثيات',
      'confirm_location': 'تأكيد الموقع',
      'location_selected_successfully': 'تم تحديد الموقع بنجاح',
      'location_selected_from_map': 'تم اختيار الموقع من الخريطة',
      'map_error': 'خطأ في الخريطة',
      'unable_to_get_current_location': 'غير قادر على تحديد الموقع الحالي',
      'saved_locations': 'المواقع المحفوظة',
      'use_previously_saved_location': 'استخدم موقعاً محفوظاً مسبقاً',
      'view_saved_locations': 'عرض المواقع المحفوظة',
      'your_saved_locations': 'مواقعك المحفوظة',
      'select_from_previously_saved': 'اختر من المواقع المحفوظة مسبقاً',
      'refresh_locations': 'تحديث المواقع',
      'search_saved_locations': 'بحث في المواقع المحفوظة',
      'use_selected_location': 'استخدم الموقع المحدد',
      'please_select_location_first': 'يرجى تحديد موقع أولاً',
      'no_locations_match_search': 'لا توجد مواقع تطابق البحث',
      'no_saved_locations_yet': 'لا توجد مواقع محفوظة بعد',
      'save_locations_to_see_them_here': 'احفظ المواقع لرؤيتها هنا',
      'add_new_location': 'إضافة موقع جديد',
      'delete_location': 'حذف الموقع',
      'delete_location_confirmation': 'هل أنت متأكد من حذف هذا الموقع؟',
      'location_deleted_successfully': 'تم حذف الموقع بنجاح',
      'failed_to_delete_location': 'فشل في حذف الموقع',
      'failed_to_load_locations': 'فشل في تحميل المواقع',
      'location_loaded_successfully': 'تم تحميل الموقع بنجاح',
      'failed_to_load_location': 'فشل في تحميل الموقع',
      'saved_on': 'حُفظ في',
      'locations_found': 'موقع موجود',
      'no_coordinates_available': 'لا توجد إحداثيات متاحة',
      'unknown_date': 'تاريخ غير معروف',
      'unnamed_location': 'موقع غير مسمى',
      
      'booking_confirmed': 'تم تأكيد الحجز بنجاح',
      'explore_offer': 'استكشف العرض',
      'service_categories': 'فئات الخدمات',
      'see_all': 'عرض الكل',
      'all': 'الكل',
      'categories': 'الفئات',
      'found': 'وُجد',
      'refresh': 'تحديث',
      'explore': 'استكشف',
      'orders': 'الطلبات',
      'coming_soon': 'قريباً',
      'stay_tuned_for_updates': 'ابق على اطلاع للتحديثات',
      'under_development': 'تحت التطوير',
      'available_services': 'الخدمات المتاحة',
      // ServiceAllCat translations
      'all_categories': 'جميع الفئات',
      'categories_available': 'الفئات المتاحة',
      'categories_found': 'فئة موجودة',
      'no_categories': 'لا توجد فئات',
      "ad_desc":"وصف الإعلان",
      'no_categories_description': 'لا توجد فئات متاحة حالياً. تحقق مرة أخرى لاحقاً',
      'search_categories': 'البحث في الفئات',
      'search_categories_hint': 'ابحث في الفئات...',
      'tap_to_explore': 'اضغط للاستكشاف',
      'category': 'فئة',
      'category_selected': 'تم اختيار الفئة',
      'join_our_community': 'انضم إلى مجتمعنا',
      'create_account_start_shopping': 'أنشئ حساباً وابدأ التسوق',
      'full_name': 'الاسم الكامل',
      'phone_number': 'رقم الهاتف',
      'select_country': 'اختر الدولة',
      'select_city': 'اختر المدينة',
      'please_enter_phone': 'يرجى إدخال رقم الهاتف',
      'please_select_country': 'يرجى اختيار الدولة',
      'please_select_city': 'يرجى اختيار المدينة',
      'enter_area': 'أدخل المنطقة',
      'enter_floor': 'أدخل الطابق',
      'enter_apartment': 'أدخل رقم الشقة',
      'enter_notes': 'أدخل ملاحظات',
      'enter_phone': 'أدخل رقم الهاتف',
      "another_location":"موقع آخر ",
      'open_map_get_location': 'افتح الخريطة واحصل على الموقع',
      'getting_location': 'جاري الحصول على الموقع...',
      'area_is_required': 'المنطقة مطلوبة',
      'phone_is_required': 'رقم الهاتف مطلوب',
      
      // City names in Arabic
      'city_manama': 'المنامة',
      'city_riffa': 'الرفاع',
      'city_muharraq': 'المحرق',
      'city_hamad_town': 'مدينة حمد',
      'city_aali': 'عالي',
      'city_isa_town': 'مدينة عيسى',
      'city_sitra': 'سترة',
      'city_budaiya': 'البديع',
      'city_jidhafs': 'جدحفص',
      'city_al_malikiyah': 'المالكية',
      'city_sanabis': 'السنابس',
      'city_tubli': 'توبلي',
      'city_dar_kulaib': 'دار كليب',
      'city_hidd': 'الحد',
      'city_al_markh': 'المرخ',
      'city_sanad': 'سند',
      
      // New location messages
      'your_location_detected_success': 'تم اكتشاف موقعك بنجاح',
      'please_detect_location_first': 'يرجى اكتشاف الموقع أولاً',
      'location_detected_successfully': 'تم اكتشاف الموقع بنجاح',
      'location_saved_in_background': 'تم حفظ الإحداثيات في الخلفية',
      'previous_location': 'الموقع السابق',
      'saved': 'محفوظ',
      'area': 'المنطقة',
      'not_set': 'غير محدد',
      'update_location_below': 'يمكنك تحديث موقعك أدناه',
      'apartment': 'شقة',
      
      // Previous Location Screen
      'your_saved_location': 'موقعك المحفوظ',
      'no_saved_location_found': 'لم يتم العثور على موقع محفوظ',
      'add_location_to_get_started': 'أضف موقعك للبدء في استخدام الخدمات',
      'saved_location': 'الموقع المحفوظ',
      'active': 'نشط',
      'no_address_available': 'لا يوجد عنوان متاح',
      'edit_location': 'تعديل الموقع',
      'deleting': 'جاري الحذف',
      
      // Checkout Screen
      'order_summary': 'ملخص الطلب',
      'brand': 'العلامة التجارية',
      'payment_method': 'طريقة الدفع',
      'cash_on_delivery': 'الدفع عند الاستلام',
      'visa_card': 'بطاقة فيزا',
      'pay_when_delivered': 'ادفع عند التسليم',
      'secure_online_payment': 'دفع آمن عبر الإنترنت',
      'no_delivery_location_set': 'لم يتم تحديد موقع التوصيل',
      'add_location': 'إضافة موقع',
      'subtotal': 'المجموع الفرعي',
      'place_order': 'تأكيد الطلب',
      'processing': 'جاري المعالجة',
      'edit': 'تعديل',
      'another_location': 'موقع آخر',
      
      'register': 'تسجيل',
      'register_with_email': 'التسجيل باستخدام بريد الكتروني',
      'register_with_apple': 'التسجيل باستخدام Apple',
      'register_with_google': 'التسجيل باستخدام Google',
      'already_have_account_login': 'لديك حساب بالفعل؟ سجل دخولك',
      'please_enter_name': 'يرجى إدخال الاسم',
      'passwords_do_not_match': 'كلمات المرور غير متطابقة',
      'password_too_short': 'كلمة المرور قصيرة جداً (6 أحرف على الأقل)',
      'registration_success': 'تم التسجيل بنجاح',
      'registration_failed': 'فشل التسجيل',
      'email_already_in_use': 'البريد الإلكتروني مستخدم بالفعل',
      'weak_password': 'كلمة المرور ضعيفة',
      'invalid_email': 'البريد الإلكتروني غير صحيح',
      // Profile translations
      'profile': 'الملف الشخصي',
      'account_settings': 'إعدادات الحساب',
      'change_email': 'تغيير البريد الإلكتروني',
      'my_orders': 'طلباتي',
      'view_order_history': 'عرض تاريخ الطلبات',
      'change_language': 'تغيير اللغة',
      'support': 'الدعم',
      'contact_us': 'اتصل بنا',
      'get_help_support': 'احصل على المساعدة والدعم',
      'danger_zone': 'المنطقة الخطرة',
      'logout': 'تسجيل الخروج',
      'sign_out_account': 'تسجيل الخروج من الحساب',
      'delete_account': 'حذف الحساب',
      'permanently_delete_account': 'حذف الحساب نهائياً',
      'app_version': 'إصدار التطبيق',
      'welcome_back': ' استعد للحصول علي تجربة فريدة اليوم',
      'user': 'المستخدم',
      'new_email': 'البريد الإلكتروني الجديد',
      'update': 'تحديث',
      'delete_account_confirmation': 'هل أنت متأكد من حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.',
      'please_enter_valid_email': 'يرجى إدخال بريد إلكتروني صحيح',
      'email_updated_check_verification': 'تم تحديث البريد الإلكتروني. يرجى التحقق من التحقق.',
      'email_update_failed': 'فشل في تحديث البريد الإلكتروني',
      'account_deleted': 'تم حذف الحساب',
      'account_deletion_failed': 'فشل في حذف الحساب',
      'email_support': 'دعم البريد الإلكتروني',
      'phone_support': 'دعم الهاتف',
      'email_opened': 'تم فتح البريد الإلكتروني',
      'calling_support': 'يتم الاتصال بالدعم',
      'orders_feature_coming_soon': 'ميزة الطلبات قريباً',
      'logged_out_successfully': 'تم تسجيل الخروج بنجاح',
      'logout_failed': 'فشل في تسجيل الخروج',
      'language_changed': 'تم تغيير اللغة',
      // Orders translations
      'all_orders': 'جميع الطلبات',
      'pending': 'قيد الانتظار',
      'accepted': 'مقبول',
      'done': 'مكتمل',
      'cancelled': 'ملغي',
      'user_not_logged_in': 'المستخدم غير مسجل الدخول',
      'no_orders_found': 'لا توجد طلبات',
      'error_fetching_orders': 'خطأ في جلب الطلبات',
      'cannot_cancel_order': 'لا يمكن إلغاء هذا الطلب',
      'order_cancelled_successfully': 'تم إلغاء الطلب بنجاح',
      'error_cancelling_order': 'خطأ في إلغاء الطلب',
      'cancel_order_confirmation': 'هل أنت متأكد من إلغاء هذا الطلب؟',
      'no': 'لا',
      'yes_cancel': 'نعم، إلغاء',
      'items': 'عناصر',
      "cancel_order": "إلغاء الطلب",
      'currency': 'ريال',
      
      // Sale Products translations
      'hot_deals': 'عروض وخصومات ',
      'limited_time_offers': 'عروض لفترة محدودة',
      'no_sale_products': 'لا توجد منتجات مخفضة',
      'check_back_later_for_deals': 'تحقق لاحقاً للحصول على صفقات جديدة',
      'see_all_deals': 'عرض كل العروض',
      'save': 'وفر',
      'total_deals': 'إجمالي العروض',
      'total_savings': 'إجمالي التوفير',
      'avg_discount': 'متوسط الخصم',
      'sort_by': 'ترتيب حسب',
      'filter_by': 'تصفية حسب',
      'no_products_found': 'لم يتم العثور على منتجات',
      'no_products_in_category': 'لا توجد منتجات في هذه الفئة',
      'try_different_filter': 'جرب ضبط المرشحات أو تحقق لاحقاً',
      'reset_filters': 'إعادة تعيين المرشحات',
      
      'view_details': 'عرض التفاصيل',
      'hide_details': 'إخفاء التفاصيل',
      'popular': 'شائع',
      'save': 'وفر',
      'valid_for': 'صالح لمدة',
      'services_included': 'خدمات متضمنة',
      'package_details': 'تفاصيل الباقة',
      'validity': 'الصلاحية',
      'included_services': 'الخدمات المتضمنة',
      'select_package': 'اختر الباقة',
      'no_packages_available': 'لا توجد باقات متاحة',
      'check_back_later': 'تحقق لاحقاً من الباقات الجديدة',
      'start_shopping_to_see_orders': 'ابدأ التسوق لرؤية طلباتك هنا',
      'start_shopping': 'ابدأ التسوق',
      'order_items': 'عناصر الطلب',
  'checkout': 'الدفع',
  'your_location': 'موقعك',
  'order_summary': 'ملخص الطلب',
  'product': 'المنتج',
  'quantity': 'الكمية',
  'price': 'السعر',
  'no_cart_items': 'لا توجد عناصر في السلة',
      "selected":"المحدد",
      "select_services": "اختر الخدمات",
      "prev_locations": "المواقع السابقة",
  'continue': 'متابعة',
  'loading_locations': 'جاري تحميل المواقع ...',
  'no_locations_found': 'لا توجد مواقع محفوظة',
  'building_name': 'اسم المبنى',
  'notes': 'ملاحظات',
  'created_at': 'تاريخ الإضافة',
  'location_save_error': 'حدث خطأ أثناء حفظ الموقع. حاول مرة أخرى.',
  'location_access': 'الوصول إلى الموقع',
  'use_current_location': 'استخدم موقعي الحالي',
  'address_details': 'تفاصيل العنوان',
  'building_name_landmark': 'اسم المبنى / معلم قريب',
  'apartment_number': 'رقم الشقة',
  'area_district': 'المنطقة / الحي',
  'city': 'المدينة',
  'contact_notes': 'الاتصال والملاحظات',
  'additional_notes': 'ملاحظات إضافية',
       'use_this_location': 'استخدم هذا الموقع',
  'enter_another_location': 'ادخل موقع آخر',
  'enter_location_details': 'أدخل تفاصيل الموقع',
  'latitude': 'خط العرض',
  'longitude': 'خط الطول',
  'street_name': 'اسم الشارع',
  'floor': 'الطابق',
  'phone': 'رقم الهاتف',
  'required_field': 'هذا الحقل مطلوب',
  'save_location': 'حفظ الموقع',
  'location_saved': 'تم حفظ الموقع بنجاح',
  'cart': 'السلة',
  'location': 'الموقع',
  'location_services_disabled': 'خدمات الموقع غير مفعلة. يرجى تفعيلها من الإعدادات.',
  'location_permission_denied_message': 'تم رفض إذن الموقع. يرجى السماح للوصول إلى الموقع.',
  'location_permission_denied_forever': 'تم رفض إذن الموقع بشكل دائم. يرجى السماح من إعدادات النظام.',
  'location_error': 'حدث خطأ أثناء تحديد الموقع. حاول مرة أخرى.',
  // 'your_location': 'موقعك الحالي',
  'current_address': 'العنوان الحالي',
  'no_address_found': 'لم يتم العثور على عنوان',
  'location_permission_denied': 'تم رفض إذن الموقع أو غير متاح',
  'total': 'الإجمالي',
  'subtotal': 'المجموع الفرعي',
  'shipping': 'الشحن',
  "payment_method":"طريقة الدفع",
  'confirm_order': 'تأكيد الطلب',
  'services_orders': 'طلبات الخدمات',
  'products_orders': 'طلبات المنتجات',
  // 'checkout': 'الدفع',
      'no_products_found': 'لا توجد منتجات في السلة',
      'add_products_to_cart_message': 'أضف منتجات إلى السلة لتظهر هنا',
      'only_valid': 'المتبقي فقط',
      'confirm_delete': 'تأكيد الحذف',
      'are_you_sure_delete': 'هل أنت متأكد من حذف هذا العنصر؟',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'order_completed': 'تم إكمال الطلب',
      'thank_you_for_order': 'شكراً لك على طلبك',
      'order_confirmation_message': 'سيتم تسليم طلبك قريباً. ستتلقى تحديثات عبر البريد الإلكتروني.',
      'order_number': 'رقم الطلب',
      'estimated_delivery': 'التسليم المتوقع',
      'days': 'أيام',
      'continue_shopping': 'متابعة التسوق',
      'view_order_details': 'عرض تفاصيل الطلب',
      "login_success": "تم تسجيل الدخول بنجاح",
      "welcome_new_user": "مرحباً بك! تم إنشاء حسابك بنجاح",
      'please_select_location': 'يرجى اختيار موقع',
      'cart_is_empty': 'السلة فارغة',
      'order_confirmed': 'تم تأكيد الطلب',
      'order_save_failed': 'فشل في حفظ الطلب',
      'please_enter_email_and_password': 'يرجى إدخال البريد الإلكتروني وكلمة المرور',
      'login_failed': 'فشل تسجيل الدخول',
      "home": "الرئيسية",
      'your_shopping_destination': 'وجهتك التسوقية',
      'smart_shop': 'متجر ذكي',
    // Product Home View translations
  'ShopIt': 'ShopIt',
  "only valid":"المتبقي فقط",
  "added to cart":"تمت الإضافة إلى السلة",
  "Add to Cart":"أضف إلى السلة",
  'Search for items or services': 'البحث عن عناصر أو خدمات',
  'Categories': 'الفئات',
  'See all': 'عرض الكل',
  'Featured': "المشتريات المميزة",
  'All products': 'كل المنتجات',
  'Products in': 'المنتجات في',
  'No products found': 'لا توجد منتجات',
      'Electronics': 'الكترونيات',
      'Beauty': 'جمال',
      'Delivery': 'توصيل',
      'Cleaning': 'تنظيف',
      'Wireless Headphones': 'سماعات لاسلكية',
      'Organic Face Cream': 'كريم وجه عضوي',
      'Moving Service': 'خدمة نقل',
      'Cleaning Supplies': 'مستلزمات التنظيف',
      'Trending': 'رائج',
      'New': 'جديد',
      'Popular': 'شائع',
      'Recommended': 'موصى به',
      "Search":" البحث ",

      // Home Main Content translations
      'what_are_you_looking_for': 'ماذا تبحث عنه',
      'special_offers': 'العروض الخاصة',
      'no_categories_available': 'لا توجد فئات متاحة',
      'no_special_offers_available': 'لا توجد عروض خاصة متاحة',
      'view_all': 'عرض الكل',

       'location_detected_successfully': 'تم تحديد الموقع بنجاح',
      
      'location_selected_from_map': 'تم اختيار الموقع من الخريطة',
      'map_error': 'خطأ في الخريطة',
      'failed_to_load_location': 'فشل في تحميل الموقع',

      // Core translations
      'login_or_register': "خطوة بسيطة نحو تجربة استثنائية – سجّل دخولك",
      'everything_you_need': 'كل ما تحتاجه دائمًا يجيك',
      'fresh_and_fast': 'طازج وبسرعة',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'login': 'تسجيل الدخول',
      'forgot_password': 'نسيت كلمة المرور؟',
      'login_with_apple': 'تسجيل الدخول باستخدام Apple',
      'login_with_google': 'تسجيل الدخول باستخدام Google',
      'no_account_register': 'ليس لديك حساب؟ سجل الآن',
      'welcome_back': 'مرحبًا بعودتك',
      'login_to_continue': 'قم بتسجيل الدخول للمتابعة',
      'login_error': 'خطأ في تسجيل الدخول، تحقق من بياناتك',
      'invalid_email': 'بريد إلكتروني غير صالح',
      'password_required': 'كلمة المرور مطلوبة',
      'or': 'أو',
      'network_error': 'خطأ في الشبكة، يرجى التحقق من اتصالك',
      'authentication_error': 'خطأ في المصادقة: ',
      'form_not_initialized': 'النموذج غير مهيأ بشكل صحيح',
      'user_info_error': 'فشل في استرجاع معلومات المستخدم',
      'login_failed': 'فشل تسجيل الدخول: ',
      'Welcome to Your Shop': 'مرحبًا بك في متجرك',
      'Choose between our premium services or products': 'اختر بين خدماتنا المميزة أو منتجاتنا',
      'Services': 'الخدمات',
      'Explore our premium services': 'استكشف خدماتنا المميزة',
      'Products': 'المنتجات',
      'Browse our curated products': 'تصفح منتجاتنا المختارة بعناية',
      'Choose our premium services or browse products': 'اختر خدماتنا المميزة أو تصفح المنتجات',
      'View Reviews': 'عرض المراجعات',
      'product_items': 'عناصر',
      'rating_out_of': '/5.0',
      "reviews":"التقييمات",
      // Specifications Section
      'Specifications': 'المواصفات',
      'Product Specifications': 'مواصفات المنتج',
      'Technical Details': 'التفاصيل التقنية',
      'Product Information': 'معلومات المنتج',
      'Brand': 'العلامة التجارية',
      'Category': 'الفئة',
      'Stock': 'المخزون',
      'Rating': 'التقييم',
      'Availability': 'التوفر',
      'In Stock': 'متوفر',
      'Out of Stock': 'غير متوفر',
      'Product ID': 'رقم المنتج',
      'SKU': 'رمز المنتج',
      'Weight': 'الوزن',
      'Dimensions': 'الأبعاد',
      'Material': 'المادة',
      'Color': 'اللون',
      'Size': 'الحجم',
      'Warranty': 'الضمان',
      'Manufacturer': 'الشركة المصنعة',
      'Country of Origin': 'بلد المنشأ',
      'Product Description': 'وصف المنتج',
      'Key Features': 'المميزات الرئيسية',
      'Additional Information': 'معلومات إضافية',
      // Favorites translations
      'favorites': 'المفضلة',
      'Favorites': 'المفضلة',
      'No favorites yet': 'لا توجد مفضلة بعد',
      'Add products to your favorites to see them here': 'أضف منتجات إلى مفضلتك لرؤيتها هنا',
      'Refresh': 'تحديث',
      "Welcome to ShopIt":"مرحباً بك في Mountain Store",
      'Discover amazing products...': 'اكتشف منتجات رائعة...',
      'Loading amazing products...': 'جاري تحميل المنتجات الرائعة...',
      'Write a Review': 'اكتب مراجعة',
      'Rate this product': 'قيم هذا المنتج',
      'Write your review (optional)': 'اكتب مراجعتك (اختياري)',
      'Share your experience with this product...': 'شارك تجربتك مع هذا المنتج...',
      'Submit Review': 'إرسال المراجعة',
      'Review submitted successfully': 'تم إرسال المراجعة بنجاح',
      'Failed to submit review': 'فشل في إرسال المراجعة',
      'Please select a rating': 'يرجى اختيار تقييم',
      'You have already reviewed this product': 'لقد قمت بمراجعة هذا المنتج بالفعل',
      'My Reviews': 'مراجعاتي',
      'No reviews yet': 'لا توجد مراجعات بعد',
      'Your reviews will appear here': 'ستظهر مراجعاتك هنا',
      'Write Review': 'اكتب مراجعة',
      'write_review': 'اكتب مراجعة',
      'Already Reviewed': 'تمت المراجعة بالفعل',
      'Review Submitted': 'تم إرسال المراجعة',
      'customer_information': 'معلومات العميل',
      'customer_name': 'اسم العميل',
      'items_count': 'عدد العناصر',
      'item_total': 'إجمالي العنصر',
      'contact_support': 'اتصل بالدعم',
      'order_pending_description': 'طلبك قيد المراجعة وسيتم قبوله قريباً',
      'order_accepted_description': 'تم قبول طلبك وجاري تحضيره للشحن',
      'order_completed_description': 'تم تسليم طلبك بنجاح',
      'order_cancelled_description': 'تم إلغاء هذا الطلب',
      'order_status_unknown': 'حالة الطلب غير معروفة',
      'Loading your favorites...': 'جاري تحميل مفضلتك...',
      'Welcome to Favorites': 'مرحباً بك في المفضلة',
      'Preparing your favorite items...': 'جاري تحضير عناصرك المفضلة...',
      'rating_distribution': 'توزيع التقييمات',
      'no_reviews_yet': 'لا توجد مراجعات بعد',
      // Search translations
      'Search products, categories...': 'البحث في المنتجات والفئات...',
      'Filter by category': 'تصفية حسب الفئة',
      'Found': 'وُجد',
      'products': 'منتجات',
      'Clear filters': 'مسح المرشحات',
      'All': 'الكل',
      'Try adjusting your search or filters': 'جرب تعديل البحث أو المرشحات',
      // Price filter translations
      'Price range': 'نطاق السعر',
      'Price Range': 'نطاق السعر',
      'Min Price': 'أقل سعر',
      'Max Price': 'أعلى سعر',
      'Apply': 'تطبيق',
      'Reset': 'إعادة تعيين',
      'to': 'إلى',
      // Search widget translations
      'search_products_hint': 'البحث في المنتجات والفئات...',
      'filter_by_category': 'تصفية حسب الفئة',
      'price_filter_label': 'السعر',
      'price_range_title': 'نطاق السعر',
      'min_price_label': 'أقل سعر',
      'max_price_label': 'أعلى سعر',
      'price_range_to': 'إلى',
      'price_filter_reset': 'إعادة تعيين',
      'price_filter_apply': 'تطبيق',
      'search_results_found': 'وُجد',
      'search_results_products': 'منتجات',
      'search_clear_filters': 'مسح المرشحات',
      'search_no_products_found': 'لا توجد منتجات',
      'search_adjust_filters_hint': 'جرب تعديل البحث أو المرشحات',
      'filter_price_range_description': 'اختر نطاق السعر المناسب لك',
      'price_slider_label': 'نطاق السعر',
      'range_total': 'المدى: {range}',
      'price_filter_description': 'حدد الحد الأدنى والأعلى للسعر',
      // Search loading translations
      'search_loading_products': 'جاري تحميل المنتجات...',
      'search_loading_description': 'يرجى الانتظار بينما نحمل أحدث المنتجات',
      'search_searching': 'جاري البحث...',
      'search_searching_description': 'نبحث عن المنتجات المناسبة لك',
      'search_filter_loading': 'جاري تطبيق الفلاتر...',
      'search_initializing': 'جاري إعداد البحث...',
      // Product Ads View translations
      'ad_details': 'تفاصيل الإعلان',
      'about_this_ad': 'حول هذا الإعلان',
      'show_product': 'عرض المنتج',
      'ad_category': 'فئة الإعلان',
      'ad_description': 'وصف الإعلان',
      'review_items_checkout': 'راجع عناصرك ومتابعة الدفع',
      'secure_fast_delivery': 'آمن • توصيل سريع',
      'explore_now_ar': 'استكشف الآن',
      'learn_more': 'تعرف أكثر',
      'limited_time_offer': 'عرض لوقت محدود',
      'special_promotion': 'عرض ترويجي خاص',
      'view_details_ar': 'عرض التفاصيل',
      'no_description_available': 'لا يتوفر وصف',
      'back_to_home': 'العودة للرئيسية',
      'share_ad': 'مشاركة الإعلان',
      // Product Details translations
      'add_to_cart': 'أضف إلى السلة',
      'product_added_to_cart': 'تمت إضافة المنتج إلى السلة بنجاح!',
      'no_desc_available': 'لا يتوفر وصف',
      'product_category': 'الفئة',
      'product_brand': 'العلامة التجارية',
      'product_rating': 'التقييم',
      'quantity_available': 'الكمية المتوفرة',
      'product_description': 'الوصف',
      // Favorites loading translations
      'loading_favorites': 'جاري تحميل المفضلة...',
      'no_favorite_products': 'لا توجد منتجات مفضلة',
      'add_products_to_favorites': 'أضف منتجات إلى المفضلة لرؤيتها هنا',
      'add_new_location': 'أضف موقع جديد',
      'delete_selected': 'حذف المحدد',
      'clear_selection': 'مسح التحديد',
      'add_location_to_continue': 'أضف موقعاً للمتابعة',
      // Service By Category translations
      'services_available': 'خدمة متاحة',
      'search_services_in_category': 'البحث عن الخدمات في هذه الفئة',
      'filter_and_sort': 'التصفية والترتيب',
      'budget_friendly': 'اقتصادي',
      'moderate': 'متوسط',
      'premium': 'مميز',
      'all_prices': 'كل الأسعار',
      'any_price': 'أي سعر',
      'minimum_rating': 'أقل تقييم',
      'category_statistics': 'إحصائيات الفئة',
      'total_services': 'إجمالي الخدمات',
      'average_price': 'متوسط السعر',
      'average_rating': 'متوسط التقييم',
      'no_services_matching_search': 'لا توجد خدمات تطابق البحث',
      'no_services_in_category': 'لا توجد خدمات في هذه الفئة',
      'error_occurred': 'حدث خطأ',
      'try_again': 'حاول مرة أخرى',
      'Default': 'افتراضي',
      'Price: Low to High': 'السعر: من الأقل للأعلى',
      'Price: High to Low': 'السعر: من الأعلى للأقل',
      'Rating: High to Low': 'التقييم: من الأعلى للأقل',
      'Rating: Low to High': 'التقييم: من الأقل للأعلى',
      'Name: A to Z': 'الاسم: أ إلى ي',
      'Name: Z to A': 'الاسم: ي إلى أ',
      // Favorites translations
      'error': 'خطأ',
      'please_login_first': 'يرجى تسجيل الدخول أولاً',
      'added_to_favorites': 'تمت الإضافة إلى المفضلة',
      'removed_from_favorites': 'تمت الإزالة من المفضلة',
      'error_updating_favorites': 'خطأ في تحديث المفضلة',
      'confirm': 'تأكيد',
      'clear_all_favorites': 'مسح جميع المفضلة',
      'all_favorites_cleared': 'تم مسح جميع المفضلة',
      'error_fetching_favorites': 'خطأ في جلب المفضلة',
      'search_favorites': 'البحث في المفضلة...',
      'favorite_services': 'خدمة مفضلة',
      'showing': 'يظهر',
      'of': 'من',
      'login_to_view_favorites': 'سجل دخولك لعرض الخدمات المفضلة لديك',
      'no_favorite_services': 'لا توجد خدمات مفضلة',
      'add_services_to_favorites': 'أضف خدمات إلى مفضلتك لرؤيتها هنا',
      'explore_services': 'استكشف الخدمات',
      'no_search_results': 'لا توجد نتائج بحث',
      'try_different_search': 'جرب مصطلح بحث مختلف',
      'clear_search': 'مسح البحث',
      'clear_all_favorites_confirmation': 'هل أنت متأكد من مسح جميع مفضلتك؟ لا يمكن التراجع عن هذا الإجراء.',
      'clear_all': 'مسح الكل',
      // Shared state widget translations
      'login_to_view_content': 'سجل دخولك لعرض المحتوى',
      'no_internet_connection': 'لا يوجد اتصال بالإنترنت',
      'check_internet_and_try_again': 'تحقق من اتصال الإنترنت وحاول مرة أخرى',
      'retry': 'إعادة المحاولة',
      'no_results_found': 'لا توجد نتائج',
      'no_results_for_query': 'لا توجد نتائج لـ "{query}"',
      'try_different_search_terms': 'جرب مصطلحات بحث مختلفة',
      'feature_coming_soon_description': 'هذه الميزة قيد التطوير وستكون متاحة قريباً',
      'under_maintenance': 'تحت الصيانة',
      'maintenance_description': 'نحن نعمل على تحسين التطبيق. سيكون متاحاً قريباً',
      'permission_required': 'إذن مطلوب',
      'permission_required_description': 'نحتاج إلى إذنك للوصول إلى هذه الميزة',
      'grant_permission': 'منح الإذن',
      'explore_products': 'استكشف المنتجات',
      'explore_categories': 'استكشف الفئات',
      "review_submitted":"تم التقييم",
      'loading_services': 'جاري تحميل الخدمات...',
      'services_found': 'خدمة موجودة',
      'search_statistics': 'إحصائيات البحث',
      'apply_filters': 'تطبيق المرشحات',
      'clear_filters': 'مسح المرشحات',
      'stars': 'نجوم',
      'search_services_providers': 'البحث في الخدمات ومقدمي الخدمات...',
      
      // Booking Requirements Dialog
      'booking_incomplete': 'الحجز غير مكتمل',
      'complete_required_fields_to_continue': 'أكمل الحقول المطلوبة للمتابعة',
      'missing_requirements': 'المتطلبات المفقودة',
      
      // Validation translations
      'validation_error': 'خطأ في التحقق',
      'unknown_validation_error': 'خطأ غير معروف في التحقق',
      'field_field': 'الحقل: {field}',
      'missing_fields': 'الحقول المفقودة',
      'validation_errors_found': 'تم العثور على أخطاء في التحقق',
      'form_validation_errors': 'أخطاء التحقق في النموذج',
      'validation_passed': 'تم التحقق بنجاح',
      'validate_and_submit': 'التحقق والإرسال',
      'form_validation_passed': 'تم التحقق من النموذج بنجاح',
      'form_submitted_successfully': 'تم إرسال النموذج بنجاح',
      'form_validation_failed': 'فشل التحقق من النموذج',
      'validated_location_form_example': 'مثال على نموذج الموقع مع التحقق',
      'location_information': 'معلومات الموقع',
      'enter_phone_number': 'أدخل رقم الهاتف',
      'enter_floor_optional': 'أدخل الطابق (اختياري)',
      'enter_landmark_optional': 'أدخل معلم قريب (اختياري)',
      
      // Additional validation messages
      'user_profile_incomplete': 'ملف المستخدم غير مكتمل',
      'invalid_service_id': 'معرف الخدمة غير صحيح',
      'service_name_required': 'اسم الخدمة مطلوب',
      'invalid_service_price': 'سعر الخدمة غير صحيح',
      'cannot_select_past_date': 'لا يمكن اختيار تاريخ في الماضي',
      'date_too_far_future': 'التاريخ بعيد جداً في المستقبل',
      'required_location_fields_missing': 'حقول الموقع المطلوبة مفقودة',
      'invalid_email_format': 'تنسيق البريد الإلكتروني غير صحيح',
      'name_too_short': 'الاسم قصير جداً',
      'invalid_city_selection': 'اختيار المدينة غير صحيح',
      'address_too_short': 'العنوان قصير جداً',
      'notes_too_long': 'الملاحظات طويلة جداً (الحد الأقصى {max})',
      'location_coordinates_required': 'إحداثيات الموقع مطلوبة',
      'invalid_latitude': 'خط العرض غير صحيح',
      'invalid_longitude': 'خط الطول غير صحيح',
      'field_required': 'الحقل {field} مطلوب',
      'field_min_length': 'الحقل {field} يجب أن يحتوي على {min} أحرف على الأقل',
      'field_max_length': 'الحقل {field} يجب أن لا يزيد عن {max} حرف',
      'order_validation_failed': 'فشل التحقق من الطلب',
      'validation_failed': 'فشل التحقق',
      
      // Order system translations
      'user_information': 'معلومات المستخدم',
      'delivery_location': 'موقع التوصيل',
      'price_summary': 'ملخص السعر',
      'service_price': 'سعر الخدمة',
      'unknown_service': 'خدمة غير معروفة',
      'unknown_location': 'موقع غير معروف',
      'no_email': 'لا يوجد بريد إلكتروني',
      'no_name': 'لا يوجد اسم',
      'placing_order': 'جاري تأكيد الطلب...',
      'order_placement_failed': 'فشل تأكيد الطلب',
      'invalid_price': 'سعر غير صحيح',
      
      // Service Orders translations
      'my_orders': 'طلباتي',
      'no_orders_found': 'لم يتم العثور على طلبات',
      'failed_to_load_orders': 'فشل في تحميل الطلبات',
      'loading_orders': 'جاري تحميل الطلبات...',
      'no_orders_yet': 'لا توجد طلبات بعد',
      'no_orders_with_status': 'لا توجد طلبات بحالة {status}',
      'start_ordering_services': 'ابدأ بطلب الخدمات',
      'try_different_filter': 'جرب فلتر مختلف',
      'show_all_orders': 'عرض كل الطلبات',
      'all_orders': 'كل الطلبات',
      'order_status_pending': 'قيد الانتظار',
      'order_status_accepted': 'مقبول',
      'order_status_done': 'مكتمل',
      'order_status_canceled': 'ملغي',
      'rate_service': 'تقييم الخدمة',
      'rate_order': 'تقييم الطلب',
      'order_already_rated': 'تم تقييم الطلب بالفعل',
      'cannot_rate_pending_order': 'لا يمكن تقييم الطلب قبل اكتماله',
      'rating_submitted_successfully': 'تم إرسال التقييم بنجاح',
      'failed_to_submit_rating': 'فشل في إرسال التقييم',
      'your_rating': 'تقييمك',
      'add_comment': 'إضافة تعليق (اختياري)',
      'submit_rating': 'إرسال التقييم',
      'rating_comment_placeholder': 'اكتب تعليقك هنا...',
      'rate': 'تقييم',
      'rate_now': 'قيّم الآن',
      'share_your_experience': 'شارك تجربتك مع الخدمة',
      'thank_you_for_feedback': 'شكراً لتقييمك',
      'submitting': 'جاري الإرسال...',
      'welcome_to_smart_shop': 'مرحباً بك في Mountain Store',
      'discover_services_and_products': 'اكتشف خدماتنا المميزة ومنتجاتنا المتنوعة',
      'recommendation': 'توصية',
      'premium_services': 'خدمات مميزة',
      'professional_home_services': 'خدمات منزلية احترافية',
      'quality_products': 'مشتريات عالية الجودة',
      'curated_shopping_experience': 'تجربة تسوق مميزة',
      'your_activity': 'نشاطك',
      'explore_now': 'استكشف الآن',
      'services_used': 'الخدمات المستخدمة',
      'products_bought': 'المنتجات المشتراة',
      'good_morning': 'صباح الخير',
      'good_afternoon': 'مساء الخير',
      'good_evening': 'مساء الخير',
      'discover_today_deals': 'اكتشف عروض اليوم',
      'total_products': 'إجمالي المنتجات',
      'new_arrivals': 'وصل حديثاً',
      'services_lover_text': 'يبدو أنك تحب خدماتنا! 🌟',
      'shopping_enthusiast_text': 'تسوق احترافي الان من مابين افضل الخدمات و ارقي المنتجات  🛍️',
      'welcome_back_text': 'مرحباً بك مرة أخرى! تابع من حيث توقفت 👋',
      'new_user_text': 'مستخدم جديد؟ اختر ما يهمك أكثر! ✨',
      'today': 'اليوم',
      'yesterday': 'أمس',
      'days_ago': 'أيام مضت',
      'order': 'طلب',
      'order_details': 'تفاصيل الطلب',
      'order_information': 'معلومات الطلب',
      'order_id': 'رقم الطلب',
      'order_date': 'تاريخ الطلب',
      'order_status': 'حالة الطلب',
      'service_information': 'معلومات الخدمة',
      'service_name': 'اسم الخدمة',
      'delivery_information': 'معلومات التوصيل',
      'city': 'المدينة',
      'landmark': 'معلم مميز',
      'phone': 'الهاتف',
      'orders_overview': 'نظرة عامة على الطلبات',
      'total_orders': 'إجمالي الطلبات',
      'pending': 'قيد الانتظار',
      'accepted': 'مقبول',
      'completed': 'مكتمل',
      'showing': 'عرض',
      'filter_by_status': 'تصفية حسب الحالة',
      
      // Mode switching translations
      'current_mode': 'الوضع الحالي',
      'services_mode': 'وضع الخدمات',
      'products_mode': 'وضع المنتجات',
      'switch_to': 'التبديل إلى',
      'switched_to_services_mode': 'تم التبديل إلى وضع الخدمات',
      'switched_to_products_mode': 'تم التبديل إلى وضع المنتجات',
      
      // Navigation loading dialog translations
      'location_success': 'تم حفظ موقعك بنجاح!',
      'redirecting_to_app': 'جاري التوجه إلى التطبيق...',
      'welcome_location_set': 'مرحباً! تم تحديد موقعك',
      'welcome_to_app': 'مرحباً بك في التطبيق...',
      'welcome': 'مرحباً',
      'your_smart_shopping_destination': 'وجهتك الذكية للتسوق',
      'starting_app': 'بدء التطبيق...',
      'loading_resources': 'تحميل الموارد...',
      'almost_ready': 'تقريباً جاهز...',
      'error_occurred': 'حدث خطأ',
      'location_detection_failed': 'فشل في تحديد الموقع',
      'location_detection_failed_desc': 'لم نتمكن من تحديد موقعك تلقائياً. يمكنك المحاولة مرة أخرى أو تخطي هذه الخطوة.',
      'skip': 'تخطي',
      'continue_with_location': 'متابعة مع الموقع',
      'add_details': 'إضافة تفاصيل',
      'other_location': 'موقع آخر',
      'phone_number_required': 'رقم الهاتف مطلوب',
      'enter_phone_for_delivery': 'أدخل رقم الهاتف للتوصيل',
      'refresh_orders': 'تحديث الطلبات',
      'orders_refreshed': 'تم تحديث الطلبات بنجاح',
      'error_refreshing_orders': 'خطأ في تحديث الطلبات',
      
      // Start view marketing strings
      'discover_convenience': '🚀 اكتشف عالمًا جديدًا من الراحة',
      'professional_services_description': 'خدمات منزلية احترافية ومنتجات عالية الجودة في مكان واحد',
      'feature_fast': '⚡ سريع',
      'feature_secure': '🔒 آمن',
      'feature_premium': '💎 مميز',
      'choose_start_journey': '👆 اختر ما يناسبك وابدأ رحلتك معنا',
      
      // Sale Items View translations (only new ones)
      'sale_items': 'عناصر التخفيضات',
      'highest_discount': 'أعلى خصم',
      'lowest_price': 'أقل سعر',
      'highest_price': 'أعلى سعر',
      'name_a_z': 'الاسم أ-ي',
      'name_z_a': 'الاسم ي-أ',
      'newest_first': 'الأحدث أولاً',
      'all_discounts': 'جميع الخصومات',
      '10_20_off': 'خصم 10-20%',
      '20_30_off': 'خصم 20-30%',
      '30_50_off': 'خصم 30-50%',
      '50_plus_off': 'خصم 50%+',
      
      // Selected Category translations
      'selected_category': 'الفئة المحددة',
      'browsing_category': 'تتصفح فئة',
      'products_in_category': 'المنتجات في فئة',
      'change_category': 'تغيير الفئة',
      
      // Favorites marketing strings
      'favorites_marketing_title': '💝 مفضلتك الشخصية',
      'favorites_marketing_subtitle': 'اكتشف منتجاتك المحفوظة بسهولة',
      'favorites_marketing_description': 'جميع منتجاتك المفضلة في مكان واحد، جاهزة للشراء في أي وقت',
      'quick_access': 'وصول سريع',
      'saved_items': 'عناصر محفوظة',
      'instant_buy': 'شراء فوري',
      
      // Product Ads View new strings
      'featured': 'مميز',
      'verified': 'موثق',
      'product_information': 'معلومات المنتج',
      'premium_ad': 'إعلان مميز',
      'verified_seller': 'بائع موثق',
      'best_deal': 'أفضل صفقة',
      'hurry_up': 'أسرع!',
      'views': 'المشاهدات',
      'liked': 'معجب',
      'image_not_available': 'الصورة غير متاحة',
      'loading': 'جاري التحميل...',
      
      // Cart View new strings
      'best_price_guaranteed': 'أفضل سعر مضمون',
      'proceed_to_checkout': 'المتابعة للدفع',
      'remove_item': 'إزالة العنصر',
      'item_removed': 'تم حذف العنصر',
      'cart_updated': 'تم تحديث السلة',
      'empty_cart': 'السلة فارغة',
      'add_items_to_cart': 'أضف عناصر إلى السلة',
      'order_total': 'إجمالي الطلب',
      'discount_applied': 'تم تطبيق الخصم',
      'free_shipping': 'شحن مجاني',
      'shipping_cost': 'تكلفة الشحن',
      'tax_included': 'الضريبة متضمنة',
      'save_for_later': 'احفظ لوقت لاحق',
      'move_to_favorites': 'انقل إلى المفضلة',
      'recently_viewed': 'تم عرضها مؤخراً',
      'recommended_for_you': 'موصى لك',
      'similar_products': 'منتجات مشابهة',
      'customers_also_bought': 'اشترى العملاء أيضاً',
      'back_to_shopping': 'العودة للتسوق',
      'continue_to_payment': 'المتابعة للدفع',
      'apply_coupon': 'تطبيق الكوبون',
      'coupon_code': 'كود الكوبون',
      'invalid_coupon': 'كوبون غير صالح',
      'coupon_applied': 'تم تطبيق الكوبون',
      'minimum_order': 'الحد الأدنى للطلب',
      'estimated_total': 'الإجمالي المتوقع',

      // Search translations
      'search': 'بحث',
      'search_brands': 'ابحث عن العلامات التجارية',
      'start_searching': 'ابدأ البحث',
      'search_description': 'ابحث عن علاماتك التجارية المفضلة حسب الاسم أو الفئة',
      'search_tips': 'نصائح البحث',
      'search_tip_1': 'ابحث باسم العلامة التجارية بالعربية أو الإنجليزية',
      'search_tip_2': 'جرب البحث بنوع الفئة للحصول على نتائج أوسع',
      'search_tip_3': 'استخدم كلمات مفتاحية بسيطة للحصول على نتائج أفضل',
      'no_results_found': 'لا توجد نتائج',
      'no_results_for': 'لا توجد نتائج لـ',
      'try_different_keywords': 'جرب كلمات مفتاحية مختلفة أو أكثر عمومية',
      'result_found': 'نتيجة',
      'results_found': 'نتيجة',
      'loading_brands': 'جاري تحميل العلامات التجارية',
      'failed_to_load_brands': 'فشل في تحميل العلامات التجارية',

    },
    'en': {
      "another_location":"Use another location",
      "dont_have_account":"Don't have an account?",
      "Yamaa":"Yamaa",

      "Email":"Email",
      "Password":"Password",

      "login_successful":"Login Successful",

      // Profile translations
      'account_settings': 'Account Settings',
      'support': 'Support',
      'language': 'Language',
      'select_language': 'Select Language',
      'change_email': 'Change Email',
      'new_email': 'New Email',
      'enter_new_email': 'Enter new email',
      'contact_us': 'Contact Us',
      'get_help_support': 'Get help and support',
      'about_app': 'About App',
      'version': 'Version',
      'about_app_description': 'Yamaa app is a comprehensive smart shopping platform that provides you with an easy and secure shopping experience with fast delivery services and 24/7 support.',
      'your_shopping_companion': 'Your Smart Shopping Companion',
      'secure': 'Secure',
      'yamaa': 'Yamaa',
      'close': 'Close',
      'cancel': 'Cancel',
      'update': 'Update',
      'success': 'Success',
      'error': 'Error',
      'language_changed_successfully': 'Language changed successfully',
      'failed_to_change_language': 'Failed to change language',
      'invalid_email': 'Invalid email address',
      'email_updated_successfully': 'Email updated successfully',
      'failed_to_update_email': 'Failed to update email',
      'name_required': 'Name is required',
      'name_updated_successfully': 'Name updated successfully',
      'failed_to_update_name': 'Failed to update name',
      'cannot_open_email': 'Cannot open email client',
      'failed_to_contact': 'Failed to contact',
      'user': 'User',

      // Orders translations
      'my_orders': 'My Orders',
      'loading_orders': 'Loading orders',
      'failed_to_load_orders': 'Failed to load orders',
      'all_orders': 'All Orders',
      'order_pending': 'Pending',
      'order_accepted': 'Accepted',
      'order_completed': 'Completed',
      'order_canceled': 'Canceled',
      'no_orders_found': 'No Orders Found',
      'no_orders_description': 'You haven\'t placed any orders yet',
      'no_orders_for_status': 'No orders with this status',
      'order': 'Order',
      'items': 'items',
      'view_details': 'View Details',
      'cancel_order_title': 'Cancel Order?',
      'cancel_order_message': 'Are you sure you want to cancel this order?',
      'no': 'No',
      'yes_cancel': 'Yes, Cancel',
      'order_status_updated': 'Order status updated',
      'failed_to_update_order': 'Failed to update order',
      'order_details': 'Order Details',
      'order_information': 'Order Information',
      'date': 'Date',
      'time': 'Time',
      'order_type': 'Order Type',
      'payment_status': 'Payment Status',
      'delivery_location': 'Delivery Location',
      'pending': 'Pending',
      'accepted': 'Accepted',
      'completed': 'Completed',
      'canceled': 'Canceled',

      "select_service_category":"Select Service Category",
      "select_product_category":"Select Product Category",
      
      // Location Detection translations
      'detect_location': 'Detect Location',
      'location_detection': 'Location Detection',
      'location_detection_desc': 'We\'ll help you detect your current location to provide better services and personalized experience.',
      'permission_required': 'Permission Required',
      'location_permission_desc': 'Location permission is required to detect your current location.',
      'grant_permission': 'Grant Permission',
      'open_app_settings': 'Open App Settings',
      'locating_device': 'Locating Device',
      'resolving_address': 'Resolving Address',
      'validating_data': 'Validating Data',
      'updating_profile': 'Updating Profile',
      'starting_detection': 'Starting Detection',
      'getting_gps_coordinates': 'Getting GPS coordinates...',
      'converting_to_address': 'Converting to address...',
      'validating_location_data': 'Validating location data...',
      'saving_to_profile': 'Saving to your profile...',
      'preparing': 'Preparing...',
      'please_wait_detecting': 'Please wait while we detect your location...',
      'same_location_detected': 'Same Location Detected!',
      'same_location_desc': 'You\'re still in the same location. No update needed.',
      'unchanged': 'Unchanged',
      'force_update': 'Force Update',
      'continue': 'Continue',
      'location_available': 'Location Available',
      'last_saved_location': 'Last saved location',

      'check_current_location': 'Check Current Location',
      'clear_saved_location': 'Clear Saved Location',
      'location_updated': 'Location Updated!',
      'location_detected': 'Location Detected!',
      'location_updated_desc': 'Your location has been updated and saved to your profile.',
      'location_detected_desc': 'Your location has been successfully detected and saved to your profile.',
      'moved_distance': 'moved',
      'meters': 'm',
      'location_details': 'Location Details',
      'updated': 'Updated',
      'new': 'New',
      'country': 'Country',
      'city': 'City',
      'location': 'Location',
      'full_address': 'Full Address',
      'coordinates': 'Coordinates',
      'detect_again': 'Detect Again',
      'ready_to_detect_location': 'Ready to Detect Location',
      'detect_location_desc': 'Tap the button below to automatically detect your current location. We\'ll identify your country, city, and save it to your profile for a better experience.',
      'detect_my_location': 'Detect My Location',
      'unknown': 'Unknown',
      'current_location': 'Current Location',
      
      // Navigation loading dialog translations
      'location_success': 'Location Saved Successfully!',
      'redirecting_to_app': 'Redirecting to app...',
      'welcome_location_set': 'Welcome! Location Set',
      'welcome_to_app': 'Welcome to the app...',
      'location_detection_failed': 'Location Detection Failed',
      'location_detection_failed_desc': 'We couldn\'t detect your location automatically. You can try again or skip this step.',
      'skip': 'Skip',
      
      "Welcome to ShopIt":"Welcome to Mountain Store",
      'welcome': 'Welcome',
      'your_smart_shopping_destination': 'Your Smart Shopping Destination',
      'starting_app': 'Starting App...',
      'loading_resources': 'Loading Resources...',
      'almost_ready': 'Almost Ready...',
      'error_occurred': 'Error Occurred',
      // Registration translations
      'join_our_community': 'Join Our Community',
      'create_account_start_shopping': 'Create an account and start shopping',
      'full_name': 'Full Name',
      'phone_number': 'Phone Number',
      'select_country': 'Select Country',
      'select_city': 'Select City',
      'please_enter_phone': 'Please enter phone number',
      'please_select_country': 'Please select country',
      'please_select_city': 'Please select city',
      'enter_area': 'Enter Area',
      'enter_floor': 'Enter Floor',
      'enter_apartment': 'Enter Apartment Number',
      'enter_notes': 'Enter Notes',
      'enter_phone': 'Enter Phone Number',
      'open_map_get_location': 'Open Map & Get Location',
      'getting_location': 'Getting Location...',
      'area_is_required': 'Area is required',
      'phone_is_required': 'Phone is required',
      
      // City names in English
      'city_manama': 'Manama',
      'city_riffa': 'Riffa',
      'city_muharraq': 'Muharraq',
      'city_hamad_town': 'Hamad Town',
      'city_aali': 'A\'ali',
      'city_isa_town': 'Isa Town',
      'city_sitra': 'Sitra',
      'city_budaiya': 'Budaiya',
      'city_jidhafs': 'Jidhafs',
      'city_al_malikiyah': 'Al-Malikiyah',
      'city_sanabis': 'Sanabis',
      'city_tubli': 'Tubli',
      'city_dar_kulaib': 'Dar Kulaib',
      'city_hidd': 'Hidd',
      'city_al_markh': 'Al-Markh',
      'city_sanad': 'Sanad',
      
      // New location messages
      'your_location_detected_success': 'Your location detected successfully',
      'please_detect_location_first': 'Please detect location first',
      'location_detected_successfully': 'Location Detected Successfully',
      'location_saved_in_background': 'Coordinates saved in background',
      'previous_location': 'Previous Location',
      'saved': 'Saved',
      'area': 'Area',
      'not_set': 'Not Set',
      'update_location_below': 'You can update your location below',
      'apartment': 'Apartment',
      
      // Previous Location Screen
      'your_saved_location': 'Your Saved Location',
      'no_saved_location_found': 'No Saved Location Found',
      'add_location_to_get_started': 'Add your location to get started with services',
      'saved_location': 'Saved Location',
      'active': 'Active',
      'no_address_available': 'No address available',
      'edit_location': 'Edit Location',
      'deleting': 'Deleting',
      
      // Checkout Screen
      'order_summary': 'Order Summary',
      'brand': 'Brand',
      'payment_method': 'Payment Method',
      'cash_on_delivery': 'Cash on Delivery',
      'visa_card': 'Visa Card',
      'pay_when_delivered': 'Pay when delivered',
      'secure_online_payment': 'Secure online payment',
      'no_delivery_location_set': 'No delivery location set',
      'add_location': 'Add Location',
      'subtotal': 'Subtotal',
      'place_order': 'Place Order',
      'processing': 'Processing',
      'edit': 'Edit',
      'another_location': 'Another Location',
      
      'register': 'Register',
      'confirm_password': 'Confirm Password',
      'register_with_apple': 'Register with Apple',
      'register_with_google': 'Register with Google',
      'already_have_account_login': 'Already have an account? Login',
      'please_enter_name': 'Please enter your name',
      'passwords_do_not_match': 'Passwords do not match',
      'password_too_short': 'Password is too short (minimum 6 characters)',
      'registration_success': 'Registration successful',
      'registration_failed': 'Registration failed',
      'email_already_in_use': 'Email is already in use',
      'weak_password': 'Password is too weak',
      'invalid_email': 'Invalid email address',
      // Profile translations
      'profile': 'Profile',
      'account_settings': 'Account Settings',
      'change_email': 'Change Email',
      'my_orders': 'My Orders',
      'view_order_history': 'View order history',
      'change_language': 'Change Language',
      'support': 'Support',
      'contact_us': 'Contact Us',
      'get_help_support': 'Get help and support',
      'danger_zone': 'Danger Zone',
      'logout': 'Logout',
      'sign_out_account': 'Sign out of your account',
      'delete_account': 'Delete Account',
      'permanently_delete_account': 'Permanently delete your account',
      'app_version': 'App Version',
      'welcome_back': 'Welcome back',
      'user': 'User',
      'new_email': 'New Email',
      'update': 'Update',
      'close': 'Close',
      'delete_account_confirmation': 'Are you sure you want to delete your account? This action cannot be undone.',
      'please_enter_valid_email': 'Please enter a valid email',
      'email_updated_check_verification': 'Email updated. Please check verification.',
      'email_update_failed': 'Email update failed',
      'account_deleted': 'Account deleted',
      'account_deletion_failed': 'Account deletion failed',
      'email_support': 'Email Support',
      'phone_support': 'Phone Support',
      'email_opened': 'Email opened',
      'calling_support': 'Calling support',
      'orders_feature_coming_soon': 'Orders feature coming soon',
      'logged_out_successfully': 'Logged out successfully',
      'logout_failed': 'Logout failed',
      'language_changed': 'Language changed',
      // Orders translations
      'all_orders': 'All Orders',
      'pending': 'Pending',
      'accepted': 'Accepted',
      'done': 'Done',
      'cancelled': 'Cancelled',
      'user_not_logged_in': 'User not logged in',
      'no_orders_found': 'No orders found',
      'error_fetching_orders': 'Error fetching orders',
      'cannot_cancel_order': 'Cannot cancel this order',
      'order_cancelled_successfully': 'Order cancelled successfully',
      'error_cancelling_order': 'Error cancelling order',
      'cancel_order_confirmation': 'Are you sure you want to cancel this order?',
      'no': 'No',
      'yes_cancel': 'Yes, Cancel',
      'items': 'items',
      "ad_desc": "description",
      'currency': 'USD',
      
      // Sale Products translations
      'hot_deals': 'Hot Deals',
      'limited_time_offers': 'Limited Time Offers',
      'no_sale_products': 'No Sale Products',
      'check_back_later_for_deals': 'Check back later for new deals',
      'see_all_deals': 'See All Deals',
      'save': 'Save',
      'total_deals': 'Total Deals',
      'total_savings': 'Total Savings',
      'avg_discount': 'Avg Discount',
      'sort_by': 'Sort By',
      'filter_by': 'Filter By',
      'no_products_found': 'No Products Found',
      'no_products_in_category': 'No products found in this category',
      'try_different_filter': 'Try adjusting your filters or check back later',
      'reset_filters': 'Reset Filters',
      
      'view_details': 'View Details',
      'start_shopping_to_see_orders': 'Start shopping to see your orders here',
      'start_shopping': 'Start Shopping',
      // Core translations
      'login_or_register': 'Login or Register',
  'checkout': 'Checkout',
  // 'your_location': 'Your Location',
  'order_summary': 'Order Summary',
  'product': 'Product',
  'quantity': 'Quantity',
  'price': 'Price',
  'no_cart_items': 'No items in cart',
      "selected":"selected",
      "select_services": "Select Services",
      "prev_locations": "Previous Locations",
      "home":"Home",
  'continue': 'Continue',
  'loading_locations': 'Loading locations ...',
  'no_locations_found': 'No saved locations',
  'building_name': 'Building Name',
  'services_orders': 'Services Orders',
  'products_orders': 'Products Orders',
  "cancel_order": "Cancel Order",
  'notes': 'Notes',
  'created_at': 'Created At',
  'location_save_error': 'An error occurred while saving location. Please try again.',
  'location_access': 'Location Access',
  'use_current_location': 'Use Current Location',
  'address_details': 'Address Details',
  'building_name_landmark': 'Building Name / Landmark',
  'apartment_number': 'Apartment Number',
  'area_district': 'Area / District',
  'city': 'City',
  'contact_notes': 'Contact & Notes',
  'additional_notes': 'Additional Notes',
  'cart': 'Cart',
  'use_this_location': 'Use this location',
  'enter_another_location': 'Enter another location',
  'enter_location_details': 'Enter location details',
  'latitude': 'Latitude',
  'longitude': 'Longitude',
  'street_name': 'Street Name',
  'floor': 'Floor',
  'phone': 'Phone',
  'required_field': 'This field is required',
  'save_location': 'Save Location',
  'location_saved': 'Location saved successfully',
  'location': 'Location',
  'location_services_disabled': 'Location services are disabled. Please enable them in settings.',
  'location_permission_denied_message': 'Location permission denied. Please allow access to location.',
  'location_permission_denied_forever': 'Location permission permanently denied. Please allow from system settings.',
  'location_error': 'An error occurred while fetching location. Please try again.',
  'your_location': 'Your Location',
  'current_address': 'Current Address',
  'no_address_found': 'No address found',
  'location_permission_denied': 'Location permission denied or unavailable',
  'total': 'Total',
  'subtotal': 'Subtotal',
  'shipping': 'Shipping',
  'confirm_order': 'Confirm Order',
  // 'checkout': 'Checkout',
  
  // Service benefits
  'service_benefits': 'Service Benefits',
  'within_30km': 'Within 30km Range',
  'fast_service': 'Fast Service',
  'secure_service': 'Secure Service',
  'certified_providers': 'Certified Providers',
  
  // Service Checkout translations
  'service_checkout': 'Service Checkout',
  'select_payment_method': 'Select Payment Method',
  'cash_on_delivery': 'Cash on Delivery',
  'credit_card': 'Credit Card',
  'debit_card': 'Debit Card',
  'paypal': 'PayPal',
  'apple_pay': 'Apple Pay',
  'google_pay': 'Google Pay',
  'pay_cash_on_delivery_desc': 'Pay with cash when service is delivered',
  'pay_with_credit_card_desc': 'Pay securely with your credit card',
  'pay_with_debit_card_desc': 'Pay directly from your bank account',
  'pay_with_paypal_desc': 'Pay with your PayPal account',
  'pay_with_apple_pay_desc': 'Pay quickly with Apple Pay',
  'pay_with_google_pay_desc': 'Pay quickly with Google Pay',
  'service_details': 'Service Details',
  'location_details': 'Location Details',
  'customer_details': 'Customer Details',
  'pricing_breakdown': 'Pricing Breakdown',
  'service_fee': 'Service Fee',
  'tax_fee': 'Tax (14%)',
  'delivery_fee': 'Delivery Fee',
  'total_amount': 'Total Amount',
  'scheduled_date': 'Scheduled Date',
  'scheduled_time': 'Scheduled Time',
  'not_selected': 'Not Selected',
  'place_order': 'Place Order',
  'processing_order': 'Processing Order...',
  'order_placed_successfully': 'Order placed successfully!',
  'failed_to_place_order': 'Failed to place order. Please try again.',
  'secure_checkout': 'Secure Checkout',
  'confirmation': 'Confirmation',
  'fast_delivery': 'Fast Delivery',
  '24_7_support': '24/7 Support',
  'total_amount': 'Total Amount',
  'order_protection': 'Order Protection',
  'secure_payment': 'Secure Payment',
  'customer_support': 'Customer Support',
  '24/7_support': '24/7 Support',
  'price_breakdown': 'Price Breakdown',
  'no_email': 'No Email',
  'service_order': 'Service Order',
  'provider': 'Provider',
  'unknown': 'Unknown',
  'missing_service_or_location_data': 'Missing service or location data',
  'delivery_fee': 'Delivery Fee',
  'estimated_delivery_time': 'Estimated Delivery Time',
  'delivery_within_hours': 'Delivery within 2-4 hours',
  'my_profile': 'My Profile',
  'manage_account_preferences': 'Manage your account and preferences',
  'verified_member': 'Verified Member',
  'quick_actions': 'Quick Actions',
  'orders_history': 'Orders History',
  'view_order_history': 'View your order history',
  'view_service_history': 'View your service history',
  'support_help': 'Support & Help',
  'about_app': 'About App',
  'app_information': 'App information and details',
  'made_with_love': 'Made with love in Egypt 🇪🇬',
  'failed_to_load_user_data': 'Failed to load user data',
  'failed_to_create_order': 'Failed to create order',
  'user_email_required': 'User email is required',
  'user_name_required': 'User name is required',
  'user_phone_required': 'User phone number is required',
  'service_data_required': 'Service data is required',
  'location_data_required': 'Location data is required',
      
     
      'no_products_found': 'No products in cart',
      'add_products_to_cart_message': 'Add products to your cart to see them here',
      'only_valid': 'only valid',
      'confirm_delete': 'Confirm Delete',
      'are_you_sure_delete': 'Are you sure you want to delete this item?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'order_completed': 'Order Completed',
      'thank_you_for_order': 'Thank you for your order',
      'order_confirmation_message': 'Your order will be delivered soon. You will receive updates via email.',
      'order_number': 'Order Number',
      'estimated_delivery': 'Estimated Delivery',
      'days': 'days',
      'continue_shopping': 'Continue Shopping',
      'view_order_details': 'View Order Details',
      'please_select_location': 'Please select a location',
      'cart_is_empty': 'Cart is empty',
      "login_success": "Login successful",
      "welcome_new_user": "Welcome! Your account has been created successfully",
      'order_confirmed': 'Order confirmed',
      'order_save_failed': 'Failed to save order',
      'please_enter_email_and_password': 'Please enter email and password',
      'login_failed': 'Login failed',
      "address":"Enter your address ",
      'your_shopping_destination': 'Your Shopping Destination',
      'smart_shop': 'Smart Shop',
      'your_smart_shopping_destination': 'Your Smart Shopping Destination',
      "added to cart":"added to cart",
      "payment_method":"Payment Method",
      
      "Add to Cart":"Add to Cart",
      "reviews":"Reviews",
      "only valid":"only valid",
    // Product Home View translations
  'ShopIt': 'ShopIt',
  'Search for items or services': 'Search for items or services',
  'Categories': 'Categories',
  'See all': 'See all',
  'Featured': 'Featured',
  'All products': 'All products',
  'Products in': 'Products in',
  'No products found': 'No products found',
      'Electronics': 'Electronics',
      'Beauty': 'Beauty',
      'Delivery': 'Delivery',
      "Search":"Search",

      // Home Main Content translations
      'what_are_you_looking_for': 'What are you looking for',
      'special_offers': 'Special Offers',
      'no_categories_available': 'No categories available',
      'no_special_offers_available': 'No special offers available',
      'view_all': 'View All',

      'Cleaning': 'Cleaning',
      'Wireless Headphones': 'Wireless Headphones',
      'Organic Face Cream': 'Organic Face Cream',
      'Moving Service': 'Moving Service',
      'Cleaning Supplies': 'Cleaning Supplies',
      'Trending': 'Trending',
      'New': 'New',
      'Popular': 'Popular',
      'Recommended': 'Recommended',
      'everything_you_need': 'Everything you need, always delivered',
      'fresh_and_fast': 'Fresh and Fast',
      'email': 'Email',
      'password': 'Password',
      'login': 'Login',
      'forgot_password': 'Forgot Password?',
      'login_with_apple': 'Login with Apple',
      'login_with_google': 'Login with Google',
      'no_account_register': 'Don’t have an account? Register now',
      'Welcome to Your Shop': 'Welcome to Your Shop',
      'Choose between our premium services or products': 'Choose between our premium services or products',
      'Services': 'Services',
      'Explore our premium services': 'Explore our premium services',
      'Products': 'Products',
      'Browse our curated products': 'Browse our curated products',
      'Choose our premium services or browse products': 'Choose our premium services or browse products',
      'View Reviews': 'View Reviews',
      'product_items': 'items',
      'rating_out_of': '/5.0',
      // Specifications Section
      'Specifications': 'Specifications',
      'Product Specifications': 'Product Specifications',
      'Technical Details': 'Technical Details',
      'Product Information': 'Product Information',
      'Brand': 'Brand',
      'Category': 'Category',
      'Stock': 'Stock',
      'Rating': 'Rating',
      'Availability': 'Availability',
      'In Stock': 'In Stock',
      'Out of Stock': 'Out of Stock',
      'Product ID': 'Product ID',
      'SKU': 'SKU',
      'Weight': 'Weight',
      'Dimensions': 'Dimensions',
      'Material': 'Material',
      'Color': 'Color',
      'Size': 'Size',
      'Warranty': 'Warranty',
      'Manufacturer': 'Manufacturer',
      'Country of Origin': 'Country of Origin',
      'Product Description': 'Product Description',
      'Key Features': 'Key Features',
      'Additional Information': 'Additional Information',
      // Favorites translations
      'favorites': 'favorites',
      'Favorites': 'Favorites',
      'No favorites yet': 'No favorites yet',
      'Add products to your favorites to see them here': 'Add products to your favorites to see them here',
      'Refresh': 'Refresh',
      'Discover amazing products...': 'Discover amazing products...',
      'Loading amazing products...': 'Loading amazing products...',
      'Write a Review': 'Write a Review',
      'Rate this product': 'Rate this product',
      'Write your review (optional)': 'Write your review (optional)',
      'Share your experience with this product...': 'Share your experience with this product...',
      'Submit Review': 'Submit Review',
      'Review submitted successfully': 'Review submitted successfully',
      'Failed to submit review': 'Failed to submit review',
      'Please select a rating': 'Please select a rating',
      'You have already reviewed this product': 'You have already reviewed this product',
      'My Reviews': 'My Reviews',
      "review_submitted":"Review Submitted",
      'No reviews yet': 'No reviews yet',
      'Your reviews will appear here': 'Your reviews will appear here',
      'Write Review': 'Write Review',
      'write_review': 'Write Review',
      'Already Reviewed': 'Already Reviewed',
      'Review Submitted': 'Review Submitted',
      'Loading your favorites...': 'Loading your favorites...',
      'Welcome to Favorites': 'Welcome to Favorites',
      'Preparing your favorite items...': 'Preparing your favorite items...',
      'rating_distribution': 'Rating Distribution',
      'no_reviews_yet': 'No reviews yet',
      // Search translations
      'Search products, categories...': 'Search products, categories...',
      'Filter by category': 'Filter by category',
      'Found': 'Found',
      'products': 'products',
      'Clear filters': 'Clear filters',
      'All': 'All',
      'Try adjusting your search or filters': 'Try adjusting your search or filters',
      // Price filter translations
      'Price range': 'Price range',
      'Price Range': 'Price Range',
      'Min Price': 'Min Price',
      'Max Price': 'Max Price',
      'Apply': 'Apply',
      'Reset': 'Reset',
      'to': 'to',
      // Search widget translations
      'search_products_hint': 'Search products, categories...',
      'filter_by_category': 'Filter by category',
      'price_filter_label': 'Price',
      'price_range_title': 'Price Range',
      'min_price_label': 'Min Price',
      'max_price_label': 'Max Price',
      'price_range_to': 'to',
      'price_filter_reset': 'Reset',
      'price_filter_apply': 'Apply',
      'search_results_found': 'Found',
      'search_results_products': 'products',
      'search_clear_filters': 'Clear filters',
      'search_no_products_found': 'No products found',
      'search_adjust_filters_hint': 'Try adjusting your search or filters',
      'filter_price_range_description': 'Select your preferred price range',
      'price_slider_label': 'Price Range',
      'range_total': 'Range: {range}',
      'price_filter_description': 'Set minimum and maximum price limits',
      // Search loading translations
      'search_loading_products': 'Loading products...',
      'search_loading_description': 'Please wait while we load the latest products',
      'search_searching': 'Searching...',
      'search_searching_description': 'Finding the perfect products for you',
      'search_filter_loading': 'Applying filters...',
      'search_initializing': 'Initializing search...',
      // Product Ads View translations
      'ad_details': 'Ad Details',
      'about_this_ad': 'About This Ad',
      'show_product': 'Show Product',
      'ad_category': 'Ad Category',
      'ad_description': 'Ad Description',
      'review_items_checkout': 'Review your items and proceed to checkout',
      'secure_fast_delivery': 'Secure • Fast delivery',
      'explore_now_en': 'Explore Now',
      'learn_more': 'Learn More',
      'limited_time_offer': 'Limited Time Offer',
      'special_promotion': 'Special Promotion',
      'view_details_en': 'View Details',
      'no_description_available': 'No description available',
      'back_to_home': 'Back to Home',
      'share_ad': 'Share Ad',
      // Product Details translations
      'add_to_cart': 'Add to Cart',
      'product_added_to_cart': 'Product added to cart successfully!',
      'no_desc_available': 'No description available',
      'product_category': 'Category',
      'product_brand': 'Brand',
      'product_rating': 'Rating',
      'quantity_available': 'Quantity Available',
      'product_description': 'Description',
      // Services translations
      'home_services': 'Home Services',
      'services': 'services',
  'no_services_found': 'No services found',
      'no_brands_available': 'No brands available',
      'brand_details': 'Brand Details',
      'services_by_brand': 'Services by Brand',
      'starting_from': 'Starting from',
      'minimum_days': 'Minimum days',
      'days': 'days',
      'login_to_continue': 'Login to continue',
      'welcome_back': 'Welcome back',
      'professional_services': 'Professional Services',
      'please_enter_email': 'Please enter email',
      'please_enter_valid_email': 'Please enter a valid email',
      'please_enter_password': 'Please enter password',
      'password_min_length': 'Password must be at least 6 characters',
      'forgot_password': 'Forgot Password?',
      'error': 'Error',
      'success': 'Success',
      'loading': 'Loading...',
      'try_again': 'Try Again',
      'something_went_wrong': 'Something went wrong',
      'no_internet_connection': 'No internet connection',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'back': 'Back',
      'next': 'Next',
      'finish': 'Finish',
      'skip': 'Skip',
      'visit_website': 'Visit Website',
      'save_vendor': 'Save Vendor',
      'write_review': 'Write Review',
      'delivery_charges': 'Delivery Charges',
      'minimum_days': 'Minimum Days',
      'check_availability': 'Check Availability',
      'dates': 'Dates',
      'advance': 'Advance',
      'starting_from': 'Starting from',
      'preparation': 'Preparation',
      'certifications': 'Certifications',
      'verified': 'Verified',
      'services': 'Services',
      'packages': 'Packages',
      'about': 'About',
      'checkout': 'CHECKOUT',
      'sort_by_rating': 'Sort by Rating',
      'sort_by_price': 'Sort by Price',
      'book_now': 'Book Now',
      'view_details': 'View Details',
      'hide_details': 'Hide Details',
      'popular': 'Popular',
      'save': 'Save',
      'valid_for': 'Valid for',
      'services_included': 'Services Included',
      'package_details': 'Package Details',
      'validity': 'Validity',
      'included_services': 'Included Services',
      'select_package': 'Select Package',
      'no_packages_available': 'No packages available',
      'check_back_later': 'Check back later for new packages',
      'category': 'Category',
      'understood': 'Understood',
      
      // Service Location translations
      'service_location': 'Service Location',
      'location_setup_progress': 'Location Setup Progress',
      'completed': 'Completed',
      'detect_location': 'Detect Location',
      'tap_to_get_current_location': 'Tap to get your current location',
      'location_detected': 'Location Detected',
      'detecting_location': 'Detecting location...',
      'detect_my_location': 'Detect My Location',

      'choose_city': 'Choose City',
      'enter_full_address': 'Enter full address',
      'address_required': 'Address is required',
      'floor_apartment': 'Floor / Apartment',
      'phone_required': 'Phone number is required',
      'invalid_phone': 'Invalid phone number',
      'nearby_landmark': 'Nearby landmark',
      'landmark': 'Landmark',
      'clear_form': 'Clear Form',
      'clear_form_confirmation': 'Are you sure you want to clear all data?',
      'clear': 'Clear',
      'please_enter_address': 'Please enter an address',
      'invalid_phone_number': 'Invalid phone number',
      'location_saved_successfully': 'Location saved successfully',
      'booking_summary': 'Booking Summary',
      'review_selected_service_details': 'Review your selected service details',
      'booking_date_selected': 'Booking Date Selected',
      'booking_time_selected': 'Booking Time Selected',

      'select_location_on_map': 'Select Location on Map',
      'center_on_current_location': 'Center on Current Location',
      'tap_or_drag_marker_to_select': 'Tap or drag the marker to select location',
      'selected_location': 'Selected Location',
      'tap_to_select_location': 'Tap to select location',
      'coordinates': 'Coordinates',
      'confirm_location': 'Confirm Location',



      'unable_to_get_current_location': 'Unable to get current location',

      'use_previously_saved_location': 'Use a previously saved location',
      'view_saved_locations': 'View Saved Locations',
      'your_saved_locations': 'Your Saved Locations',
      'select_from_previously_saved': 'Select from previously saved locations',
      'refresh_locations': 'Refresh Locations',
      'search_saved_locations': 'Search saved locations...',
      'use_selected_location': 'Use Selected Location',

      'no_locations_match_search': 'No locations match your search',
      'no_saved_locations_yet': 'No saved locations yet',
      'save_locations_to_see_them_here': 'Save locations to see them here',
      'add_new_location': 'Add New Location',
      'delete_selected': 'Delete Selected',
      'clear_selection': 'Clear Selection',
      'add_location_to_continue': 'Add a location to continue',
      'delete_location': 'Delete Location',
      'delete_location_confirmation': 'Are you sure you want to delete this location?',





      'saved_on': 'Saved on',
      'locations_found': 'locations found',



      
      // Service Details translations
      'service_description': 'Service Description',
      'service_provider': 'Service Provider',
      'professional_service_provider': 'Professional Service Provider',
      'book_appointment': 'Book Appointment',
      'tap_to_select_time': 'Tap to select a time slot',
      'service_instructions_tip': 'Add any special requirements or additional details',
      // Selection App translations
      'select_service_category': 'Select Service Category',
      'select_product_category': 'Select Product Category',
      'failed_to_load_categories': 'Failed to load categories',
      'no_service_categories_found': 'No service categories found',
      'no_product_categories_found': 'No product categories found',
      'check_back_later': 'Check back later',
      'refresh': 'Refresh',
      'loading_categories': 'Loading categories...',
      'service_categories': 'Service Categories',
      'product_categories': 'Product Categories',
      'categories_available': 'categories available',
      'browse_service_categories_description': 'Browse different service categories and choose what you need',
      'browse_product_categories_description': 'Browse different product categories and choose what you need',
      // Selection App translations'browse_product_categories_description': 'تصفح فئات المنتجات المختلفة واختر ما تحتاجه',
      'contact_feature_coming_soon': 'Contact feature coming soon',
      'select_date': 'Select Date',
      'select_date_hint': 'Select service date',
      'select_time': 'Select Time',
      'add_special_instructions': 'Add special instructions for the service...',
      'total_price': 'Total Price',
      'order_now': 'Order Now',
      'booking_requirements': 'Booking Requirements',
      'please_complete_booking_requirements': 'Please complete the booking requirements before proceeding:',
      'select_preferred_date': 'Select your preferred date',
      'select_preferred_time': 'Select your preferred time',
      'please_select_date': 'Please select a date',
      'please_select_time': 'Please select a time',
      'service_booked_successfully': 'Service booked successfully',
      'booking_failed': 'Failed to book service',
      
      // Services Search translations
      'search_services': 'Search Services',
      'search_hint': 'Search for services...',
      'book_service': 'Book Service',
      'provider': 'Provider',
      'confirm_booking': 'Confirm Booking',
      'success': 'Success',
      'booking_confirmed': 'Booking confirmed successfully',
      'explore_offer': 'Explore Offer',
      'service_categories': 'Service Categories',
      'see_all': 'See All',
      'all': 'All',
      'categories': 'Categories',
      'found': 'Found',
      'refresh': 'Refresh',
      'explore': 'Explore',
      'orders': 'Orders',
      'coming_soon': 'Coming Soon',
      'stay_tuned_for_updates': 'Stay tuned for updates',
      'under_development': 'Under Development',
      'available_services': 'Available Services',
      // ServiceAllCat translations
      'all_categories': 'All Categories',
      'categories_available': 'Categories Available',
      'categories_found': 'categories found',
      'no_categories': 'No Categories',
      'no_categories_description': 'No categories available at the moment. Check back later',
      'search_categories': 'Search Categories',
      'search_categories_hint': 'Search categories...',
      'tap_to_explore': 'Tap to explore',
      'category': 'Category',
      'category_selected': 'Category Selected',
      // Service By Category translations
      'services_available': 'services available',
      'search_services_in_category': 'Search services in category',
      'filter_and_sort': 'Filter & Sort',
      'budget_friendly': 'Budget Friendly',
      'moderate': 'Moderate',
      'premium': 'Premium',
      'all_prices': 'All Prices',
      'any_price': 'Any Price',
      'minimum_rating': 'Minimum Rating',
      'category_statistics': 'Category Statistics',
      'total_services': 'Total Services',
      'average_price': 'Average Price',
      'average_rating': 'Average Rating',
      'no_services_matching_search': 'No services matching search',
      'no_services_in_category': 'No services in this category',
      // 'error_occurred': 'Error Occurred', // Duplicate removed
      'try_again': 'Try Again',
      'Default': 'Default',
      'Price: Low to High': 'Price: Low to High',
      'Price: High to Low': 'Price: High to Low',
      'Rating: High to Low': 'Rating: High to Low',
      'Rating: Low to High': 'Rating: Low to High',
      'Name: A to Z': 'Name: A to Z',
      'Name: Z to A': 'Name: Z to A',
      // Favorites translations
      'error': 'Error',
      'please_login_first': 'Please login first',
      'added_to_favorites': 'Added to favorites',
      'removed_from_favorites': 'Removed from favorites',
      'error_updating_favorites': 'Error updating favorites',
      'confirm': 'Confirm',
      'clear_all_favorites': 'Clear All Favorites',
      'all_favorites_cleared': 'All favorites cleared',
      'error_fetching_favorites': 'Error fetching favorites',
      'search_favorites': 'Search in favorites...',
      'favorite_services': 'favorite services',
      'showing': 'Showing',
      'of': 'of',
      'login_to_view_favorites': 'Login to view your favorite services',
      'no_favorite_services': 'No Favorite Services',
      'add_services_to_favorites': 'Add services to your favorites to see them here',
      'explore_services': 'Explore Services',
      'no_search_results': 'No Search Results',
      'try_different_search': 'Try a different search term',
      'clear_search': 'Clear Search',
      'clear_all_favorites_confirmation': 'Are you sure you want to clear all your favorites? This action cannot be undone.',
      'clear_all': 'Clear All',
      // Shared state widget translations
      'login_to_view_content': 'Login to view content',
      'no_internet_connection': 'No Internet Connection',
      'check_internet_and_try_again': 'Check your internet connection and try again',
      'retry': 'Retry',
      'no_results_found': 'No Results Found',
      'no_results_for_query': 'No results found for "{query}"',
      'try_different_search_terms': 'Try different search terms',
      'feature_coming_soon_description': 'This feature is under development and will be available soon',
      'under_maintenance': 'Under Maintenance',
      'maintenance_description': 'We are working to improve the app. It will be available soon',
      // 'permission_required': 'Permission Required', // Duplicate removed
      'permission_required_description': 'We need your permission to access this feature',
      // 'grant_permission': 'Grant Permission', // Duplicate removed
      'explore_products': 'Explore Products',
      'explore_categories': 'Explore Categories',
      'loading_services': 'Loading services...',
      'services_found': 'services found',
      'search_statistics': 'Search Statistics',
      'apply_filters': 'Apply Filters',
      'clear_filters': 'Clear Filters',
      'stars': 'stars',
      'search_services_providers': 'Search services and providers...',
      
      // Booking Requirements Dialog
      'booking_incomplete': 'Booking Incomplete',
      'complete_required_fields_to_continue': 'Complete the required fields to continue',
      'missing_requirements': 'Missing Requirements',
      
      // Validation translations
      'validation_error': 'Validation Error',
      'unknown_validation_error': 'Unknown validation error',
      'field_field': 'Field: {field}',
      'missing_fields': 'Missing Fields',
      'validation_errors_found': 'Validation Errors Found',
      'form_validation_errors': 'Form Validation Errors',
      'validation_passed': 'Validation Passed',
      'validate_and_submit': 'Validate and Submit',
      'form_validation_passed': 'Form validation passed successfully',
      'form_submitted_successfully': 'Form submitted successfully',
      'form_validation_failed': 'Form validation failed',
      'validated_location_form_example': 'Validated Location Form Example',
      'location_information': 'Location Information',
      'enter_phone_number': 'Enter phone number',
      'enter_floor_optional': 'Enter floor (optional)',
      'enter_landmark_optional': 'Enter landmark (optional)',
      
      // Additional validation messages
      'user_profile_incomplete': 'User profile is incomplete',
      'invalid_service_id': 'Invalid service ID',
      'service_name_required': 'Service name is required',
      'invalid_service_price': 'Invalid service price',
      'cannot_select_past_date': 'Cannot select a date in the past',
      'date_too_far_future': 'Date is too far in the future',
      'required_location_fields_missing': 'Required location fields are missing',
      'invalid_email_format': 'Invalid email format',
      'name_too_short': 'Name is too short',
      'invalid_city_selection': 'Invalid city selection',
      'address_too_short': 'Address is too short',
      'notes_too_long': 'Notes are too long (maximum {max} characters)',
      'location_coordinates_required': 'Location coordinates are required',
      'invalid_latitude': 'Invalid latitude',
      'invalid_longitude': 'Invalid longitude',
      'field_required': 'Field {field} is required',
      'field_min_length': 'Field {field} must be at least {min} characters',
      'field_max_length': 'Field {field} must not exceed {max} characters',
      'order_validation_failed': 'Order validation failed',
      'validation_failed': 'Validation failed',
      
      // Order system translations
      'user_information': 'User Information',
      'delivery_location': 'Delivery Location',
      'price_summary': 'Price Summary',
      'service_price': 'Service Price',
      'unknown_service': 'Unknown Service',
      'unknown_location': 'Unknown Location',
      'no_email': 'No Email',
      'no_name': 'No Name',
      'placing_order': 'Placing Order...',
      'order_placement_failed': 'Order Placement Failed',
      'invalid_price': 'Invalid Price',
      
      // Service Orders translations  
      'no_orders_yet': 'No Orders Yet',
      'no_orders_with_status': 'No {status} Orders',
      'start_ordering_services': 'Start ordering services',
      // 'try_different_filter': 'Try a different filter', // Duplicate removed
      'show_all_orders': 'Show All Orders',
      'order_status_pending': 'Pending',
      'order_status_accepted': 'Accepted', 
      'order_status_done': 'Completed',
      'order_status_canceled': 'Canceled',
      'rate_service': 'Rate Service',
      'rate_order': 'Rate Order',
      'order_already_rated': 'Order Already Rated',
      'cannot_rate_pending_order': 'Cannot rate pending order',
      'rating_submitted_successfully': 'Rating submitted successfully',
      'failed_to_submit_rating': 'Failed to submit rating',
      'your_rating': 'Your Rating',
      'add_comment': 'Add Comment (Optional)',
      'submit_rating': 'Submit Rating',
      'rating_comment_placeholder': 'Write your comment here...',
      'rate': 'Rate',
      'rate_now': 'Rate Now',
      'share_your_experience': 'Share your experience with this service',
      'thank_you_for_feedback': 'Thank you for your feedback',
      'submitting': 'Submitting...',
      'welcome_to_smart_shop': 'Welcome to Mountain Store',
      'discover_services_and_products': 'Discover our premium services and quality products',
      'recommendation': 'Recommendation',
      'premium_services': 'Premium Services',
      'professional_home_services': 'Professional home services',
      'quality_products': 'Quality Products',
      'curated_shopping_experience': 'Curated shopping experience',
      'your_activity': 'Your Activity',
      'explore_now': 'Explore Now',
      'services_used': 'Services Used',
      'products_bought': 'Products Bought',
      'good_morning': 'Good Morning',
      'good_afternoon': 'Good Afternoon',
      'good_evening': 'Good Evening',
      'discover_today_deals': 'Discover Today\'s Deals',
      'total_products': 'Total Products',
      'new_arrivals': 'New Arrivals',
      'services_lover_text': 'You seem to love our services! 🌟',
      'shopping_enthusiast_text': 'Shop now for the best services and high-end products    🛍️',
      'welcome_back_text': 'Welcome back! Continue where you left off 👋',
      'new_user_text': 'New here? Choose what interests you most! ✨',
      'today': 'Today',
      'yesterday': 'Yesterday', 
      'days_ago': 'days ago',
      'order_details': 'Order Details',
      'order_information': 'Order Information',
      'order_id': 'Order ID',
      'order_date': 'Order Date',
      'order_status': 'Order Status',
      'service_information': 'Service Information',
      'service_name': 'Service Name',
      'delivery_information': 'Delivery Information',
      'orders_overview': 'Orders Overview',
      'total_orders': 'Total Orders',
      'filter_by_status': 'Filter by Status',
      
      // Mode switching translations
      'current_mode': 'Current Mode',
      'services_mode': 'Services Mode',
      'products_mode': 'Products Mode',
      'switch_to': 'Switch to',
      'switched_to_services_mode': 'Switched to Services Mode',
      'switched_to_products_mode': 'Switched to Products Mode',
      'customer_information': 'Customer Information',
      'customer_name': 'Customer Name',
      'items_count': 'Items Count',
      'item_total': 'Item Total',
      'contact_support': 'Contact Support',
      'order_pending_description': 'Your order is under review and will be accepted soon',
      'order_accepted_description': 'Your order has been accepted and is being prepared for shipping',
      'order_completed_description': 'Your order has been delivered successfully',
      'order_cancelled_description': 'This order has been cancelled',
      'order_status_unknown': 'Order status is unknown',
      'continue_with_location': 'Continue with Location',
      'add_details': 'Add Details',
      'other_location': 'Other Location',
      'phone_number_required': 'Phone Number Required',
      'enter_phone_for_delivery': 'Enter phone number for delivery',
      'refresh_orders': 'Refresh Orders',
      'orders_refreshed': 'Orders refreshed successfully',
      'error_refreshing_orders': 'Error refreshing orders',
      
      // Start view marketing strings
      'discover_convenience': '🚀 Discover a New World of Convenience',
      'professional_services_description': 'Professional home services & premium products all in one place',
      'feature_fast': '⚡ Fast',
      'feature_secure': '🔒 Secure', 
      'feature_premium': '💎 Premium',
      'choose_start_journey': '👆 Choose what suits you and start your journey with us',
      
      // Sale Items View translations (only new ones)
      'sale_items': 'Sale Items',
      'highest_discount': 'Highest Discount',
      'lowest_price': 'Lowest Price',
      'highest_price': 'Highest Price',
      'name_a_z': 'Name A-Z',
      'name_z_a': 'Name Z-A',
      'newest_first': 'Newest First',
      'all_discounts': 'All Discounts',
      '10_20_off': '10-20% Off',
      '20_30_off': '20-30% Off',
      '30_50_off': '30-50% Off',
      '50_plus_off': '50%+ Off',
      
      // Favorites marketing strings
      'favorites_marketing_title': '💝 Your Personal Collection',
      'favorites_marketing_subtitle': 'Discover your saved products with ease',
      'favorites_marketing_description': 'All your favorite products in one place, ready to purchase anytime',
      'quick_access': 'Quick Access',
      'saved_items': 'Saved Items',
      'instant_buy': 'Instant Buy',
      
      // Product Ads View new strings
      'featured': 'Featured',
      'verified': 'Verified',
      'product_information': 'Product Information',
      'premium_ad': 'Premium Ad',
      'verified_seller': 'Verified Seller',
      'best_deal': 'Best Deal',
      'hurry_up': 'Hurry Up!',
      'views': 'Views',
      'liked': 'Liked',
      'image_not_available': 'Image not available',
      'loading': 'Loading...',
      
      // Cart View new strings
      'best_price_guaranteed': 'Best Price Guaranteed',
      'proceed_to_checkout': 'Proceed to Checkout',
      'remove_item': 'Remove Item',
      'item_removed': 'Item Removed',
      'cart_updated': 'Cart Updated',
      'empty_cart': 'Empty Cart',
      'add_items_to_cart': 'Add Items to Cart',
      'order_total': 'Order Total',
      'discount_applied': 'Discount Applied',
      'free_shipping': 'Free Shipping',
      'shipping_cost': 'Shipping Cost',
      'tax_included': 'Tax Included',
      'save_for_later': 'Save for Later',
      'move_to_favorites': 'Move to Favorites',
      'recently_viewed': 'Recently Viewed',
      'recommended_for_you': 'Recommended for You',
      'similar_products': 'Similar Products',
      'customers_also_bought': 'Customers Also Bought',
      'back_to_shopping': 'Back to Shopping',
      'continue_to_payment': 'Continue to Payment',
      'apply_coupon': 'Apply Coupon',
      'coupon_code': 'Coupon Code',
      'invalid_coupon': 'Invalid Coupon',
      'coupon_applied': 'Coupon Applied',
      'minimum_order': 'Minimum Order',
      'estimated_total': 'Estimated Total',

      // Search translations
      'search': 'Search',
      'search_brands': 'Search for brands',
      'start_searching': 'Start Searching',
      'search_description': 'Search for your favorite brands by name or category',
      'search_tips': 'Search Tips',
      'search_tip_1': 'Search by brand name in Arabic or English',
      'search_tip_2': 'Try searching by category type for broader results',
      'search_tip_3': 'Use simple keywords for better results',
      'no_results_found': 'No Results Found',
      'no_results_for': 'No results for',
      'try_different_keywords': 'Try different or more general keywords',
      'result_found': 'result',
      'results_found': 'results',
      'loading_brands': 'Loading brands',
      'failed_to_load_brands': 'Failed to load brands',
      
      // Selected Category translations
      'selected_category': 'Selected Category',
      'browsing_category': 'Browsing Category',
      'products_in_category': 'Products in Category',
      'change_category': 'Change Category',
      
      // App message strings
      'network_error': 'Network error. Please check your connection.',
      'authentication_error': 'Authentication error: ',
      'form_not_initialized': 'Form not initialized properly',
      'user_info_error': 'Failed to retrieve user information',
      'login_failed_generic': 'Login failed: ',
      'call': 'Call',
      'chat': 'Chat',
      'share': 'Share',
      'back': 'Back',

    },
  };
}