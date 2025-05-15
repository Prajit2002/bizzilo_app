import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:ecommerce_app/core/utils/Responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';



class ModernBannerSection extends StatelessWidget {
  final List<BannerItem> banners;

  const ModernBannerSection({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    final bannerHeight = ResponsiveUtils.getBannerHeight(context);

    return SizedBox(
      height: bannerHeight,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: bannerHeight,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: true,
          enableInfiniteScroll: true,
        ),
        items: banners.map((banner) {
          return Container(
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: banner.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                ),
                Positioned(
                  bottom: 40,
                  left: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {
                          // You can add banner-specific actions here
                        },
                        child: const Text("SHOP NOW"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}