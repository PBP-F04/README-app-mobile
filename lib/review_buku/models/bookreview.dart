// To parse this JSON data, do
//
//     final bookReview = bookReviewFromJson(jsonString);

import 'dart:convert';

List<BookReview> bookReviewFromJson(String str) => List<BookReview>.from(json.decode(str).map((x) => BookReview.fromJson(x)));

String bookReviewToJson(List<BookReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookReview {
    String model;
    String pk;
    Fields fields;

    BookReview({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookReview.fromJson(Map<String, dynamic> json) => BookReview(
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
    String user;
    String book;
    int reviewScore;
    String reviewContent;
    DateTime createdAt;

    Fields({
        required this.user,
        required this.book,
        required this.reviewScore,
        required this.reviewContent,
        required this.createdAt,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        reviewScore: json["review_score"],
        reviewContent: json["review_content"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "review_score": reviewScore,
        "review_content": reviewContent,
        "created_at": createdAt.toIso8601String(),
    };
}
