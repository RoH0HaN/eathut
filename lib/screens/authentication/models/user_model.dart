import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? userType;
  String? profilePic;
  bool? mailVerification;
  Address? address;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.userType,
    this.profilePic,
    this.mailVerification,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        userType: json["user_type"],
        profilePic: json["profile_pic"],
        mailVerification: json["mail_verification"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "user_type": userType,
        "profile_pic": profilePic,
        "mail_verification": mailVerification,
        "address": address?.toJson(),
      };
}

class Address {
  String? id;
  String? userId;
  String? fullName;
  String? city;
  String? landmark;
  String? address;
  bool? isDefault;
  String? phone;
  String? zipCode;
  String? latitude;
  String? longitude;

  Address({
    this.id,
    this.userId,
    this.fullName,
    this.city,
    this.landmark,
    this.address,
    this.isDefault,
    this.phone,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        city: json["city"],
        landmark: json["landmark"],
        address: json["address"],
        isDefault: json["is_default"],
        phone: json["phone"],
        zipCode: json["zip_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "full_name": fullName,
        "city": city,
        "landmark": landmark,
        "address": address,
        "is_default": isDefault,
        "phone": phone,
        "zip_code": zipCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
