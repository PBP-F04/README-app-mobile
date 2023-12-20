import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:readme_mobile/forum_diskusi/models/discussion.dart';

import '../../dio.dart';
import '../pages/discussion_forum.dart';

// import 'menu.dart';

final List<Discussion> itemList = [];

class DiscussionForumFormPage extends StatefulWidget {
  final String bookId;

  // const DiscussionForumFormPage({super.key});
  const DiscussionForumFormPage({Key? key, required this.bookId})
      : super(key: key);

  @override
  State<DiscussionForumFormPage> createState() => _DiscussionForumFormPageState();
}

class _DiscussionForumFormPageState extends State<DiscussionForumFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Form Create Discussion',
          ),
        ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini done
      // drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Judul Diskusi",
                        labelText: "Judul Diskusi",
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Kirim ke Django dan tunggu respons
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            final response = await dio.post(
                              // pass book id
                                "/discussions/create-discussion-flutter/${widget.bookId}", // nanti butuh string
                                data:{
                                  'title': _title,
                                  'content': _content,
                                });
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Diskusi berhasil disimpan!"),
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DiscussionForumPage(bookId: widget.bookId)),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
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
                ]
            )
        ),
      ),
    );
  }
}

