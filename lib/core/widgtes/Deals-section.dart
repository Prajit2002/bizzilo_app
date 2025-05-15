import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:ecommerce_app/core/utils/Responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DealsSection extends StatelessWidget {
  final List<DealItem> deals;
  final String title;

  const DealsSection({super.key, required this.deals, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSectionPadding(context),
        vertical: ResponsiveUtils.isMobile(context) ? 20 : 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔥 $title',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.isMobile(context) ? 20 : 24,
                ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth * 0.8;
              final cardHeight = ResponsiveUtils.isMobile(context)
                  ? 200
                  : ResponsiveUtils.isTablet(context)
                      ? 250
                      : 300;

              return CarouselSlider.builder(
                itemCount: deals.length,
                itemBuilder: (context, index, realIndex) {
                  final deal = deals[index];
                  return SizedBox(
                    width: cardWidth,
                    child: DealCarouselCard(deal: deal),
                  );
                },
                options: CarouselOptions(
                  height: cardHeight.toDouble(),
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: ResponsiveUtils.isMobile(context) ? 0.8 : 0.7,
                  autoPlayInterval: const Duration(seconds: 5),
                  padEnds: false,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DealCarouselCard extends StatelessWidget {
  final DealItem deal;

  const DealCarouselCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.isMobile(context) ? 4 : 8,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: deal.image,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: Colors.grey.shade300),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deal.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveUtils.isMobile(context) ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${deal.price}',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: ResponsiveUtils.isMobile(context) ? 14 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deal.discount,
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: ResponsiveUtils.isMobile(context) ? 10 : 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}