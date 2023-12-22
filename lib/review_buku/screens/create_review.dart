// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/katalog-buku/models/book_detail.dart';

class CreateReview extends StatefulWidget {
  final BookDetail book;
  const CreateReview({super.key, required this.book});

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final _formKey = GlobalKey<FormState>();
  int _selectedScore = 1;
  String _review = "";

  late Dio dio; //pastiin nambahin ini

  //tambahin ini di bawah code kalian
  @override
  void initState() {
    super.initState();
    initDio();
  }

  void initDio() async {
    dio = await DioClient.dio;
  }

  @override
  Widget build(BuildContext context) {
    BookDetail book = widget.book;
    // final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Review"),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          top: 15,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Write your thoughts and review!",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        book.data.title,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://readme-app-production.up.railway.app/static/images/books/${book.data.bookCode}.webp",
                                    width: 110,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            DropdownButtonFormField<int>(
                              decoration: const InputDecoration(
                                labelText: "Score",
                                hintText: "Select a score",
                              ),
                              value: _selectedScore,
                              items: List<DropdownMenuItem<int>>.generate(
                                5,
                                (int index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text("${index + 1}"),
                                ),
                              ),
                              onChanged: (int? newValue) {
                                setState(() {
                                  _selectedScore = newValue!;
                                });
                              },
                              validator: (int? value) {
                                if (value == null) {
                                  return "Required!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              minLines: 4,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "What's your opinion?",
                                labelText: "Content",
                                prefixIcon: null,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _review = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Required!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width - 2 * 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Response response;
                                    try {
                                      response = await dio.post(
                                          "/review/review-buku-flutter/",
                                          data: {
                                            'book_id': book.data.id,
                                            'review': _review,
                                            'score': _selectedScore,
                                          });
                                      if (response.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text("Sukses!"),
                                          duration: const Duration(seconds: 2),
                                          backgroundColor: Colors.indigo,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ));

                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    } on DioException catch (e) {
                                      print(e.response!.data);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            "Terdapat kesalahan, silakan coba lagi."),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: Colors.indigo,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ));
                                    }
                                  }

                                  _formKey.currentState!.reset();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: const Text(
                                  "Add Review",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
