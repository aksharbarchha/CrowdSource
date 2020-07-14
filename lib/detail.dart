import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'image_storer.dart';
import 'savetodrive.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  static final obj = ImageStorer();
  File _image;
  // List _outputs;
  // bool _loading = false;

  // void initState() {
  //   super.initState();
  //   // _loading = true;

  //   // loadModel().then((value) {
  //   //   setState(() {
  //   //     _loading = false;
  //   //   });
  //   // });
  // }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    // setState(() {
    _image = image;
    obj.setImage(image);
    // });
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => SaveToDrive()));
    if (_image != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SaveToDrive()));
    }
  }

  pickImageFromGallery(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
      obj.setImage(image);
    });
    if (_image != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SaveToDrive()));
    }
  }

  //-------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('क्राउडसोर्स',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            )),
        backgroundColor: Colors.amber,
      ),
      // resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(25.0),
                // alignment: Alignment.center,
                width: 400.0,
                height: 400.0,
                // color: Colors.lightBlue,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 5,
                //   ),
                //   borderRadius: BorderRadius.all(Radius.circular(5)),
                // ),
                child: Center(
                    child: Text(
                  'कृपया फोटो सिलेक्ट करें ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    padding: EdgeInsets.all(25.0),
                    icon: Icon(Icons.photo_library),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    onPressed: () {
                      pickImageFromGallery(ImageSource.gallery);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SaveToDrive()));
                    },
                    label: Text('गैलरी',
                        style: TextStyle(color: Colors.black, fontSize: 24.0)),
                    color: Colors.amber,
                  ),
                  FlatButton.icon(
                    padding: EdgeInsets.all(25.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //call tensorlow
                      // _image == null
                      //     ? Container(
                      //         child: Text("Please select an image first!")):
                      getImage();
                    },
                    label: Text('कैमेरा',
                        style: TextStyle(color: Colors.black, fontSize: 24.0)),
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Center(
                    child: Text(
                  'इस एप के लिये इंटरनेट चालू होना अनिवार्य है',
                  style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))),
            // _loading
            // Container(
            //    height: 50,
            //      idth: 50,
            //
//
            //     : Ctainer(
            //        child: Row(
            //           children: <Widget>[
            //             SizedBox(
            //               height: 20,
            //             ),
            //             _outputs != null
            //                 ? Text(
            //                     _outputs[0]["label"],
            //                     style: TextStyle(
            //                         color: Colors.white, fontSize: 20),
            //                   )
            //                 : Container(child: Text("No image slected!"))
            //           ],
            //         ),
            //       )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.add_a_photo, color: Colors.amber[300]),
      //   backgroundColor: Colors.black,
      // ),
    );
  }
}
