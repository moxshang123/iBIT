import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import the SplashScreen widget
import 'SplashScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  late Future<void> _initialization;

  // Initializing firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Intializing firestore instance

  TextEditingController sampleIdController = TextEditingController();
  TextEditingController sampleNoController = TextEditingController();
  TextEditingController longaxisController = TextEditingController();
  TextEditingController shortaxisController = TextEditingController();
  TextEditingController initialaxisController = TextEditingController();

  Map<String, List<Offset>> _Features = {
    'Angular Outline': [],
    'Subangular Outline': [],
    'Rounded Outline': [],
    'Small Conchoidal Fractures(<10um)': [],
    'Medium Conchoidal Fractures(<100um)': [],
    'Large Conchoidal Fractures(>100um)': [],
    'Arcuate Steps': [],
    'Straight Steps': [],
    'Meandering Ridges': [],
    'Flat Cleavage Surface': [],
    'Graded Arcs': [],
    'V-Shaped percussion cracks': [],
    'Straight/Curved Grooves and Scratches': [],
    'Upturned Plates': [],
    'Crescentic Percussion Marks': [],
    'Bulbous edges': [],
    'Abrasion Fatigue': [],
    'Parallel Striations': [],
    'Imbricated Grinding Features': [],
    'Oriented Etch Pits': [],
    'Solution Pits': [],
    'Solution Crevasses': [],
    'Scaling': [],
    'Silica Globules': [],
    'Silica Flowers': [],
    'Crystalline Overgrowths': [],
    'Low Relief': [],
    'Medium Relief': [],
    'High Relief': [],
    'Elongated Depressions': [],
    'Chattermarks': [],
    'Adhering Particles': [],
    'Arcuate/Circular/Ploygonal Cracks': [],
  };

  String _selectedVal = "Angular Outline";
  List<Offset> _dots = []; // Default value for dropdown

  Uint8List? _image;

  void _handleImageSelected(Uint8List? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    _initialization = Firebase.initializeApp();
    await _initialization;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a splash screen while initializing Firebase
          return SplashScreen();
        } else {
          return _buildHomePage();
        }
      },
    );
  }

  Widget _buildHomePage() {
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
                offset: Offset(0.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'iBIT',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
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
                    color: Colors.purple,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(2.0),
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
                              'Sample Info',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: sampleIdController,
                              decoration: InputDecoration(
                                hintText: 'Sample ID',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: sampleNoController,
                              decoration: InputDecoration(
                                hintText: 'Sample Number',
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
                                Colors.purple[600],
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.save,
                                      color: Colors.white),
                                  SizedBox(
                                      width:
                                      8),
                                  Text(
                                    'Save Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                  children: [GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      setState(() {
                        _dots.add(details.localPosition);
                        _Features[_selectedVal]!.add(details.localPosition); // Add dot for the selected item
                      });
                    },
                    child: Container(
                      width: 385,
                      height: 330,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple[100], // Set the light purple background color
                      ),
                      child: _image == null
                          ? Text(
                        'No image selected',
                        style: TextStyle(fontSize: 20,),
                        textAlign: TextAlign.center,
                      )
                          : Stack(
                        children: [
                          Image.memory(
                            _image!,
                            height: 330,
                            width: 385,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                          CustomPaint(
                            painter: DotPainter(_dots),
                          ),
                          Positioned(
                            left: 0, // Adjust position to center the dot
                            top: 0, // Adjust position to center the dot
                            child: Stack(
                              children: _Features[_selectedVal]!.map((dot) {
                                return Positioned(
                                  left: dot.dx - 5, // Adjust position to center the dot
                                  top: dot.dy - 5, // Adjust position to center the dot
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            _uploadImage(ImageSource.gallery);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.purple[600],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.upload,
                                  color: Colors.white),
                              SizedBox(
                                  width:
                                  8),
                              Text(
                                'Upload',
                                style: TextStyle(color: Colors.white),
                              ),
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
                            Colors.purple[600],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.save,
                                  color: Colors.white),
                              SizedBox(
                                  width:
                                  8),
                              Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedVal,
                  isExpanded: true, // Make the dropdown full horizontal
                  items: _Features.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value),
                          Text('${_Features[value]!.length}'),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVal = newValue!;
                      _updateItemCounts(); // Call _updateItemCounts when a new feature is selected
                    });
                  },
                ),
              ),

              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _uploadImage(ImageSource source) async {
    final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final Uint8List img = await imageFile.readAsBytes();
      setState(() {
        _image = img;
      });
    }
  }

  void _saveSampleDetails() async {
    try {
      int? sampleId = int.tryParse(sampleIdController.text);
      int? sampleNo = int.tryParse(sampleNoController.text);
      int? longAxis = int.tryParse(longaxisController.text);
      int? initialAxis = int.tryParse(initialaxisController.text);
      int? shortAxis = int.tryParse(shortaxisController.text);

      if (sampleId != null &&
          sampleNo != null &&
          longAxis != null &&
          initialAxis != null &&
          shortAxis != null) {
        await _firestore.collection('samples').add({
          'sampleId': sampleId,
          'sampleNo': sampleNo,
          'Initial Axis': initialAxis,
          'Long Axis': longAxis,
          'Short Axis': shortAxis,
          // Add other sample details here
          // For example, 'image': _image, but you need to handle storing image in Firestore appropriately
        });
        // Show success message or perform other actions on successful save
      } else {
        print('Error: One or more fields contain invalid data');
      }
      // Show success message or perform other actions on successful save
    } catch (e) {
      // Handle error
      print('Error saving sample details: $e');
    }
  }

  void _updateItemCounts() {
    _Features.keys.forEach((item) {
      _Features[item]!.clear();
    });
    _dots.clear(); // Clear all existing dots

    // Add dots for the selected item
    _dots.addAll(_Features[_selectedVal]!);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DotPainter extends CustomPainter {
  final List<Offset> dots;

  DotPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.purple;
    for (var dot in dots) {
      canvas.drawCircle(dot, 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
