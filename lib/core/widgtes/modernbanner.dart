import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:flutter/material.dart';
class ModernBannerSection extends StatelessWidget {
  final List<BannerItem> banners;

  const ModernBannerSection({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const height = 400.0;

    return SizedBox(
      height: height,
      width: double.infinity, // full width
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: true,
          enableInfiniteScroll: true,
        ),
        items: banners.map((banner) {
          return SizedBox(
            width: width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: banner.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      // Text and button overlaid outside carousel items, so they don't move per slide:
      // But if you want to show the text per banner (dynamic), put inside each item.
      // For static text:
      // Or if you want dynamic banner.title text, include it inside items map
    );
  }
}
