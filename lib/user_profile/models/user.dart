// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String model;
  String pk;
  Fields fields;

  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String profileImage;
  String username;
  String name;
  String description;
  String favoriteCategory;
  String user;

  Fields({
    required this.profileImage,
    required this.username,
    required this.name,
    required this.description,
    required this.favoriteCategory,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        profileImage: json["profile_image"],
        username: json["username"],
        name: json["name"],
        description: json["description"],
        favoriteCategory: json["favorite_category"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "profile_image": profileImage,
        "username": username,
        "name": name,
        "description": description,
        "favorite_category": favoriteCategory,
        "user": user,
      };
}
