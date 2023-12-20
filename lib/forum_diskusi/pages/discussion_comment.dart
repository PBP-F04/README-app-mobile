import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:readme_mobile/forum_diskusi/models/discussion.dart';

import 'package:readme_mobile/forum_diskusi/widgets/create_comment.dart';

import 'dart:convert';

import '../models/comments.dart';

// import 'detail_item.dart';

class CommentPage extends StatefulWidget {
  final Discussion discussion;

  const CommentPage({Key? key, required this.discussion}) : super(key: key); // tes

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Future<List<Comment>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!

    var url = Uri.parse(
        // 'http://127.0.0.1:8000/discussions/json-comments/${widget.discussion.pk}');
        'https://readme-app-production.up.railway.app/discussions/json-comments/${widget.discussion.pk}');
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
        list_comment.add(Comment.fromJson(d));
      }

    }
    return list_comment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comment'),
        ),
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
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${widget.discussion.fields.title}',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentFormPage(discussion: widget.discussion),
                            ),
                          );
                        },
                        child: Text('Add New Comment'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100], //
                              borderRadius: BorderRadius.circular(10.0), //
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "by: ${snapshot.data![index].fields.username}",
                                  style: const TextStyle(
                                    // fontSize: 18.0,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.indigo, // Replace with your desired color
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.content}"),
                                const SizedBox(height: 10),
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