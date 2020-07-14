import 'package:flutter/material.dart';
import 'dart:io';
import 'image_storer.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:wifi/wifi.dart';
import 'dart:convert';

class SaveToDrive extends StatefulWidget {
  static final obj = ImageStorer();
  @override
  _SaveToDriveState createState() => _SaveToDriveState();
}

class _SaveToDriveState extends State<SaveToDrive> {
  // @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _crop = "";
  String _disease = "";
  String _comment = "";
  String _ip = "Kuch Nahi";
  String _lat = "none";
  String _lon = "none";
  String _town = "none";
  File cropimage = SaveToDrive.obj.getImage();

  Future<Null> _getIP() async {
    // String ip = await Wifi.ip;
    // _ip = ip;
    // print(_ip);
    // String url = "http://ip-api.com/json/" + _ip;
    // http.Response response = await http.get(url);
    // print(response.body.toString());

    String url1 = "https://api.ipify.org?format=json";
    http.Response response1 = await http.get(url1);
    var results1 = jsonDecode(response1.body);
    print(response1.body.toString());
    _ip = results1["ip"];

    String url2 = "http://ip-api.com/json/" + _ip;
    http.Response response2 = await http.get(url2);
    print(response2.body.toString());
    var results2 = jsonDecode(response2.body);

    print("City" + results2['city'].toString());
    print(results2['lat']);
    print(results2['lon']);
    _town = results2['city'];
    _lat = results2['lat'].toString();
    _lon = results2['lon'].toString();
  }

  var now = new DateTime.now();
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Crops/${Path.basename(cropimage.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(cropimage);
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    String _uploadedFileURL = dowurl.toString();
    print("Upload Done  \n");
    print("image:  \n" + _uploadedFileURL);

    print("IP mila ?\n");
    print(_ip);
    // await _getIP();
    // final _auth = FirebaseAuth.instance;
    // final user = await _auth.currentUser();
    // final email = user.email;
    String timeString = DateFormat("yyyy MM dd HH:mm:ss").format(now);
    // String confidence = '99.999 %';

    print("Getting url \n cOMMENT\n" + _comment.toString());
    await _getIP();
    Firestore.instance.collection('Farmers').document().setData({
      'imageURL': _uploadedFileURL,
      'crop': _crop,
      'disease': _disease,
      'dateTime': timeString,
      'comments': _comment,
      'email': "email@email.com",
      'fileName': _crop + "-" + _disease + "-" + timeString,
      'latitude': _lat,
      'longitude': _lon,
      'town': _town
    });
    print("Link  \n" + _uploadedFileURL);

    // if (_uploadedFileURL != null) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           backgroundColor: Colors.greenAccent,
    //           title: Text("Success !"),
    //           content: Container(
    //             child: Text(
    //               "Photo Uploaded!",
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         );
    //       });
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           backgroundColor: Colors.redAccent,
    //           title: Text("Error !"),
    //           content: Container(
    //             child: Text(
    //               "Please Try Again",
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         );
    //       });
    // }
  }

  final nameHolder = TextEditingController();
  final nameHolder1 = TextEditingController();
  final nameHolder2 = TextEditingController();
  clearTextInput() {
    nameHolder.clear();
    nameHolder1.clear();
    nameHolder2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "क्राउडसोर्स",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      width: 420,
                      margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Image.file(cropimage,
                          width: 400, height: 380, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: 30,
                      width: 20,
                    ),
                    Container(
                      color: Color(0xFFff7751),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          2.0, 5.0, 2.0, 5.0),
                                      child: Text(
                                        "पीला बटन दबा के \nफोटो सेव्ह करें !",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Nunito',
                                            color: Colors.white),
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 20,
                    ),
                    Container(
                        child: Form(
                            key: _formKey,
                            autovalidate: true,
                            // child: new ListView(
                            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            //   children: <Widget>[
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: new InputDecoration(
                                      icon: const Icon(
                                        Icons.toys,
                                        color: Colors.green,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "कृपया फसल का नाम लिखे ",
                                      hintStyle: TextStyle(fontSize: 18),
                                      labelStyle: TextStyle(fontSize: 25),
                                      labelText: "फसल का नाम ",
                                    ),
                                    controller: nameHolder,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'कृपया फसल का नाम लिखे ';
                                      } else {
                                        _crop = value;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                  ),
                                  TextFormField(
                                    decoration: new InputDecoration(
                                        icon: const Icon(Icons.bug_report,
                                            color: Colors.brown),
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 15,
                                            top: 11,
                                            right: 15),
                                        hintStyle: TextStyle(fontSize: 18),
                                        labelStyle: TextStyle(fontSize: 25),
                                        hintText:
                                            "रोग का नाम (रोग नही तो None लिखे )",
                                        labelText: "रोग का नाम"),
                                    controller: nameHolder1,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'कृपया रोग का नाम लिखे';
                                      } else {
                                        _disease = value;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                  ),
                                  TextFormField(
                                    decoration: new InputDecoration(
                                        icon: const Icon(
                                          Icons.chat_bubble,
                                          color: Colors.blueAccent,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 15,
                                            top: 11,
                                            right: 15),
                                        hintStyle: TextStyle(fontSize: 18),
                                        labelStyle: TextStyle(fontSize: 25),
                                        hintText: "यहा लिखे ",
                                        labelText: "टिपणी"),
                                    controller: nameHolder2,
                                    validator: (value) {
                                      if (!value.isEmpty) {
                                        _comment = value;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ))),
                    SizedBox(
                      height: 40,
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 250,
                          child: RaisedButton.icon(
                            label: Text(
                              "सेव्ह करे",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Nunito',
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            textColor: Colors.white,
                            icon: Icon(Icons.file_upload, color: Colors.black),
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)),
                            onPressed: () async {
                              // pickImageFromGallery(ImageSource.gallery);
                              // if (_formKey.currentState.validate()) {
                              //   // If the form is valid, display a Snackbar.
                              //   Scaffold.of(context).showSnackBar(
                              //       SnackBar(content: Text('Processing Data')));
                              // }
                              // await classifyImage(cropimage);
                              // await drive.upload(cropimage);
                              if (_crop != "" && _disease != "") {
                                uploadFile();
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.green,
                                        title: Text(
                                          "धन्यवाद !",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Container(
                                          child: Text(
                                            "फोटो सेव्ह हो गया !",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    });
                                clearTextInput();
                                // Navigator.pop(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.redAccent,
                                        title: Text("एरर !"),
                                        content: Container(
                                          child: Text(
                                            "फसल का नाम और रोग लिखिये !",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
