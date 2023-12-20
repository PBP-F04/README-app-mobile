import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readme_mobile/forum_diskusi/widgets/create_discussion.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_comment.dart';
import 'dart:convert';

import '../../dio.dart';
import '../../katalog-buku/models/book.dart';
import '../models/discussion.dart';

class DiscussionForumPage extends StatefulWidget {
  // final Book book; // from katalog
  final String bookId;

  // const DiscussionForumPage({Key? key}) : super(key: key);
  const DiscussionForumPage({Key? key, required this.bookId})
      : super(key: key);

  @override
  _DiscussionForumPageState createState() => _DiscussionForumPageState();
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  

  Future<List<Discussion>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    //"https://shanahan-danualif-tugas.pbp.cs.ui.ac.id/json/"
    // var url = Uri.parse('http://127.0.0.1:8000/discussions/json-discussions/'); //belom filter masih localhost
    var url = Uri.parse(
        'https://readme-app-production.up.railway.app/discussions/json-discussions/${widget.bookId}');
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
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                          builder: (context) => DiscussionForumFormPage(bookId: widget.bookId),
                          ),
                          );
                        },
                        child: Text('Add New Discussion'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(20.0),
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
                                const SizedBox(height: 3),
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text("${snapshot.data![index].fields.content}",
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),),
                                const SizedBox(height: 3),
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
                                  // style
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.indigo,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.2);
                                      }
                                      return Colors.transparent;
                                    }),
                                  ),
                                  child: const Text(
                                    'See Discussion Comments',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
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
