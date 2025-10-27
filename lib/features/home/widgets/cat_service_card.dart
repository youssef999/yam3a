

  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/brands/brands_view.dart';
import 'package:shop_app/features/home/models/cat_service.dart';

Widget catServiceCard({
    required CatService catService,
  }) {
    
    Widget buildIcon() {
      if (catService.icon.isEmpty) {
        return const Icon(Icons.category, color: Colors.white, size: 32);
      }

      if (catService.icon.startsWith('http')) {
        return Image.network(
          catService.icon,
          height: 36,
          width: 36,
          color: Colors.white,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.category, color: Colors.white, size: 32),
        );
      }

      return Image.asset(
        catService.image,
        height: 36,
        width: 36,
        color: Colors.white,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.category, color: Colors.white, size: 32),
      );
    }

    return InkWell(
      onTap: () {
        AnimatedGet.toWithSlideRight(BrandsView(category: catService));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: catService.image.startsWith('http')
                    ? NetworkImage(catService.image)
                    : AssetImage(catService.image) as ImageProvider,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.65),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: buildIcon(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      Get.locale?.languageCode == 'ar' ? catService.nameAr : catService.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }