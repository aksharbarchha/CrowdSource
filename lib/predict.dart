// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'image_storer.dart';
// // import 'result.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as Path;
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:tflite/tflite.dart';
// import 'dart:async';

// class Predict extends StatefulWidget {
//   static final obj = ImageStorer();

//   @override
//   _PredictState createState() => _PredictState();
// }

// class _PredictState extends State<Predict> {
//   @override
//   void initState() {
//     super.initState();
//     // _loading = true;
//     // loadModel().then((value) {
//     //   setState(() {
//     //     _loading = false;
//     //   });
//     // });
//   }

//   // String _uploadedFileURL = "null";
//   File cropimage = Predict.obj.getImage();

//   var now = new DateTime.now();
//   List _outputs;
//   // bool _loading = false;

//   Future uploadFile() async {
//     // StorageReference storageReference = FirebaseStorage.instance
//     //     .ref()
//     //     .child('Crops/${Path.basename(cropimage.path)}');
//     // StorageUploadTask uploadTask = storageReference.putFile(cropimage);
//     // var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

//     // String _uploadedFileURL = dowurl.toString();
//     // print("Upload Done  \n");
//     // storageReference.getDownloadURL().then((fileURL) {
//     //   setState(() async {
//     //     _uploadedFileURL =  await fileURL;
//     //   });
//     // });
//     print("\n\n\n\n\n\n");
//     // print("image:  \n" + _uploadedFileURL);
//     // final _auth = FirebaseAuth.instance;
//     // final user = await _auth.currentUser();
//     // final email = user.email;
//     // String timeString = DateFormat("yyyy M dd HH:mm:ss").format(now);
//     // String confidence = '99.999 %';

//     print("Getting url \n");

//     // Firestore.instance
//     //     .collection('users')
//     //     .document(email)
//     //     .collection('History')
//     //     .document()
//     //     .setData({
//     //   'Image URL': _uploadedFileURL,
//     //   'Remedies': 'Pata Nahi..Coming Soon.',
//     //   'Predicted Disease': _outputs[0]["label"],
//     //   'Time': timeString,
//     //   'Confidence': (_outputs[0]["confidence"] * 100).toStringAsFixed(2),
//     // });
//     // // print("b \n" + _uploadedFileURL);
//     // dispose();
//   }

//   loadModel() async {
//     print(cropimage);

//     await Tflite.loadModel(
//       model: "assets/crop_disease_detector.tflite",
//       labels: "assets/labels.txt",
//       numThreads: 1,
//     );
//     print("tflite loadmodel done!!");
//   }

//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//         path: image.path,
//         imageMean: 0.0,
//         imageStd: 255.0,
//         numResults: 2,
//         threshold: 0.2,
//         asynch: true);
//     setState(() {
//       // _loading = false;
//       _outputs = output;
//       print(_outputs);
//     });
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Aatmarnirbhar Farmer'),
//         backgroundColor: Colors.amber,
//       ),
//       body: Container(
//         child: Stack(
//           children: <Widget>[
//             Container(
//               // padding: EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: 400,
//                       width: 420,
//                       margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xff000000),
//                           width: 6,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                       ),
//                       child: Image.file(cropimage,
//                           width: 400, height: 380, fit: BoxFit.cover),
//                     ),
//                     SizedBox(
//                       height: 60,
//                       width: 20,
//                     ),
//                     Container(
//                       color: Color(0xFFff7751),
//                       padding: EdgeInsets.all(30),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.fromLTRB(
//                                           2.0, 14.0, 2.0, 12.0),
//                                       child: Text(
//                                         "Know about the disease\n by clicking below!",
//                                         style: TextStyle(
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.w900,
//                                             fontFamily: 'Nunito',
//                                             color: Colors.white),
//                                         softWrap: false,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 70,
//                       width: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           height: 60,
//                           width: 200,
//                           child: RaisedButton.icon(
//                             label: Text(
//                               "Predict",
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w800,
//                                   fontFamily: 'Nunito',
//                                   color: Colors.white),
//                             ),
//                             textColor: Colors.white,
//                             icon: Icon(Icons.search, color: Colors.white),
//                             color: Colors.amber,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(17)),
//                             onPressed: () async {
//                               // pickImageFromGallery(ImageSource.gallery);
//                               // await classifyImage(cropimage);
//                               uploadFile();

//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => Result(
//                               //             predictedDisease: _outputs[0]
//                               //                 ["label"],
//                               //             confidence:
//                               //                 (_outputs[0]["confidence"] * 100)
//                               //                     .toStringAsFixed(2))));
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                       width: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
