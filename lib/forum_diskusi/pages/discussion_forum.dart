import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readme_mobile/forum_diskusi/pages/create_discussion.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_comment.dart';
import 'dart:convert';

import '../../dio.dart';
import '../models/discussion.dart';

class DiscussionForumPage extends StatefulWidget {
  // final Book book; // from katalog

  const DiscussionForumPage({Key? key}) : super(key: key);

  @override
  _DiscussionForumPageState createState() => _DiscussionForumPageState();
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  // late Dio dio; //pastiin nambahin ini
  //
  // //tambahin ini di bawah code kalian
  // @override
  // void initState() {
  //   super.initState();
  //   initDio();
  // }
  //
  // void initDio() async {
  //   dio = await DioClient.dio;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     checkLogin();
  //   });
  // }
  //
  // void checkLogin() async {
  //   Response response;
  //   try {
  //     response = await dio.get('/protected');
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //     }
  //   } on DioException catch (e) {
  //     print(e.response!.data);
  //   }
  // }


  Future<List<Discussion>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    //"https://shanahan-danualif-tugas.pbp.cs.ui.ac.id/json/"
    var url = Uri.parse('http://127.0.0.1:8000/discussions/json-discussions/'); //belom filter masih localhost
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Discussion> list_discussion = [];
    for (var d in data) {
      if (d != null) {
        list_discussion.add(Discussion.fromJson(d));
      }
    }
    return list_discussion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Discussion'),
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {

              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data Discussion.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                            // MaterialPageRoute(
                              // builder: (context) => DiscussionForumFormPage(FormPage(discussion: widget.discussion),
                            // ),
                          // );
                        },
                        child: Text('Add Discussion'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.content}"),
                                const SizedBox(height: 10),
                                // const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentPage(
                                            discussion: snapshot.data![index]),
                                      ),
                                    );
                                  },
                                  child: const Text('Detail Discussion'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            }));
  }
}
