import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Password Reset",
                style: TextStyle(
                  color: Colors.black,
                  fontSize:28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 26.0,
              ),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "User Email",
                  errorText: 'User Email Can\'t Be Empty',
                  prefixIcon: Icon(Icons.mail, color: Colors.black),
                ),

              ),

              ElevatedButton(style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30)),
                  onPressed: (){
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController.text).then((value) {
                    print("Successfully updated product");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen(title: 'Login page')));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Password email send'),
                        action: SnackBarAction(
                          label: 'Action',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ),
                    );
                    }).catchError((error) {
                      print("Failed to updated product");
                      print(error);
                    });

                  },
                  child: const Text('Reset Password')
              ),

              ]
        ),
      ),
    );
  }

  Future verifyEmail() async{
    //showDialog(context: context,
    //    barrierDismissible: false,
     //   builder: (context) => Center(child: CircularProgressIndicator())
    //);

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password email send')));

    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      Navigator.of(context).pop();
    }
  }
}