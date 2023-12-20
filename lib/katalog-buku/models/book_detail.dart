// To parse this JSON data, do
//
//     final bookDetail = bookDetailFromJson(jsonString);

import 'dart:convert';

BookDetail bookDetailFromJson(String str) =>
    BookDetail.fromJson(json.decode(str));

String bookDetailToJson(BookDetail data) => json.encode(data.toJson());

class BookDetail {
  int status;
  String message;
  Data data;

  BookDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String issued;
  String bookCode;
  String title;
  String author;
  String bookReadUrl;
  String subject;
  String synopsis;
  String category;

  Data({
    required this.id,
    required this.issued,
    required this.bookCode,
    required this.title,
    required this.author,
    required this.bookReadUrl,
    required this.subject,
    required this.synopsis,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        issued: json["issued"],
        bookCode: json["book_code"],
        title: json["title"],
        author: json["author"],
        bookReadUrl: json["book_read_url"],
        subject: json["subject"],
        synopsis: json["synopsis"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "issued": issued,
        "book_code": bookCode,
        "title": title,
        "author": author,
        "book_read_url": bookReadUrl,
        "subject": subject,
        "synopsis": synopsis,
        "category": category,
      };
}
