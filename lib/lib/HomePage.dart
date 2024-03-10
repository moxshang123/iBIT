import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sediment_features/Saved_data.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Intializing firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController sampleIdController = TextEditingController();
  TextEditingController sampleNoController = TextEditingController();
  TextEditingController longaxisController = TextEditingController();
  TextEditingController shortaxisController = TextEditingController();
  TextEditingController initialaxisController = TextEditingController();
  final _Features = [
    "Aspect Ratio",
    "Compactness",
    "ModRatio",
    "Solidity",
    "Convexity",
    "Rectangularity"
  ];
  String _selectedVal = "Aspect Ratio";// Default value for dropdown

  Uint8List? _image;

  void _handleImageSelected(Uint8List? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.purple[800],
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Transform.translate(
                offset: Offset(0.0, 20.0), // Adjust the vertical offset as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'iBIT',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(width: 90),
                    GestureDetector(
                      onTap: () {
                        // Handle sign up button press
                      },
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: Colors.white, width: 1.0), // Add the white border
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () {
                              // Handle sign up button press
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors
                                    .purple[700], // Set the background color
                                borderRadius:
                                BorderRadius.circular(
                                    20.0), // Set the border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle sign up button press
                      },
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: Colors.white, width: 1.0), // Add the white border
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () {
                              // Handle sign up button press
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors
                                    .purple[700], // Set the background color
                                borderRadius:
                                BorderRadius.circular(
                                    20.0), // Set the border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle menu button press
                      },
                      icon: Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple, // Set the color of the border
                    width: 2.0, // Set the width of the border
                  ),
                  borderRadius: BorderRadius.circular(2.0), // Set the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shape',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: initialaxisController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'Initial Axis',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: longaxisController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'Long Axis',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: shortaxisController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'Short Axis',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sample Info', // Changed text to 'Sample Info'
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: sampleIdController,
                              decoration: InputDecoration(
                                hintText: 'Sample ID', // Changed hint text to 'Sample Info'
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: sampleNoController,
                              decoration: InputDecoration(
                                hintText: 'Sample Number', // Changed hint text to 'Sample Info'
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _saveSampleDetails();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.purple[600], // Set the background color of the button
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.save,
                                      color: Colors.white), // Icon widget
                                  SizedBox(
                                      width:
                                      8), // Add some space between the icon and text
                                  Text(
                                    'Save Details',
                                    style: TextStyle(color: Colors.white),
                                  ), // Text widget
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 8,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      width: 385,
                      height: 330,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple[100], // Set the light purple background color
                      ),
                      child: _image == null
                          ? Text(
                        'No image selected',style: TextStyle(fontSize: 20,),
                        textAlign: TextAlign.center,
                      )
                          : Image.memory(
                        _image!,
                height: 330,
                width: 385,
                fit: BoxFit.fill,
                  alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            _uploadImage(ImageSource.gallery); // Call _uploadImage method
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purple[600], // Set the background color of the button
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.upload,
                                  color: Colors.white), // Icon widget
                              SizedBox(
                                  width:
                                  8), // Add some space between the icon and text
                              Text(
                                'Upload',
                                style: TextStyle(color: Colors.white),
                              ), // Text widget
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                           // _saveSampleDetails();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purple[600], // Set the background color of the button
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.save,
                                  color: Colors.white), // Icon widget
                              SizedBox(
                                  width:
                                  8), // Add some space between the icon and text
                              Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ), // Text widget
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SearchableDropdown<String>(
                        items: _Features
                            .map((feature) => DropdownMenuItem(
                          child: Text(feature),
                          value: feature,
                        ))
                            .toList(),
                        value: _selectedVal,
                        onChanged: (String? val) {
                          setState(() {
                            _selectedVal = val ?? "";
                          });
                        },
                        hint: "Select Feature",
                        isExpanded: true,
                        menuBackgroundColor: Colors.white,
                        iconSize: 28.0,
                        searchHint: "Search",
                        closeButton: (selectedItems) {
                          return "Close";

                        },
                      ),
                    ),


                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadImage(ImageSource source) async {
    final XFile? imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      final Uint8List img = await imageFile.readAsBytes();
      setState(() {
        _image = img;
      });
    }
  }
  void _saveSampleDetails() async {
    try {
      int sampleId = int.tryParse(sampleIdController.text)!;
      int sampleNo = int.tryParse(sampleNoController.text)!;
      int longaxis = int.tryParse(longaxisController.text)!;
      int initialaxis = int.tryParse(initialaxisController.text)!;
      int shortaxis = int.tryParse(shortaxisController.text)!;
      await _firestore.collection('samples').add({
        'sampleId': sampleId,
        'sampleNo': sampleNo,
       'Initial Axis': initialaxis,
        'Long Axis':longaxis,
        'Short Axis': shortaxis,
        // Add other sample details here
        // For example, 'image': _image, but you need to handle storing image in Firestore appropriately
      });
      // Show success message or perform other actions on successful save
    } catch (e) {
      // Handle error
      print('Error saving sample details: $e');
    }
  }
}
