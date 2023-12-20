import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:readme_mobile/forum_diskusi/models/comments.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_comment.dart';

import '../../dio.dart';
import '../models/discussion.dart';

// import 'menu.dart';

final List<Comment> itemList = [];

class CommentFormPage extends StatefulWidget {
  final Discussion discussion;

  const CommentFormPage({Key? key, required this.discussion}) : super(key: key);

  @override
  State<CommentFormPage> createState() => _CommentFormPageState();
}

class _CommentFormPageState extends State<CommentFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  // int _amount = 0;
  // int _price = 0;
  String _content = "";

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
    // dari pbp django auth?
    // final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Item',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini done
      // drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Judul Komen",
                labelText: "Judul Komen",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _title = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Judul tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Content",
                labelText: "Content",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  // TODO: Tambahkan variabel yang sesuai
                  _content = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Content tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       hintText: "Harga",
          //       labelText: "Harga",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //       ),
          //     ),
          //     // TODO: Tambahkan variabel yang sesuai
          //     onChanged: (String? value) {
          //       setState(() {
          //         _price = int.parse(value!);
          //       });
          //     },
          //     validator: (String? value) {
          //       if (value == null || value.isEmpty) {
          //         return "Harga tidak boleh kosong!";
          //       }
          //       if (int.tryParse(value) == null) {
          //         return "Harga harus berupa angka!";
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons
                    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                    Response response;
                    response = await dio.post(
                        "/discussions/create-comment-flutter/${widget.discussion.pk}",
                        data: {
                          'title': _title,
                          'content': _content,
                        });
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Komen baru berhasil dibuat!"),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CommentPage(discussion: widget.discussion)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Terdapat kesalahan, silakan coba lagi."),
                      ));
                    }
                  }
                  _formKey.currentState!.reset();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
