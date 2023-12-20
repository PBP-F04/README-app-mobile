import 'dart:convert';

String emailUser = "Axel";
bool existingProfile = false;

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Model model;
  String pk;
  Fields fields;

  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
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

enum Model { USER_PROFILE_PROFILE }

final modelValues =
    EnumValues({"UserProfile.profile": Model.USER_PROFILE_PROFILE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
