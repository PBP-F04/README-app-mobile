import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/katalog-buku/pages/details.dart';
import 'package:shimmer/shimmer.dart';

class BookCard extends StatelessWidget {
  final String bookId;
  final String title;
  final String author;
  final String category;
  final String subject;
  final String bookCode;
  final bool isLogin;
  final bool isCreatedProfile;

  const BookCard(
      {super.key,
      required this.bookId,
      required this.title,
      required this.author,
      required this.category,
      required this.subject,
      required this.bookCode,
      required this.isLogin,
      required this.isCreatedProfile});

  @override
  Widget build(BuildContext context) {
    String? url =
        "https://readme-app-production.up.railway.app/static/images/books/$bookCode.webp";
    return Card(
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: SizedBox(
                  height: 2 *
                      16.0 *
                      1.5, // Assuming that the line height is 1.2 times the font size
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[700]),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[700]),
                  )),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 150,
                      height: 40,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            onPressed: !isLogin
                                ? () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  }
                                : !isCreatedProfile
                                    ? () {
                                        Navigator.pushReplacementNamed(
                                            context, '/create_profile');
                                      }
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookDetailPage(
                                                      bookId: bookId,
                                                      bookCode: bookCode,
                                                    )));
                                      },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.onPrimary,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              overlayColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2);
                                }
                                return Colors.transparent;
                              }),
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
