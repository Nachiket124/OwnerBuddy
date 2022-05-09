import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class inventoryScreen extends StatefulWidget {
  @override
  _inventoryScreenState createState() => _inventoryScreenState();

}
class _inventoryScreenState extends State<inventoryScreen> {
    @override
    String _scanBarcode = 'Unknown';
    void initState() {
    super.initState();
    }

    Future<void> startBarcodeScanStream() async {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
    }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
    } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
    }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
    _scanBarcode = barcodeScanRes;
    });
  }

    // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
    _scanBarcode = barcodeScanRes;
    });
  }

    TextEditingController newQuantity = TextEditingController();
    TextEditingController subQuantity = TextEditingController();

    int firstQnt = 0, newQnt = 0;
    bool checked = true;
    String barcode = "";
    final String user = FirebaseAuth.instance.currentUser!.uid;
    late String itemName;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topCenter,
          child: Flex(
          direction: Axis.vertical,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          const SizedBox(
          height: 10.0,
          ),
            ElevatedButton(
            onPressed: () => scanBarcodeNormal(),
            style: ElevatedButton.styleFrom (
              primary: Color(0xFF0069FE),
              fixedSize: const Size(300, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
              child: Text('Start barcode scan'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
            onPressed: () => scanQR(),
                style: ElevatedButton.styleFrom (
                    primary: Color(0xFF0069FE),
                    fixedSize: const Size(300, 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              child: Text('Start QR scan')),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
            onPressed: () => startBarcodeScanStream(),
                style: ElevatedButton.styleFrom (
                    primary: Color(0xFF0069FE),
                    fixedSize: const Size(300, 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              child: Text('Start barcode scan stream')),
          Text('Scan result : $_scanBarcode\n',
              style: TextStyle(fontSize: 20)),

            TextField(
                controller: newQuantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "quantity",
                  prefixIcon: Icon(Icons.update, color: Colors.black),
                ),
            ),
            //newQnt = int.parse(newQuantity);
            ElevatedButton(style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30)),
                onPressed: () {
                  final String user = FirebaseAuth.instance.currentUser!.uid;
                  FirebaseFirestore.instance.collection("Inventory").doc(user).collection("product").doc(_scanBarcode).update(
                      {
                        "newQnt" : int.parse(newQuantity.text),
                      }
                  ).then((value) {
                    print("Successfully updated product");
                  }).catchError((error) {
                    print("Failed to updated product");
                    print(error);
                  });
                }, child: const Text('Add')
            ),

          ]));
        }));
  }

}

//Built build\app\outputs\bundle\release\app-release.aab (20.2MB). 