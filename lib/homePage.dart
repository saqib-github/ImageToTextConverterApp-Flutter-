import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String result = "";
  File image;
  ImagePicker imagePicker;

  pickImageFromGallery() async
  {
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    image = File(pickedFile.path);

    setState(() {
      image;

      // start image labling

    });

  }

  captureImageWithCamera() async
  {

    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    image = File(pickedFile.path);

    setState(() {
      image;

      // start image labling
    });

  }

  performImageLabling() async
  {

    final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);

    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

    result = "";

    setState(() {
      for(TextBlock block in visionText.blocks)
      {
        final String text = block.text;

        for(TextLine line in block.lines)
        {
          for(TextElement element in line.elements)
          {
            result+=element.text+" ";
          }
        }

        result += "\n\n";
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imagePicker = ImagePicker();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 220,
                width: 240,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(left: 28, bottom: 5,right: 18),

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 16.0,),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(left: 28, bottom: 5,right: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: image!=null
                    ? Image.file(image, fit: BoxFit.fill,)
                    :Container(
                  width: 195,
                  height: 220,
                  child: Icon(Icons.camera_front, size: 100, color: Colors.grey,),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 47),
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        captureImageWithCamera();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: ()
                      {
                        pickImageFromGallery();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.picture_in_picture,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        performImageLabling();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.cached_rounded,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
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
