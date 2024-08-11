import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  String? id;
  String? userId;
  ProductId? productId;
  int? quantity;

  CartModel({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userId: json["user_id"],
        productId: json["product_id"] == null
            ? null
            : ProductId.fromJson(json["product_id"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "product_id": productId?.toJson(),
        "quantity": quantity,
      };
}

class ProductId {
  Price? price;
  String? id;
  String? foodName;
  String? imageUrl;
  String? preparationTime;
  List<String>? foodTags;
  String? zipCode;
  bool? isAvailable;
  String? category;
  double? rating;
  String? ratingCount;
  String? restaurant;
  String? description;

  ProductId({
    this.price,
    this.id,
    this.foodName,
    this.imageUrl,
    this.preparationTime,
    this.foodTags,
    this.zipCode,
    this.isAvailable,
    this.category,
    this.rating,
    this.ratingCount,
    this.restaurant,
    this.description,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        id: json["_id"],
        foodName: json["food_name"],
        imageUrl: json["image_url"],
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
      );

  Map<String, dynamic> toJson() => {
        "price": price?.toJson(),
        "_id": id,
        "food_name": foodName,
        "image_url": imageUrl,
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
