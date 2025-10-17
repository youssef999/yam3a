import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shop_app/core/res/app_colors.dart';

/// Helper class for consistent cached network image implementation across the app
class CachedImageHelper {
  
  /// Creates a standard cached network image widget
  static Widget buildCachedImage({
    required String imageUrl,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
    int? memCacheWidth,
    int? memCacheHeight,
    Duration fadeInDuration = const Duration(milliseconds: 200),
    Duration fadeOutDuration = const Duration(milliseconds: 200),
  }) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth ?? (width * 2).toInt(),
      memCacheHeight: memCacheHeight ?? (height * 2).toInt(),
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      placeholder: (context, url) => placeholder ?? _buildDefaultPlaceholder(width, height),
      errorWidget: (context, url, error) => errorWidget ?? _buildDefaultErrorWidget(width, height),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
    }

    return image;
  }

  /// Creates a cached image for product cards
  static Widget buildProductImage({
    required String imageUrl,
    double width = double.infinity,
    double height = 150,
    BorderRadius? borderRadius,
  }) {
    return buildCachedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      memCacheWidth: 300,
      memCacheHeight: 300,
      placeholder: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
              Colors.grey.shade50,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      errorWidget: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_rounded,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'Image not available',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a cached image for service cards
  static Widget buildServiceImage({
    required String imageUrl,
    double width = 80,
    double height = 80,
    BorderRadius? borderRadius,
  }) {
    return buildCachedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      memCacheWidth: 160,
      memCacheHeight: 160,
      placeholder: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
      errorWidget: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// Creates a cached image for ads and banners
  static Widget buildAdImage({
    required String imageUrl,
    double width = double.infinity,
    double height = 180,
    BorderRadius? borderRadius,
  }) {
    return buildCachedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      memCacheWidth: 400,
      memCacheHeight: 300,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Container(
        width: width,
        height: height,
        color: Colors.grey[100],
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
      errorWidget: Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: Icon(Icons.broken_image, size: 48, color: iconColor),
      ),
    );
  }

  /// Default placeholder widget
  static Widget _buildDefaultPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[100],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      ),
    );
  }

  /// Default error widget
  static Widget _buildDefaultErrorWidget(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(
        Icons.broken_image,
        size: 48,
        color: Colors.grey,
      ),
    );
  }

  /// Preload images for better performance
  static void preloadImages(BuildContext context, List<String> imageUrls) {
    for (String imageUrl in imageUrls) {
      if (imageUrl.isNotEmpty) {
        precacheImage(CachedNetworkImageProvider(imageUrl), context);
      }
    }
  }

  /// Clear all cached images
  static Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  /// Get cache size (returns estimated cache entries count)
  static Future<int> getCacheSize() async {
    try {
      // This is an estimation - actual cache size calculation is complex
      // You can implement more sophisticated cache size calculation if needed
      return 0; 
    } catch (e) {
      return 0;
    }
  }
}