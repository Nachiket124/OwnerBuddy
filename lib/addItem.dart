import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  TextEditingController upcController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Add item",
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
                  SizedBox(width: screenWidth * 0.45, child: const Text(
                        "UPC",
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  SizedBox(width: screenWidth * 0.45, child: TextField(
                    controller: upcController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "UPC",
                  )),
                  ),
                ],
              ),

              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: screenWidth * 0.45, child: const Text(
                    "Product name",
                  ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  SizedBox(width: screenWidth * 0.45, child: TextField(
                      controller: productNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "name",
                      )),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: screenWidth * 0.45, child: const Text(
                    "Product Quantity",
                  ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  SizedBox(width: screenWidth * 0.45, child: TextField(
                      controller: productQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "quantity",
                      )),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30)),
                onPressed: () {
                  itemSetup(productNameController.text, upcController.text, int.parse(productQuantityController.text), int.parse(productQuantityController.text));
                },
                child: const Text('Add'),
              ),
            ]
          )
        )
    );
  }

}
Future<void> itemSetup(String productName, String UPC, int quantity, int newQnt) async{
  final String user = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference Inventory = FirebaseFirestore.instance.collection("Inventory").doc(user).collection("product");
  Inventory.doc(UPC).set({
    'UPC' : UPC,
    'productName' : productName,
    'quantity' : quantity,
    'newQnt' : newQnt,
  }).then((value) {
    print("Successfully added product");
  }).catchError((error) {
    print("Failed to add product");
    print(error);
  });

}