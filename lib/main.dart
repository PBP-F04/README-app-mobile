import 'package:flutter/material.dart';
import 'package:readme_mobile/authentication/pages/login.dart';
import 'package:readme_mobile/authentication/pages/register.dart';
import 'package:readme_mobile/user_profile/screens/form.dart';
import 'package:readme_mobile/user_profile/screens/profile.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/create_profile': (context) => const CreateUserProfile(),
        '/user_profile': (context) => const UserProfile(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
    );
  }
}
