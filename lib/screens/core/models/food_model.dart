import 'dart:convert';

List<FoodModel> foodModelFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  String? id;
  String? foodName;
  String? imageUrl;
  Price? price;
  String? preparationTime;
  List<String>? foodTags;
  String? zipCode;
  bool? isAvailable;
  String? category;
  double? rating;
  String? ratingCount;
  String? restaurant;
  String? description;
  String? restaurantName;

  FoodModel({
    this.id,
    this.foodName,
    this.imageUrl,
    this.price,
    this.preparationTime,
    this.foodTags,
    this.zipCode,
    this.isAvailable,
    this.category,
    this.rating,
    this.ratingCount,
    this.restaurant,
    this.description,
    this.restaurantName,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["_id"],
        foodName: json["food_name"],
        imageUrl: json["image_url"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        preparationTime: json["preparation_time"],
        foodTags: json["food_tags"] == null
            ? []
            : List<String>.from(json["food_tags"]!.map((x) => x)),
        zipCode: json["zip_code"],
        isAvailable: json["is_available"],
        category: json["category"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"],
        restaurant: json["restaurant"],
        description: json["description"],
        restaurantName: json["restaurant_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "food_name": foodName,
        "image_url": imageUrl,
        "price": price?.toJson(),
        "preparation_time": preparationTime,
        "food_tags":
            foodTags == null ? [] : List<dynamic>.from(foodTags!.map((x) => x)),
        "zip_code": zipCode,
        "is_available": isAvailable,
        "category": category,
        "rating": rating,
        "rating_count": ratingCount,
        "restaurant": restaurant,
        "description": description,
        "restaurant_name": restaurantName,
      };
}

class Price {
  double? mrp;
  double? basePrice;
  double? delCharge;
  double? companyCharge;
  double? packaging;
  double? profit;
  double? handCharge;
  double? discount;
  double? discountPrice;

  Price({
    this.mrp,
    this.basePrice,
    this.delCharge,
    this.companyCharge,
    this.packaging,
    this.profit,
    this.handCharge,
    this.discount,
    this.discountPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        mrp: json["mrp"]?.toDouble(),
        basePrice: json["base_price"]?.toDouble(),
        delCharge: json["del_charge"]?.toDouble(),
        companyCharge: json["company_charge"]?.toDouble(),
        packaging: json["packaging"]?.toDouble(),
        profit: json["profit"]?.toDouble(),
        handCharge: json["hand_charge"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mrp": mrp,
        "base_price": basePrice,
        "del_charge": delCharge,
        "company_charge": companyCharge,
        "packaging": packaging,
        "profit": profit,
        "hand_charge": handCharge,
        "discount": discount,
        "discount_price": discountPrice,
      };
}
