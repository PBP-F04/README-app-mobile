import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/user_profile/models/user.dart';
import 'package:readme_mobile/user_profile/screens/edit_form.dart';
import 'package:shimmer/shimmer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Dio dio;
  Profile? _profile;
  Map<String, String>? _categoriesMap;

  @override
  void initState() {
    super.initState();
    initDio();
  }

  void initDio() async {
    dio = await DioClient.dio;
    fetchProfile();
    fetchCategories();
  }

  Future<Profile?> fetchProfile() async {
    var url = '/profile/show-profile';
    Response response;
    Profile? profile;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _profile = Profile.fromJson(response.data);
          });
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {}
    }
    return profile;
  }

  void fetchCategories() async {
    var url = '/profile/get-categories/';
    Map<String, String> tempCategoriesMap = {};
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> categoriesData = response.data;
        for (var data in categoriesData) {
          String id = data['id'].toString(); // Make sure the ID is a string
          String categoryName = data['category_name'];
          tempCategoriesMap[id] = categoryName;
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
    }
    if (mounted) {
      setState(() {
        _categoriesMap = tempCategoriesMap;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null || _categoriesMap == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Theme.of(context).colorScheme.primary,
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "uniqueTag3",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditUserProfile(
                  profile: _profile!,
                ),
              ),
            );
          },
          elevation: 0,
          backgroundColor: Colors.blue,
          label: const Text("Edit Profile"),
          icon: const Icon(Icons.edit),
        ),
        body: buildUserProfile(_profile!, context, _categoriesMap!),
      );
    }
  }
}

Widget buildUserProfile(
    Profile profile, BuildContext context, Map<String, String> categoriesMap) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: _TopPortion(profileData: profile),
      ),
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "@${profile.fields.username}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                profile.fields.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: "uniqueTag1",
                    onPressed: () {},
                    elevation: 0,
                    label: const Text("My Books"),
                    icon: const Icon(Icons.book),
                  ),
                  const SizedBox(width: 16.0),
                  FloatingActionButton.extended(
                    heroTag: "uniqueTag2",
                    onPressed: () {},
                    elevation: 0,
                    label: const Text("See My Reviews"),
                    icon: const Icon(Icons.chat),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoriesMap[
                              profile.fields.favoriteCategory.toString()] ??
                          'Unknown Category',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Favorite Category",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [Text(profile.fields.description)],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

class _TopPortion extends StatelessWidget {
  final Profile? profileData;
  const _TopPortion({Key? key, this.profileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: profileData != null
              ? SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: profileData!.fields.profileImage,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        )
      ],
    );
  }
}
