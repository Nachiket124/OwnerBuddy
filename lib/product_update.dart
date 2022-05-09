import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class productUpdatePage extends StatefulWidget {
  const productUpdatePage({Key? key}) : super(key: key);

  @override
  _productUpdatePageState createState() => _productUpdatePageState();
}

class _productUpdatePageState extends State<productUpdatePage> {

  TextEditingController updateController = TextEditingController();
  TextEditingController upcController = TextEditingController();
  TextEditingController deleteController = TextEditingController();
  // Initial Selected Value
  String dropdownValue = 'productName';
  var updateProduct="";
  int num = 0;

  // List of items in our dropdown menu
  var items = [
    "productName",
    "newQnt",
    "quantity",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('To update any information of any product.',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: upcController,
              decoration: const InputDecoration(
                hintText: "Enter product UPC",
                //errorText: 'User Password Can\'t Be Empty',
                prefixIcon: Icon(Icons.update, color: Colors.black),
              ),
            ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                if(dropdownValue == "fixQuantity"){
                  num = 1;
                }
              });
            },
            items: <String>['productName', 'fixQuantity']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
            Text('$dropdownValue'),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: updateController,
              decoration: const InputDecoration(
                hintText: "update information",
                //errorText: 'User Password Can\'t Be Empty',
                prefixIcon: Icon(Icons.update, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),

            ElevatedButton(
                onPressed: () {
                  final String user = FirebaseAuth.instance.currentUser!.uid;
                  if(num == 0) {
                    FirebaseFirestore.instance.collection("Inventory").doc(user)
                        .collection("product").doc(upcController.text)
                        .update(
                        {
                          "productName": updateController.text,
                        }
                    )
                        .then((value) {
                      print("Successfully updated product");
                    }).catchError((error) {
                      print("Failed to updated product");
                      print(error);
                    });
                    updateController.clear();
                    upcController.clear();
                  } else if (num == 1) {
                    FirebaseFirestore.instance.collection("Inventory").doc(user)
                        .collection("product").doc(upcController.text)
                        .update(
                        {
                          "quantity": int.parse(updateController.text),
                        }
                    )
                        .then((value) {
                      print("Successfully updated product");
                    }).catchError((error) {
                      print("Failed to updated product");
                      print(error);
                    });
                    updateController.clear();
                    upcController.clear();
                  }

                },
                child: const Text("Update")
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text('To delete any product.',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: deleteController,
              decoration: const InputDecoration(
                hintText: "UPC of the product you want to delete",
                //errorText: 'User Password Can\'t Be Empty',
                prefixIcon: Icon(Icons.delete, color: Colors.black),
              ),
            ),
            ElevatedButton(
            onPressed: () {
              final String user = FirebaseAuth.instance.currentUser!.uid;
              FirebaseFirestore.instance.collection("Inventory").doc(user).collection("product").doc(deleteController.text).delete(
              ).then((value) {
                print("Successfully deleted product");
              }).catchError((error) {
                print("Failed to deleted product");
                print(error);
              });
            },child: const Text("Delete")
            ),
          ],
        ),
      ),
    );
  }
}