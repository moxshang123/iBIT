import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sediment_features/upload_image.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({super.key});
  State<MyApp> createState()=> _MyApp();
}

class _MyApp extends State<MyApp> {
  // late File _image;
  // final picker = ImagePicker();
  //
  //
  //
  // Future getImage() async {
  //   // final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   File image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
  //   setState(() {
  //     if (image !=  null) {
  //       _image = File(image.path);
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  // }

  Uint8List? _image;
  void selectImage(ImageSource gallery) async{
   Uint8List img = await pickImage(ImageSource.gallery);
   setState(() {
     _image = img;
   });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Feature Config',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sample id',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Sample ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sample No',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Sample No',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Shape',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Long Axis',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Short Axis',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Initial Axis',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                  Center(
                  child: _image == null
                      ? Text('No image selected')
              : Image.memory(_image!),
    ),
                        // width: 250,
                        // height: 250,
                        // child: Image.asset(
                        //   // "assets/DVP021.jpg", // Replace this with your image path
                        //   fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          selectImage(ImageSource.gallery);
                          print(_image);
                        },
                        child: Text('Upload Image'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 34,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      width:20,
                      height: 50,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your save logic here
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
