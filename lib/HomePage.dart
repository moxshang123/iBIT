import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iBIT/Details_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iBIT/uploadimage.dart';

// Import the SplashScreen widget
import 'SplashScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  late Future<void> _initialization;

  // Initializing firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Intializing firestore instance

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    _initialization = Firebase.initializeApp();
    await _initialization;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a splash screen while initializing Firebase
          return SplashScreen();
        } else {
          return _buildHomePage();
        }
      },
    );
  }

  Widget _buildHomePage() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.purple[800],
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Transform.translate(
                offset: Offset(0.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'iBIT',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Details_collection(),
            ),

            SizedBox(height: 8,),
            Expanded(
              child: UploadImage(),
            ),
          ],
        ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

