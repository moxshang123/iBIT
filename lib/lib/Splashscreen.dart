import 'package:flutter/material.dart';
import 'HomePage.dart'; // Import your home page widget

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Close splash screen and navigate to home page after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Adjust the path according to your logo file
          width: 200, // Adjust the width according to your logo size
          height: 200, // Adjust the height according to your logo size
        ),
      ),
    );
  }
}
