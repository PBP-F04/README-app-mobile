// To parse this JSON data, do
//
//     final discussion = discussionFromJson(jsonString);

import 'dart:convert';

List<Discussion> discussionFromJson(String str) => List<Discussion>.from(json.decode(str).map((x) => Discussion.fromJson(x)));

String discussionToJson(List<Discussion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discussion {
  String model;
  String pk;
  Fields fields;

  Discussion({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
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
  String book;
  String user;
  String username;
  String title;
  String content;
  int upvotes;
  DateTime createdAt;
  DateTime editedAt;

  Fields({
    required this.book,
    required this.user,
    required this.username,
    required this.title,
    required this.content,
    required this.upvotes,
    required this.createdAt,
    required this.editedAt,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    book: json["book"],
    user: json["user"],
    username: json["username"],
    title: json["title"],
    content: json["content"],
    upvotes: json["upvotes"],
    createdAt: DateTime.parse(json["created_at"]),
    editedAt: DateTime.parse(json["edited_at"]),
  );

  Map<String, dynamic> toJson() => {
    "book": book,
    "user": user,
    "username": username,
    "title": title,
    "content": content,
    "upvotes": upvotes,
    "created_at": createdAt.toIso8601String(),
    "edited_at": editedAt.toIso8601String(),
  };
}
