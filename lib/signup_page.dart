import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'main.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Signup",
                style: TextStyle(
                  color: Colors.black,
                  fontSize:28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: screenWidth * 0.45, child: TextField(
                    controller: firstName,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "First name",
                    ),
                  )),
                  SizedBox(width: screenWidth * 0.1),
                  SizedBox(width: screenWidth * 0.45, child: TextField(
                    controller: lastName,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "Last name",
                    ),
                  )),
                ],
              ),

              const SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: phoneNo,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: Icon(Icons.mail, color: Colors.black),

                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "User Email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black),

                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Re-enter Email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black),

                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "User Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: passwordController2,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Re-enter Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),

              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFF0069FE),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                          .then((value){
                            print("Successfully sign up user!");
                            print(value.user!.uid);
                            //var firebaseUser = FirebaseAuth.instance.currentUser;
                            FirebaseFirestore.instance.collection("user").doc(value.user!.uid).set(
                              {
                                "firstName" : firstName.text,
                                "lastname" : lastName.text,
                                "phoneNo" : phoneNo.text,
                              }
                            ).then((value) {
                                print("Successfully added user");
                            }).catchError((error) {
                                print("Failed to add user");
                                print(error);
                            });
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyApp()));
                      }).catchError((error){
                            print("Failed to sign up the user");
                            print(error.toString());
                      });

                  },
                  child: const Text("Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}