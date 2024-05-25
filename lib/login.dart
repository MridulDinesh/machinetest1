import 'package:firebasefull/employee_list_page.dart';
import 'package:firebasefull/userlist.dart';
import 'package:firebasefull/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailAndPasswordSignIn extends StatefulWidget {
  const EmailAndPasswordSignIn({Key? key}) : super(key: key);

  @override
  State<EmailAndPasswordSignIn> createState() =>
      _EmailAndPasswordSignInState();
}

class _EmailAndPasswordSignInState extends State<EmailAndPasswordSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late SharedPreferences _prefs;
  late String _recentEmail;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _recentEmail = _prefs.getString('recent_email') ?? '';
    _emailController.text = _recentEmail;
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the email in shared preferences
      _prefs.setString('recent_email', email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployeeListPage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in Successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              onChanged: (value) {
                _recentEmail = value;
              },
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signIn(context),
              child: Text('Log In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmailAndPassword()));
              },
              child: Text('Don\'t Have An account?'),
            ),
          ],
        ),
      ),
    );
  }
}
