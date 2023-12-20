import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/user_profile/models/category.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});

  @override
  State<CreateUserProfile> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<CreateUserProfile> {
  List<DropdownMenuItem<String>> _categoriesDropdown = [];
  String? _selectedFavorite;
  late Dio dio;

  @override
  void initState() {
    super.initState();
    initDio();
  }

  void initDio() async {
    dio = await DioClient.dio;
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      Response response = await dio.get('/profile/get-categories/');
      if (response.statusCode == 200) {
        List<dynamic> categoriesData = response.data;
        List<Categories> categories =
            categoriesData.map((data) => Categories.fromJson(data)).toList();
        if (mounted) {
          setState(() {
            _categoriesDropdown = categories.map((category) {
              return DropdownMenuItem(
                value: category.categoryName,
                child: Text(category.categoryName),
              );
            }).toList();
          });
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e.message);
      }
    }
  }

  final TextEditingController _profileImgController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  SizedBox(
                    height: 82,
                    child: TextFormField(
                      controller: _profileImgController,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFFF7F8F9),
                        filled: true,
                        prefixIcon: Icon(Icons.image),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDADADA)),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        labelText: "Profile Image",
                        labelStyle: TextStyle(color: Color(0xFF8391A1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 82,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFFF7F8F9),
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDADADA)),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Color(0xFF8391A1)),
                      ),
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 82,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFFF7F8F9),
                        filled: true,
                        prefixIcon: Icon(Icons.sentiment_satisfied_alt),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDADADA)),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(color: Color(0xFF8391A1)),
                      ),
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 82,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFFF7F8F9),
                        filled: true,
                        prefixIcon: Icon(Icons.description),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDADADA)),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        labelText: "Description",
                        labelStyle: TextStyle(color: Color(0xFF8391A1)),
                      ),
                      obscureText: false,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedFavorite,
                    items: _categoriesDropdown,
                    decoration: InputDecoration(
                      hintText: "Favorite Category",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.indigo,
                    ),
                    dropdownColor: Colors.indigo,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFavorite = newValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Pilih buku!";
                      }
                      return null;
                    },
                    icon: Container(),
                    isExpanded: true,
                    itemHeight: 60,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    var formData = FormData.fromMap({
                      'profile_image': _profileImgController.text,
                      'username': _usernameController.text,
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'favorite_category': _selectedFavorite,
                    });

                    Response response = await dio.post(
                      '/profile/create-profile-flutter/',
                      data: formData,
                    );
                    if (response.statusCode == 200) {
                      print("sukses");
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: const Text(
                            'Berhasil membuat profile',
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.indigo,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ));
                      Navigator.pushNamed(context, '/user_profile');
                    }
                  } on DioException catch (e) {
                    print(e.response!.data);
                    if (e.response!.statusCode == 400) {
                      _formKey.currentState!.validate();

                      _profileImgController.clear();
                      _usernameController.clear();
                      _nameController.clear();
                      _descriptionController.clear();
                    }
                  }
                }
              },
              child: const Text("Create Profile")),
        ],
      ),
    );
  }
}
