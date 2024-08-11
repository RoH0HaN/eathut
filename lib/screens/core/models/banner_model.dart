import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(
    json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  String? title;
  String? imageUrl;
  String? id;
  DateTime? createdAt;

  BannerModel({
    this.title,
    this.imageUrl,
    this.id,
    this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        title: json["title"],
        imageUrl: json["image_url"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image_url": imageUrl,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
      };
}
