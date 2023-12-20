import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/user_profile/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool _isLoading = false;
  String? _errorMessage;
  String? _email;
  String? _password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late Dio dio;

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
        // print(response.data);
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        // print(e.response!.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                            child: Text(
                          'readme.app',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/icon/main.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                  hintText: 'your@mail.com',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                              onChanged: (String? value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }

                                if (!value.contains('@')) {
                                  return 'Please enter valid email';
                                }

                                if (_errorMessage != null) {
                                  if (_errorMessage!.contains('Email')) {
                                    return _errorMessage;
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                              onChanged: ((String? value) {
                                setState(() {
                                  _password = value;
                                });
                              }),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }

                                if (_errorMessage != null) {
                                  return _errorMessage;
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      color: _isLoading
                                          ? Theme.of(context)
                                              .colorScheme
                                              .outline
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ElevatedButton(
                                        onPressed: _isLoading
                                            ? null
                                            : () async {
                                                setState(() {
                                                  _errorMessage = null;
                                                });
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });

                                                  Response response;
                                                  try {
                                                    response = await dio
                                                        .post('/login/', data: {
                                                      'email': _email,
                                                      'password': _password,
                                                    });
                                                    if (response.statusCode ==
                                                        200) {
                                                      Map<String, dynamic>
                                                          responseData =
                                                          response.data;
                                                      emailUser = _email!;

                                                      bool existingProfile =
                                                          responseData[
                                                                  'exist'] ??
                                                              false;
                                                      _scaffoldKey.currentState!
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                          'Welcome, you are logged in',
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        backgroundColor:
                                                            Colors.indigo,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ));
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2), () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            existingProfile
                                                                ? '/user_profile'
                                                                : '/create_profile');
                                                      });
                                                    }
                                                  } on DioException catch (e) {
                                                    if (e.response!
                                                            .statusCode ==
                                                        400) {
                                                      setState(() {
                                                        _errorMessage =
                                                            'Email or password is incorrect';
                                                      });
                                                      _formKey.currentState!
                                                          .validate();

                                                      _emailController.clear();
                                                      _passwordController
                                                          .clear();
                                                    }
                                                  }
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                }
                                              },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.2);
                                            }
                                            return Colors.transparent;
                                          }),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ))
                                            : const Text(
                                                'Login',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                  )))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Dont have your account?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.transparent,
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).colorScheme.onPrimary,
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
                                    'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )))
                  ],
                ),
              ),
            )));
  }
}
