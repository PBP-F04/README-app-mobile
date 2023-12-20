// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/user_profile/models/category.dart';
import 'package:readme_mobile/user_profile/models/user.dart';

class EditUserProfile extends StatefulWidget {
  final Profile profile;
  const EditUserProfile({super.key, required this.profile});

  @override
  State<EditUserProfile> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<EditUserProfile> {
  late TextEditingController _profileImgController;
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  List<DropdownMenuItem<String>> _categoriesDropdown = [];
  String? _selectedFavorite;
  late Dio dio;

  @override
  void initState() {
    super.initState();
    initDio();

    // Make sure to check if widget.profile is not null before accessing its properties
    _profileImgController =
        TextEditingController(text: widget.profile.fields.profileImage);
    _usernameController =
        TextEditingController(text: widget.profile.fields.username);
    _nameController = TextEditingController(text: widget.profile.fields.name);
    _descriptionController =
        TextEditingController(text: widget.profile.fields.description);
    // Assuming that 'favoriteCategory' is an id and you have a way to convert it to a category name
  }

  void initDio() async {
    dio = await DioClient.dio;
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    var url = '/profile/get-categories/';
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> categoriesData = response.data;
        List<Categories> categories =
            categoriesData.map((data) => Categories.fromJson(data)).toList();

        setState(() {
          _categoriesDropdown = categories.map((category) {
            return DropdownMenuItem(
              value: category.categoryName,
              child: Text(category.categoryName),
            );
          }).toList();
        });
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Profile")),
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
                      'favorite_category':
                          _selectedFavorite, // Make sure this is the correct ID or name expected by your backend
                    });

                    Response response = await dio.post(
                      '/profile/edit-profile-flutter/',
                      data: formData,
                    );

                    if (response.statusCode == 200) {
                      print("sukses");
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: const Text(
                            'Berhasil update profile',
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.indigo,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ));
                      Navigator.pushReplacementNamed(context, '/user_profile');
                    }
                  } on DioException catch (e) {
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
              child: const Text("Update Profile")),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 171, 165),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"))
        ],
      ),
    );
  }
}
