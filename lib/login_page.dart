import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'passwordResetPage.dart';
import 'features_page.dart';
import 'signup_page.dart';
//import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e){
      if(e.code == "user-not-found"){
        print("No user found for that email");
      }
    }

    return user;
  }

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Owner Buddy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Owner Buddy',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User Email",
                //errorText: 'User Email Can\'t Be Empty',
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "User Password",
                //errorText: 'User Password Can\'t Be Empty',
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              child: Text(
                'Don\'t Remember your Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  fontSize: 15,
                ),
              ),
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  )),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                      email: usernameController.text,
                      password: passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FeaturesPage()));
                  }
                },
                child: Text("Login")
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text("If you do not have account please signup",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignupScreen()));
                },
                child: Text("Signup")
            ),
          ],
        ),
      ),
    );
  }
}