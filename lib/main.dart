import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Splashscreen.dart'; // Import your splash screen layout

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await initializeFirebase();
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyC_OzNNclqlanE3eyoYaH3x04-N-huDQ58',
      appId: '1:1062606394855:android:d1638bd8961f23c9a99942',
      messagingSenderId: '1062606394855',
      projectId: 'ibit-2420b',
      authDomain: 'noreply@ibit-2420b.firebaseapp.com',
      databaseURL: 'YOUR_DATABASE_URL',
      storageBucket: 'YOUR_STORAGE_BUCKET',
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
