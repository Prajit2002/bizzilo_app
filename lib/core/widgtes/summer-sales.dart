import 'package:ecommerce_app/core/utils/Responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';

class SummerSalesSection extends StatelessWidget {
  final List<SummerSaleItem> items;
  final String title;

  const SummerSalesSection({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 0.9);
    final isMobile = ResponsiveUtils.isMobile(context);
    final padding = ResponsiveUtils.getSectionPadding(context);
    final cardHeight = isMobile ? 220 : 280; // Increased height

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 20 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: cardHeight.toDouble(),
            child: PageView.builder(
              controller: pageController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8.0 : 12.0,
                  ),
                  child: SummerSaleCard(
                    item: item,
                    isMobile: isMobile,
                    hasButton: item.buttonText != null && cardHeight > 200,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: items.length,
              effect: WormEffect(
                dotHeight: isMobile ? 8 : 10,
                dotWidth: isMobile ? 8 : 10,
                activeDotColor: Colors.blue,
                spacing: isMobile ? 8 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummerSaleCard extends StatelessWidget {
  final SummerSaleItem item;
  final bool isMobile;
  final bool hasButton;

  const SummerSaleCard({
    super.key,
    required this.item,
    required this.isMobile,
    this.hasButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias, // Prevent overflow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
            ),
          ),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
            padding: EdgeInsets.all(isMobile ? 16 : 20), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.discount != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 10,
                      vertical: isMobile ? 4 : 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.discount!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ),
                
                const Spacer(),
                
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 22, // Slightly reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: isMobile ? 4 : 6),
                
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 12 : 14, // Slightly reduced font size
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                if (hasButton && item.buttonText != null) ...[
                  SizedBox(height: isMobile ? 12 : 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 6 : 8,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      item.buttonText!,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}