import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readme_mobile/forum_diskusi/models/discussion.dart';
import 'dart:convert';

// import 'package:hanshop/models/item.dart';
// import 'package:hanshop/widgets/left_drawer.dart';

import '../models/comments.dart';

// import 'detail_item.dart';

class CommentPage extends StatefulWidget {
  // final Discussion discussion;

  const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Future<List<Comment>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    //"https://shanahan-danualif-tugas.pbp.cs.ui.ac.id/json/"
    var url = Uri.parse(
        'http://127.0.0.1:8000/discussions/json-comments/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Comment> list_comment = [];
    for (var d in data) {
      if (d != null) {
        // list_comment.add(Comment(model: model, pk: pk, fields: fields).fromJson(d));
      }
      list_comment.add(Comment.fromJson(d));
    }
    return list_comment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comment'),
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
                        "Tidak ada data Comment.",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}.${snapshot.data![index].fields.name}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.amount}"),
                            const SizedBox(height: 10),
                            Text(
                                "${snapshot.data![index].fields.description}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.price}"),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => DetailDiscussionPage(discussion: snapshot.data![index]),
                            //       ),
                            //     );
                            //   },
                            //   child: const Text('Detail Comment'),
                            // ),
                          ],
                        ),
                      ));
                }
              }
            }));
  }
}