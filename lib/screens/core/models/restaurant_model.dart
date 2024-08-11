import 'dart:convert';

List<RestaurantModel> restaurantModelFromJson(String str) =>
    List<RestaurantModel>.from(
        json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String restaurantModelToJson(List<RestaurantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
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

  RestaurantModel({
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

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
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
        rating: double.parse(json["rating"].toString()),
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
