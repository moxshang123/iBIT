import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iBIT/HomePage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: Scaffold(
        body: Stack(
          children: [
            // Image at the top
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              height: 320, // Adjust the height as needed
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/loginimage.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Sign-up form
            Positioned(
              top: 320, // Adjust the top position as needed
              left: 0,
              right: 0,
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Sign in user with email and password
        UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        // Get the user details
        User? user = userCredential.user;
        if (user != null) {
          // User signed in successfully
          print('User signed in: ${user.email}');

          // Navigate back to the homepage
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          // User is null, authentication failed
          print('Authentication failed');
        }
      } catch (e) {
        // Handle sign in errors
        print('Error signing in: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 195.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                _email = value;
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
                _password = value;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
