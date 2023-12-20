// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  int status;
  String message;
  List<Datum> data;
  Pagination pagination;

  Book({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Datum {
  String id;
  DateTime issued;
  String bookCode;
  String title;
  String author;
  String bookReadUrl;
  String subject;
  String synopsis;
  String categoryCategoryName;

  Datum({
    required this.id,
    required this.issued,
    required this.bookCode,
    required this.title,
    required this.author,
    required this.bookReadUrl,
    required this.subject,
    required this.synopsis,
    required this.categoryCategoryName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        issued: DateTime.parse(json["issued"]),
        bookCode: json["book_code"],
        title: json["title"],
        author: json["author"],
        bookReadUrl: json["book_read_url"],
        subject: json["subject"],
        synopsis: json["synopsis"],
        categoryCategoryName: json["category__category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "issued":
            "${issued.year.toString().padLeft(4, '0')}-${issued.month.toString().padLeft(2, '0')}-${issued.day.toString().padLeft(2, '0')}",
        "book_code": bookCode,
        "title": title,
        "author": author,
        "book_read_url": bookReadUrl,
        "subject": subject,
        "synopsis": synopsis,
        "category__category_name": categoryCategoryName,
      };
}

class Pagination {
  int currentPage;
  int totalPage;
  bool hasPrevious;
  bool hasNext;

  Pagination({
    required this.currentPage,
    required this.totalPage,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        totalPage: json["total_page"],
        hasPrevious: json["has_previous"],
        hasNext: json["has_next"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_page": totalPage,
        "has_previous": hasPrevious,
        "has_next": hasNext,
      };
}
