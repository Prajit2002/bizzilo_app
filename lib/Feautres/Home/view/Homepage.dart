import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:ecommerce_app/core/services/ApiServices.dart';
import 'package:ecommerce_app/core/utils/Responsive_utils.dart';

import 'package:ecommerce_app/core/widgtes/Banner-section.dart';
import 'package:ecommerce_app/core/widgtes/Categories-section.dart';
import 'package:ecommerce_app/core/widgtes/Deals-section.dart';
import 'package:ecommerce_app/core/widgtes/Product-grid.dart';
import 'package:ecommerce_app/core/widgtes/Video-section.dart';
import 'package:ecommerce_app/core/widgtes/brand_widget.dart';
import 'package:ecommerce_app/core/widgtes/customer-review.dart';
import 'package:ecommerce_app/core/widgtes/electronics-section.dart';
import 'package:ecommerce_app/core/widgtes/festival-wears.dart';
import 'package:ecommerce_app/core/widgtes/home-appliances.dart';
import 'package:ecommerce_app/core/widgtes/members-service.dart';
import 'package:ecommerce_app/core/widgtes/recommendations.dart';
import 'package:ecommerce_app/core/widgtes/summer-sales.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomeResponse> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = ApiService().fetchHomeSections();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final padding = ResponsiveUtils.getSectionPadding(context);
    final maxWidth = ResponsiveUtils.isDesktop(context) ? 1200.0 : double.infinity;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/app_logo.png",)
           ),
          backgroundColor: Colors.black,
          title: const Text('🇧​​🇮​​🇿​​🇿​​🇮​​🇱​​🇴​ ​🇸​​🇭​​🇴​​🇵​​🇸​', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
            IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.white), onPressed: () {}),
          ],
        ),
        drawer: isMobile
            ? Drawer(
                child: ListView(
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text('Categories', style: TextStyle(color: Colors.white, fontSize: 24)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: const Text('Products'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Account'),
                      onTap: () {},
                    ),
                  ],
                ),
              )
            : null,
        body: FutureBuilder<HomeResponse>(
          future: _homeDataFuture,
          builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return  Center(
      child: Image.asset(
        'assets/loading.gif',
        width: 200,
        height: 200,
      ),
        );
      }
       else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }
      
            final homeResponse = snapshot.data!;
      
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: homeResponse.sections.map((section) {
                        switch (section.type) {
                          case 'banner':
                            final banners = section.data
                                .map((item) => BannerItem.fromJson(item))
                                .toList();
                            return ModernBannerSection(banners: banners);
                          case 'video_banner':
                            final videoBanner = section.data
                                .map((item) => VideoBannerItem.fromJson(item))
                                .toList();
                            return VideoBannerSection(videoData: videoBanner,title: section.title,);
                          case 'categories':
                            final categories = section.data
                                .map((item) => CategoryItem.fromJson(item))
                                .toList();
                            return CategoriesSection(
                                categories: categories, theme: Theme.of(context));
                          case 'deals_of_the_day':
                            final deals = section.data
                                .map((item) => DealItem.fromJson(item))
                                .toList();
                            return DealsSection(deals: deals,title: section.title,);
                          case 'product_grid':
                            final productGrids = section.data
                                .map((item) => ProductGrid.fromJson(item))
                                .toList();
                            return ProductGridSection(productGrids: productGrids);
                          // In your HomeScreen's build method, add this case to the switch statement:
                          case 'brands':
                            final brands = section.data
                                .map((item) => BrandItem.fromJson(item))
                                .toList();
                            return BrandsSection(
                              brands: brands,
                              title: section.title,
                            );
                          case 'recommendations':
                            final recommendations = section.data
                                .map((item) => RecommendationItem.fromJson(item))
                                .toList();
                            return RecommendationsSection(products:recommendations, title:section.title);
                          // Add this case to your switch statement in HomeScreen
                          case 'summer_sales':
                            final summerSales = section.data
                                .map((item) => SummerSaleItem.fromJson(item))
                                .toList();
                            return SummerSalesSection(
                              items: summerSales,
                              title: section.title,
                            );
                             case 'festival_wears':
                        final wears = section.data
                            .map((item) => FestivalWear.fromJson(item))
                            .toList();
                        return FestivalWearsSection(wears: wears, title: section.title);
                      
                      case 'member_services':
                        final services = section.data
                            .map((item) => MemberService.fromJson(item))
                            .toList();
                        return MembersServicesSection(services: services, title: section.title);
                      
                    case 'electronics':
                      final electronics = ElectronicsSection(
                        title: section.title,
                        items: section.data.map((item) => ElectronicItem.fromJson(item)).toList(),
                      );
                      return ElectronicsSectionWidget(data: electronics);
                    
                    case 'home_appliances':
                      final appliances = HomeApplianceSection(
                        title: section.title,
                        items: section.data.map((item) => HomeApplianceItem.fromJson(item)).toList(),
                      );
                      return HomeAppliancesSectionWidget(data: appliances);
                    
                      case 'customer_reviews':
                      // Note the JSON structure has a nested 'data' object with 'title' and 'reviews'
                    
                      final reviewSection = ReviewSection(
                        title: section.title,
                        reviews: section.data.map((item)=> ReviewItem.fromJson(item)).toList(),
                      );
                      return ReviewsSection(data: reviewSection);
                      
                    
                    
                          default:
                            return const SizedBox.shrink();
                        }
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
