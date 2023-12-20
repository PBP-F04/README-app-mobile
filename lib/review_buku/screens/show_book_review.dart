import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readme_mobile/forum_diskusi/widgets/create_discussion.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_comment.dart';
import 'package:readme_mobile/user_profile/models/user.dart';
import 'dart:convert';

import '../../dio.dart';
import '../../katalog-buku/models/book.dart';
import '../models/bookreview.dart';

class ReviewFromBook extends StatefulWidget {
  final String bookId;

  const ReviewFromBook({super.key, required this.bookId});

  @override
  _ReviewFromBookState createState() => _ReviewFromBookState();
}

class _ReviewFromBookState extends State<ReviewFromBook> {
  late Future<List<BookReview>> _reviews;
  late Dio dio;
  Future<Profile>? userProfile;

  void initDio() async {
    dio = await DioClient.dio;
  }

  @override
  void initState() {
    super.initState();
    initDio();
    _reviews = fetchReviews();
  }

  Future<List<BookReview>> fetchReviews() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    //"https://shanahan-danualif-tugas.pbp.cs.ui.ac.id/json/"
    // var url = Uri.parse('http://127.0.0.1:8000/discussions/json-discussions/'); //belom filter masih localhost
    
    
    //TODO TOLONG HAEKAL KALIPAKSI DICEK YAAAAAAAA
    var url = Uri.parse(
        'https://readme-app-production.up.railway.app/review/get-review-book-json/${widget.bookId}/'); 
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<BookReview> list_review = [];
    for (var d in data) {
      if (d != null) {
        list_review.add(BookReview.fromJson(d));
      }
    }
    return list_review;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for this Book'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<BookReview>>(
        future: _reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final review = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(review.fields.user),
                    subtitle: Text('Rating: ${review.fields.reviewScore}\nReview: ${review.fields.reviewContent}'),
                    trailing: Text('${review.fields.createdAt.toLocal()}'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No reviews found'));
          }
        },
      ),
    );
  }
}