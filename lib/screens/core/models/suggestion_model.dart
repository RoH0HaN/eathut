import 'dart:convert';

SuggestionModel suggestionModelFromJson(String str) =>
    SuggestionModel.fromJson(json.decode(str));

String suggestionModelToJson(SuggestionModel data) =>
    json.encode(data.toJson());

class SuggestionModel {
  List<Restaurant>? restaurants;
  List<Food>? foods;

  SuggestionModel({
    this.restaurants,
    this.foods,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) =>
      SuggestionModel(
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
        foods: json["foods"] == null
            ? []
            : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toJson())),
      };
}

class Food {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? restaurantName;

  Food({
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
    this.createdAt,
    this.updatedAt,
    this.restaurantName,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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

class Restaurant {
  String? id;
  String? restaurantName;
  String? logoUrl;
  String? phone;
  String? restaurantPlace;
  String? restaurantType;
  bool? pickup;
  bool? delivery;
  bool? isAvailable;
  String? owner;
  double? rating;
  String? ratingCount;
  String? verification;
  Address? address;

  Restaurant({
    this.id,
    this.restaurantName,
    this.logoUrl,
    this.phone,
    this.restaurantPlace,
    this.restaurantType,
    this.pickup,
    this.delivery,
    this.isAvailable,
    this.owner,
    this.rating,
    this.ratingCount,
    this.verification,
    this.address,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        restaurantName: json["restaurant_name"],
        logoUrl: json["logo_url"],
        phone: json["phone"],
        restaurantPlace: json["restaurant_place"],
        restaurantType: json["restaurant_type"],
        pickup: json["pickup"],
        delivery: json["delivery"],
        isAvailable: json["is_available"],
        owner: json["owner"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"],
        verification: json["verification"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurant_name": restaurantName,
        "logo_url": logoUrl,
        "phone": phone,
        "restaurant_place": restaurantPlace,
        "restaurant_type": restaurantType,
        "pickup": pickup,
        "delivery": delivery,
        "is_available": isAvailable,
        "owner": owner,
        "rating": rating,
        "rating_count": ratingCount,
        "verification": verification,
        "address": address?.toJson(),
      };
}

class Address {
  String? addressLine1;
  String? state;
  String? zipCode;
  String? latitude;
  String? longitude;

  Address({
    this.addressLine1,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["address_line_1"],
        state: json["state"],
        zipCode: json["zip_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "address_line_1": addressLine1,
        "state": state,
        "zip_code": zipCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
