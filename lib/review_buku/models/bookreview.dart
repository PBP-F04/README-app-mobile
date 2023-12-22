// To parse this JSON data, do
//
//     final bookReview = bookReviewFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

BookReview bookReviewFromJson(String str) =>
    BookReview.fromJson(json.decode(str));

String bookReviewToJson(BookReview data) => json.encode(data.toJson());

class BookReview {
  List<Review> reviews;

  BookReview({
    required this.reviews,
  });

  factory BookReview.fromJson(Map<String, dynamic> json) => BookReview(
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  String id;
  String user;
  double reviewScore;
  String reviewContent;
  DateTime createdAt;

  Review({
    required this.id,
    required this.user,
    required this.reviewScore,
    required this.reviewContent,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        user: json["user"],
        reviewScore: json["review_score"],
        reviewContent: json["review_content"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "review_score": reviewScore,
        "review_content": reviewContent,
        "created_at": createdAt.toIso8601String(),
      };
}
