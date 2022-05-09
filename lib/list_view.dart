import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listView extends StatefulWidget {
  @override
  _listViewState createState() => _listViewState();
}

class _listViewState extends State<listView> {

  var itemList = [];
  int buyItmNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //alignment: Alignment.topCenter,
                children: [
                  ElevatedButton(
                    child: const Text("Print list"),
                    onPressed: () async {
                      itemList = [];
                      final String user = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance.collection("Inventory").doc(user).collection("product").get().then((querySnapshot){
                        print("SuccessFull load all items");
                        querySnapshot.docs.forEach((element) {
                          print(element);
                          print(element.data());
                          buyItmNum = element.data()["quantity"]-element.data()["newQnt"];
                          print(buyItmNum);

                          if(buyItmNum>0){
                            itemList.add(element.data()['productName'].toString() + " (" + "$buyItmNum" + ")");
                          }
                        });
                        setState(() {

                        });
                      }).catchError((error){
                        print(error);
                      });
                    },
                  ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount : itemList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      height: 50,
                      color: Colors.amber[300],
                      child: Center(child: Text('${itemList[index]}')),
                    );
                  },
                ),
              )
              ]
            )
        )
    );
  }

}