import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readme_mobile/dio.dart';
import 'package:readme_mobile/user_profile/models/user.dart';
import 'package:readme_mobile/user_profile/screens/edit_form.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Dio dio;
  Future<Profile>? userProfile;
  Map<String, String> categoriesMap = {};

  @override
  void initState() {
    super.initState();
    initDio();
    userProfile = fetchProfile();
  }

  void initDio() async {
    dio = await DioClient.dio;
  }

  Future<Profile> fetchProfile() async {
    var url = 'https://readme-app-production.up.railway.app/profile/show-profile/$emailUser';
    Response response = await Dio().get(url);
    List<dynamic> profileData = response.data;
    List<Profile> profile =
        profileData.map((data) => Profile.fromJson(data)).toList();
    return profile[0];
  }

  Future<Map<String, String>> fetchCategories() async {
    var url = 'https://readme-app-production.up.railway.app/profile/get-categories/';
    Map<String, String> tempCategoriesMap = {};
    try {
      Response response = await Dio().get(url);
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
        print(e.response!.data);
      } else {
        print(e.message);
      }
    }
    return tempCategoriesMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "uniqueTag3",
        onPressed: () {
          if (userProfile != null) {
            userProfile!.then((profileData) {
              // Navigate to the edit page with the current profile data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserProfile(profile: profileData),
                ),
              );
            }).catchError((error) {
              // Handle any errors here
              print('Error fetching profile: $error');
            });
          }
        },
        elevation: 0,
        backgroundColor: Colors.blue,
        label: const Text("Edit Profile"),
        icon: const Icon(Icons.edit),
      ),
      body: FutureBuilder<Profile>(
        future: userProfile,
        builder: (context, profileSnapshot) {
          return FutureBuilder<Map<String, String>>(
            future: fetchCategories(),
            builder: (context, categoriesSnapshot) {
              if (profileSnapshot.connectionState == ConnectionState.done &&
                  categoriesSnapshot.connectionState == ConnectionState.done) {
                if (profileSnapshot.hasData && categoriesSnapshot.hasData) {
                  categoriesMap = categoriesSnapshot.data!;
                  return buildUserProfile(profileSnapshot.data!, context);
                } else if (profileSnapshot.hasError ||
                    categoriesSnapshot.hasError) {
                  return Text(
                      'Error: ${profileSnapshot.error ?? categoriesSnapshot.error}');
                }
              }
              // By default, show a loading spinner
              return const CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }

  Widget buildUserProfile(Profile profile, BuildContext context) {
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
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(profileData!.fields.profileImage)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
