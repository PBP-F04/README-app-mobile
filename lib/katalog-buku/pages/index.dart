import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/katalog-buku/models/book.dart';
import 'package:readme_mobile/katalog-buku/widgets/book_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Dio dio;
  final _scrollController = ScrollController();

  Book? _bookList;
  int _page = 1;
  int _maxPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initDio();
    _scrollController.addListener(_onScroll);
  }

  void initDio() async {
    dio = await DioClient.dio;
    fetchBook();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchBook();
    }
  }

  void fetchBook() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      Response response;
      try {
        if (_page > _maxPage) return;
        response = await dio.get('/books', queryParameters: {
          "page": _page,
        });
        setState(() {
          if (_bookList == null) {
            _bookList = Book.fromJson(response.data);
          } else {
            _bookList!.data.addAll(Book.fromJson(response.data).data);
          }
          _isLoading = false;
          _maxPage = _bookList!.pagination.totalPage;
          _page++;
        });
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _bookList == null
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: _scrollController,
                    itemCount: _isLoading
                        ? _bookList!.data.length + 1
                        : _bookList!.data.length,
// Add 1 for the loading indicator
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 9 / 16, // Adjust this value as needed
                    ),
                    itemBuilder: ((context, index) {
                      if (index < _bookList!.data.length) {
                        return BookCard(
                          bookId: _bookList?.data[index].id ?? "",
                          title: _bookList?.data[index].title ?? "",
                          author: _bookList?.data[index].author ?? "",
                          category:
                              _bookList?.data[index].categoryCategoryName ?? "",
                          subject: _bookList?.data[index].subject ?? "",
                          bookCode: _bookList?.data[index].bookCode ?? "",
                        );
                      } else {
                        return const SizedBox();
// Loading indicator
                      }
                    }),
                  ),
          ),
        ));
  }
}
