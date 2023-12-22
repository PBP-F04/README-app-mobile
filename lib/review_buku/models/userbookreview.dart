// To parse this JSON data, do
//
//     final bookReviewUser = bookReviewUserFromJson(jsonString);

import 'dart:convert';

BookReviewUser bookReviewUserFromJson(String str) =>
    BookReviewUser.fromJson(json.decode(str));

String bookReviewUserToJson(BookReviewUser data) => json.encode(data.toJson());

class BookReviewUser {
  List<Review> reviews;

  BookReviewUser({
    required this.reviews,
  });

  factory BookReviewUser.fromJson(Map<String, dynamic> json) => BookReviewUser(
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  String id;
  String judulBuku;
  double reviewScore;
  String reviewContent;
  DateTime createdAt;

  Review({
    required this.id,
    required this.judulBuku,
    required this.reviewScore,
    required this.reviewContent,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        judulBuku: json["judul_buku"],
        reviewScore: json["review_score"],
        reviewContent: json["review_content"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul_buku": judulBuku,
        "review_score": reviewScore,
        "review_content": reviewContent,
        "created_at": createdAt.toIso8601String(),
      };
}
