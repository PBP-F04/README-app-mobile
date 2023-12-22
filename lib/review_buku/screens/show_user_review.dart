import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/review_buku/models/userbookreview.dart';

class ReviewFromUser extends StatefulWidget {
  const ReviewFromUser({
    super.key,
  });

  @override
  State<ReviewFromUser> createState() => _ReviewFromUserState();
}

class _ReviewFromUserState extends State<ReviewFromUser> {
  BookReviewUser? _reviews;
  late Dio dio;
  bool _isLoading = false;

  void initDio() async {
    dio = await DioClient.dio;
    fetchReviews();
  }

  @override
  void initState() {
    super.initState();
    initDio();
  }

  void fetchReviews() async {
    if (!_isLoading) {
      try {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
        Response response =
            await dio.post('/review/show_page_review_user_ajax/');
        if (response.statusCode == 200) {
          if (mounted) {
            setState(() {
              _reviews = BookReviewUser.fromJson(response.data);
              _isLoading = false;
            });
          }
        }
      } on DioException catch (e) {
        if (e.response!.statusCode == 400) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reviews for this user'),
          centerTitle: true,
        ),
        body: _isLoading || _reviews == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _reviews!.reviews.isEmpty
                ? const Center(
                    child: Text('No reviews yet'),
                  )
                : ListView.builder(
                    itemCount: _reviews!.reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews!.reviews[index];
                      return Card(
                        child: ListTile(
                          title: Text(review.judulBuku),
                          subtitle: Text(
                              'Rating: ${review.reviewScore}\nReview: ${review.reviewContent}'),
                          trailing: Text('${review.createdAt.toLocal()}'),
                        ),
                      );
                    },
                  ));
  }
}
