// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  String model;
  String pk;
  Fields fields;

  Comment({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
  String discussion;
  String user;
  String username;
  String title;
  String content;
  int upvotes;
  DateTime createdAt;
  DateTime editedAt;

  Fields({
    required this.discussion,
    required this.user,
    required this.username,
    required this.title,
    required this.content,
    required this.upvotes,
    required this.createdAt,
    required this.editedAt,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    discussion: json["discussion"],
    user: json["user"],
    username: json["username"],
    title: json["title"],
    content: json["content"],
    upvotes: json["upvotes"],
    createdAt: DateTime.parse(json["created_at"]),
    editedAt: DateTime.parse(json["edited_at"]),
  );

  Map<String, dynamic> toJson() => {
    "discussion": discussion,
    "user": user,
    "username": username,
    "title": title,
    "content": content,
    "upvotes": upvotes,
    "created_at": createdAt.toIso8601String(),
    "edited_at": editedAt.toIso8601String(),
  };
}
