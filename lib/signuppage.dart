import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sediment_features/loginpage.dart';

void main() {
  runApp(SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      home: Scaffold(
        body: Column(
          children: [
            // Image at the top
            Container(
              height: 320, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login-icon.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Sign-up form
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';

  final AuthService _authService = AuthService(); // Instance of AuthService

  void signUp() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call signUpAndStoreUserData method from AuthService
      _authService.signUpAndStoreUserData(_email, _password, _fullName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
              onSaved: (value) {
                _fullName = value ?? '';
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                // You can add email validation here if needed
                return null;
              },
              onSaved: (value) {
                _email = value ?? '';
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                // You can add password strength validation here if needed
                return null;
              },
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Already have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpAndStoreUserData(String email, String password, String fullName) async {
    try {
      // Step 1: Create user account using email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Step 2: Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'fullName': fullName,
        // Add other user details here
      });

      // Success: User signed up and data stored successfully
      print('User signed up and data stored successfully');
    } catch (e) {
      // Handle sign up or data storage errors
      print('Error signing up user and storing data: $e');
      throw e; // Re-throw the error for handling in UI if needed
    }
  }
}
