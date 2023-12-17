import 'package:flutter/material.dart';
import 'package:readme_mobile/authentication/pages/login.dart';
import 'package:readme_mobile/authentication/pages/register.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_comment.dart';
import 'package:readme_mobile/forum_diskusi/pages/discussion_forum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'README',
      initialRoute: '/discussion-forum',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/discussion-forum' : (context) => const DiscussionForumPage(),
        // '/discussion-comment' : (context) => const CommentPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
    );
  }
}
