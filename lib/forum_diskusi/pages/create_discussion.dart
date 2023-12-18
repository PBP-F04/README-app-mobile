import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:hanshop/widgets/left_drawer.dart';
// import 'package:hanshop/screens/item_list.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:readme_mobile/forum_diskusi/models/discussion.dart';

import '../../dio.dart';

// import 'menu.dart';

final List<Discussion> itemList = [];

class DiscussionForumFormPage extends StatefulWidget {
  const DiscussionForumFormPage({super.key});

  @override
  State<DiscussionForumFormPage> createState() => _DiscussionForumFormPageState();
}

class _DiscussionForumFormPageState extends State<DiscussionForumFormPage> {
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
                          backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Kirim ke Django dan tunggu respons
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            final response = await dio.post(
                              // pass book id
                                "discussions/create-discussion-flutter/<str:book_id>", // nanti butuh string
                                //"https://shanahan-danualif-tugas.pbp.cs.ui.ac.id/create-item-flutter/"
                                data:{
                                  'title': _title,
                                  'content': _content,
                                });
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Produk baru berhasil disimpan!"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => DiscussionForumFormPage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                              ));
                            }
                          }
                          // _formKey.currentState!.reset();
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

