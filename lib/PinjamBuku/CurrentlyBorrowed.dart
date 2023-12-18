import 'package:flutter/material.dart';

void main() {
  runApp(const CurrentlyBorrowed());
}

class CurrentlyBorrowed extends StatelessWidget {
  const CurrentlyBorrowed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: const Text(
          'Currently Borrowed',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
    ));
  }
}
