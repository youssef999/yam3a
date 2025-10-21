// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final String? label;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  bool obs;
  bool obx;
  bool? input;
  TextInputType type;
  final Color color;
  int? max;
  TextEditingController controller;
  final bool enabled;
  final VoidCallback? onTap;

  CustomTextFormField({
    Key? key,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.validator,
    this.max = 1,
    this.obx = false,
    this.type = TextInputType.text,
    this.input,
    required this.obs,
    required this.color,
    required this.controller,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  // Factory constructor for email fields
  factory CustomTextFormField.email({
    Key? key,
    required String hint,
    String? label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Color color = Colors.blue,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return CustomTextFormField(
      key: key,
      hint: hint,
      label: label ?? 'Email'.tr,
      prefixIcon: Icons.email_outlined,
      controller: controller,
      validator: validator ?? _defaultEmailValidator,
      type: TextInputType.emailAddress,
      obs: false,
      color: color,
      enabled: enabled,
      onTap: onTap,
    );
  }

  // Factory constructor for password fields
  factory CustomTextFormField.password({
    Key? key,
    required String hint,
    String? label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Color color = Colors.blue,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return CustomTextFormField(
      key: key,
      hint: hint,
      label: label ?? 'Password'.tr,
      prefixIcon: Icons.lock_outline,
      controller: controller,
      validator: validator ?? _defaultPasswordValidator,
      obs: true,
      obx: true,
      color: color,
      enabled: enabled,
      onTap: onTap,
    );
  }

  // Factory constructor for phone fields
  factory CustomTextFormField.phone({
    Key? key,
    required String hint,
    String? label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Color color = Colors.blue,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return CustomTextFormField(
      key: key,
      hint: hint,
      label: label ?? 'Phone'.tr,
      prefixIcon: Icons.phone_outlined,
      controller: controller,
      validator: validator ?? _defaultPhoneValidator,
      type: TextInputType.phone,
      obs: false,
      color: color,
      enabled: enabled,
      onTap: onTap,
    );
  }

  // Factory constructor for name fields
  factory CustomTextFormField.name({
    Key? key,
    required String hint,
    String? label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Color color = Colors.blue,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return CustomTextFormField(
      key: key,
      hint: hint,
      label: label ?? 'Name'.tr,
      prefixIcon: Icons.person_outline,
      controller: controller,
      validator: validator ?? _defaultNameValidator,
      type: TextInputType.name,
      obs: false,
      color: color,
      enabled: enabled,
      onTap: onTap,
    );
  }

  // Default validators
  static String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? _defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? _defaultPhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? _defaultNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final theme = Theme.of(context);
    final isDarkMode = box.read('theme') == 'ThemeMode.dark' || 
                      theme.brightness == Brightness.dark;
    
    Color txtColor = isDarkMode ? Colors.white : Colors.black87;
    Color hintColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
    Color fillColor = isDarkMode ? Colors.grey[800]! : Colors.grey[50]!;
    Color focusedFillColor = isDarkMode ? Colors.grey[750]! : Colors.white;
    Color borderColor = isDarkMode ? Colors.grey[600]! : Colors.grey[300]!;
    Color focusedBorderColor = theme.primaryColor;

    final baseDecoration = InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      labelStyle: TextStyle(
        color: _isFocused ? focusedBorderColor : hintColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: 14,
      ),
      filled: true,
      fillColor: _isFocused ? focusedFillColor : fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      prefixIcon: widget.prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Icon(
                widget.prefixIcon,
                color: _isFocused ? focusedBorderColor : hintColor,
                size: 22,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 50,
        minHeight: 24,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
    );

    Widget textField;

    if (widget.obx == true) {
      // Password field with visibility toggle
      textField = TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: widget.obs,
        controller: widget.controller,
        enabled: widget.enabled,
        onTap: widget.onTap,
        validator: widget.validator,
        style: TextStyle(
          color: txtColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: baseDecoration.copyWith(
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    widget.prefixIcon ?? Icons.lock_outline,
                    color: _isFocused ? focusedBorderColor : hintColor,
                    size: 22,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    Icons.lock_outline,
                    color: _isFocused ? focusedBorderColor : hintColor,
                    size: 22,
                  ),
                ),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                widget.obs ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: _isFocused ? focusedBorderColor : hintColor,
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  widget.obs = !widget.obs;
                });
              },
              splashRadius: 20,
            ),
          ),
        ),
      );
    } else if (widget.input == true) {
      // Number input field
      textField = TextFormField(
        focusNode: _focusNode,
        obscureText: widget.obs,
        keyboardType: TextInputType.number,
        maxLines: widget.max,
        controller: widget.controller,
        enabled: widget.enabled,
        onTap: widget.onTap,
        validator: widget.validator,
        style: TextStyle(
          color: txtColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: baseDecoration.copyWith(
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    widget.prefixIcon ?? Icons.numbers,
                    color: _isFocused ? focusedBorderColor : hintColor,
                    size: 22,
                  ),
                )
              : null,
        ),
      );
    } else {
      // Regular text field
      IconData? defaultIcon;
      if (widget.type == TextInputType.emailAddress) {
        defaultIcon = Icons.email_outlined;
      } else if (widget.type == TextInputType.phone) {
        defaultIcon = Icons.phone_outlined;
      } else if (widget.type == TextInputType.name) {
        defaultIcon = Icons.person_outline;
      }

      textField = TextFormField(
        focusNode: _focusNode,
        obscureText: widget.obs,
        keyboardType: widget.type,
        maxLines: widget.max,
        controller: widget.controller,
        enabled: widget.enabled,
        onTap: widget.onTap,
        validator: widget.validator,
        style: TextStyle(
          color: txtColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: baseDecoration.copyWith(
          prefixIcon: (widget.prefixIcon != null || defaultIcon != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    widget.prefixIcon ?? defaultIcon,
                    color: _isFocused ? focusedBorderColor : hintColor,
                    size: 22,
                  ),
                )
              : null,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isFocused 
                      ? focusedBorderColor.withOpacity(0.15)
                      : Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
                  blurRadius: _isFocused ? 12 : 8,
                  offset: Offset(0, _isFocused ? 4 : 2),
                  spreadRadius: _isFocused ? 1 : 0,
                ),
              ],
            ),
            child: textField,
          );
        },
      ),
    );
  }
}
