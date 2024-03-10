import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class UploadImage extends StatefulWidget {
  final void Function(Uint8List)? onImageSelected; // Callback function to handle the selected image

  const UploadImage({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Uint8List? _image;

  Future<void> selectImage(ImageSource source) async {
    Uint8List img = await pickImage(source);
    setState(() {
      _image = img;
    });
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(_image!);
    }
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print("No Images Selected");
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
