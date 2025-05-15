class HomeResponse {
  final List<Section> sections;

  HomeResponse({required this.sections});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final String type;
  final List<dynamic> data;
  final String title;
  
  Section({
    required this.type,
    required this.data,
    this.title = "", // Provide default empty string
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      type: json['type'] as String? ?? "", // Handle null case
      data: json['data'] as List<dynamic>? ?? [], // Handle null case
      title: json['title'] as String? ?? "", // Handle null case
    );
  }
}

class BannerItem {
  final String imageUrl;
  final String title;
  BannerItem({required this.imageUrl,required this.title });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(imageUrl: json['image_url'],
    title: json["title"]
    );
  }
}

class BrandItem {
  final String name;
  final String image;
  final String? category;

  BrandItem({
    required this.name,
    required this.image,
    this.category,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) {
    return BrandItem(
      name: json['name'],
      image: json['image'],
      category: json['category'],
    );
  }
}

class RecommendationItem {
  final String name;
  final double price;
  final String image;
  final String? discount;

  RecommendationItem({
    required this.name,
    required this.price,
    required this.image,
    this.discount,
  });

  factory RecommendationItem.fromJson(Map<String, dynamic> json) {
    return RecommendationItem(
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      discount: json['discount'],
    );
  }
}

class VideoBannerItem {
  final String videoUrl;
  final String thumbnail;

  VideoBannerItem({required this.videoUrl, required this.thumbnail});

  factory VideoBannerItem.fromJson(Map<String, dynamic> json) {
    return VideoBannerItem(
      videoUrl: json['video_url'],
      thumbnail: json['thumbnail'],
    );
  }
}

class CategoryItem {
  final String name;
  final String image;

  CategoryItem({required this.name, required this.image});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      name: json['name'],
      image: json['image'],
    );
  }
}

class DealItem {
  final String title;
  final double price;
  final String image;
  final String discount;

  DealItem({
    required this.title,
    required this.price,
    required this.image,
    required this.discount,
  });

  factory DealItem.fromJson(Map<String, dynamic> json) {
    return DealItem(
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      discount: json['discount'],
    );
  }
}

class ProductGrid {
  final String title;
  final List<ProductItem> products;
  final String direction;

  ProductGrid({
    required this.title,
    required this.products,
    required this.direction,
  });

  factory ProductGrid.fromJson(Map<String, dynamic> json) {
    return ProductGrid(
      title: json['title'],
      products: (json['products'] as List)
          .map((product) => ProductItem.fromJson(product))
          .toList(),
      direction: json['direction'],
    );
  }
}

class ProductItem {
  final String name;
  final double price;
  final String image;

  ProductItem({
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class SummerSaleItem {
  final String title;
  final String subtitle;
  final String image;
  final String? discount;
  final String? buttonText;

  SummerSaleItem({
    required this.title,
    required this.subtitle,
    required this.image,
    this.discount,
    this.buttonText,
  });

  factory SummerSaleItem.fromJson(Map<String, dynamic> json) {
    return SummerSaleItem(
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      discount: json['discount'],
      buttonText: json['button_text'],
    );
  }
}

class FestivalWear {
  final String name;
  final String image;
  final String category;
  final double price;
  final String? occasion;

  FestivalWear({
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    this.occasion,
  });

  factory FestivalWear.fromJson(Map<String, dynamic> json) {
    return FestivalWear(
      name: json['name'],
      image: json['image'],
      category: json['category'],
      price: json['price'].toDouble(),
      occasion: json['occasion'],
    );
  }
}

class MemberService {
  final String title;
  final String icon; // Now expecting a URL string
  final String? description;

  MemberService({
    required this.title,
    required this.icon,
    this.description,
  });

  factory MemberService.fromJson(Map<String, dynamic> json) {
    return MemberService(
      title: json['title'] as String? ?? 'Service',
      icon: json['icon'] as String? ?? '', // Default empty string
      description: json['description'] as String?,
    );
  }
}
class ElectronicsSection {
  final String title;
  final List<ElectronicItem> items;

  ElectronicsSection({
    required this.title,
    required this.items,
  });

  factory ElectronicsSection.fromJson(Map<String, dynamic> json) {
    return ElectronicsSection(
      title: json['title'] as String? ?? "Electronics", // Default title
      items: (json['items'] as List<dynamic>? ?? []) // Handle null list
          .map((item) => ElectronicItem.fromJson(item))
          .toList(),
    );
  }
}

class HomeApplianceSection {
  final String title;
  final List<HomeApplianceItem> items;

  HomeApplianceSection({
    required this.title,
    required this.items,
  });

  factory HomeApplianceSection.fromJson(Map<String, dynamic> json) {
    return HomeApplianceSection(
      title: json['title'] as String? ?? "Home Appliances", // Default title
      items: (json['items'] as List<dynamic>? ?? []) // Handle null list
          .map((item) => HomeApplianceItem.fromJson(item))
          .toList(),
    );
  }
}
class ElectronicItem {
  final String name;
  final String image;
  final double price;
  final String brand;

  ElectronicItem({
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
  });

  factory ElectronicItem.fromJson(Map<String, dynamic> json) {
    return ElectronicItem(
      name: json['name'] as String? ?? 'Unnamed Product',
      image: json['image'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      brand: json['brand'] as String? ?? 'Unknown Brand',
    );
  }
}

class HomeApplianceItem {
  final String name;
  final String image;
  final double price;
  final String category;

  HomeApplianceItem({
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  factory HomeApplianceItem.fromJson(Map<String, dynamic> json) {
    return HomeApplianceItem(
      name: json['name'] as String? ?? "Unnamed Appliance",
      image: json['image'] as String? ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? "General",
    );
  }
}

class ReviewSection {
  final String title;
  final List<ReviewItem> reviews;

  ReviewSection({
    required this.title,
    required this.reviews,
  });

  factory ReviewSection.fromJson(Map<String, dynamic> json) {
    return ReviewSection(
      title: json['title'] as String? ?? 'Customer Reviews',
      reviews: (json['reviews'] as List? ?? [])
          .map((item) => ReviewItem.fromJson(item))
          .toList(),
    );
  }
}

class ReviewItem {
  final String profileImage;
  final String reviewerName;
  final String reviewText;
  final double rating;
  final String date;
  final bool verified;

  ReviewItem({
    required this.profileImage,
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
    required this.date,
    this.verified = false,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      profileImage: json['profile_image'] as String? ?? '',
      reviewerName: json['reviewer_name'] as String? ?? 'Anonymous',
      reviewText: json['review_text'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
    );
  }
}