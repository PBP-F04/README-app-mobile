// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/katalog-buku/models/book_detail.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

class CreateReview extends StatefulWidget {
  final BookDetail book;
  const CreateReview({super.key, required this.book});

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final _formKey = GlobalKey<FormState>();
  int _selectedScore = 0;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin();
    });
  }

  void checkLogin() async {
    Response response;
    try {
      response = await dio.get('/protected');
      if (response.statusCode == 200) {
        print(response.data);
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    BookDetail book = widget.book;
    // final request = context.watch<CookieRequest>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Write your thoughts and review!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  Text(
                                    "${book.data.title}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                            decoration: InputDecoration(
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
                                  final response = await dio.post(
                                      "review/review-buku-flutter/${book.data.id}",
                                      data: {
                                        'review': _review,
                                        'score': _selectedScore,
                                      });

                                  if (response.statusCode == 200) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Produk baru berhasil disimpan!"),
                                    ));
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => ReviewBuku()),
                                    // );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("Terdapat kesalahan, silakan coba lagi."),
                                    ));
                                  }

                                  _formKey.currentState!.reset();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
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
      ),
    );
  }
}
