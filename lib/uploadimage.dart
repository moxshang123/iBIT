import 'dart:typed_data';
import 'package:iBIT/HomePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class uploadimage extends StatefulWidget {
  const uploadimage({Key? key}) : super(key: key);
  @override
  State<uploadimage> createState() => _uploadimageState();
}

class _uploadimageState extends State<uploadimage> {
  List<Offset> _dots = [];
  Uint8List? _image;

  void _handleImageSelected(Uint8List? image) {
    setState(() {
      _image = image;
    });
  }

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
  String get selectedVal => _selectedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                setState(() {
                  _dots.add(details.localPosition);
                  _Features[_selectedVal]!.add(details.localPosition);
                });
              },
              child: Container(
                width: 385,
                height: 330,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                ),
                child: _image == null
                    ? Text(
                  'No image selected',
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
                      left: 0,
                      top: 0,
                      child: Stack(
                        children: _Features[_selectedVal]!.map((dot) {
                          return Positioned(
                            left: dot.dx - 5,
                            top: dot.dy - 5,
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
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    _uploadImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[600],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.upload, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    // _saveSampleDetails();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[600],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 8),
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
          ],
        ),
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
    );
  }

  void _uploadImage(ImageSource source) async {
    final XFile? imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (imageFile != null) {
      final Uint8List img = await imageFile.readAsBytes();
      setState(() {
        _image = img;
      });
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