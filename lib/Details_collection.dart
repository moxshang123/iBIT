import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details_collection extends StatelessWidget {
  Details_collection({Key? key}) : super(key: key);
  TextEditingController sampleIdController = TextEditingController();
  TextEditingController sampleNoController = TextEditingController();
  TextEditingController longaxisController = TextEditingController();
  TextEditingController shortaxisController = TextEditingController();
  TextEditingController initialaxisController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
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
}

