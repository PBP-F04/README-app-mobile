import 'package:flutter/material.dart';
import 'package:readme_mobile/review_buku/screens/create_review.dart';
import '../../dio.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const BorrowHistoryPage());
}

class BorrowHistoryPage extends StatefulWidget {
  const BorrowHistoryPage({Key? key}) : super(key: key);

  @override
  State<BorrowHistoryPage> createState() => _BorrowHistoryPageState();
}

class _BorrowHistoryPageState extends State<BorrowHistoryPage> {
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
      response = await dio.get('/read-book/');
      if (response.statusCode == 200) {
        print(response.data);
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: const Text(
          'Borrow History',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: BookList(),
    ));
  }
}

class BookList extends StatelessWidget {
  // Sample data for the list
  final List<BookData> books = [
    BookData(
      title: 'Madilog',
      subtitle: 'Madilog Tan Malaka : Materialisme Dialektika dan Logika.',
      imageUrl:
          'images/9789791683319_Madilog-Tan-Malaka-Materialisme-Dialektika--Logika.jpg',
    ),
    // Add more books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return CardExample(book: books[index]);
      },
    );
  }
}

class CardExample extends StatelessWidget {
  final BookData book;

  const CardExample({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.asset(book.imageUrl),
              title: Text(book.title),
              subtitle: Text(book.subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Review'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateReview(
                          book: null,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookData {
  final String title;
  final String subtitle;
  final String imageUrl;

  const BookData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
