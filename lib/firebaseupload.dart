import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key}) : super(key: key);

  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? imageFile;
  UploadTask? task;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (imageFile == null) return;

    try {
      final Reference ref = FirebaseStorage.instance.ref().child("profileImage/${DateTime.now().millisecondsSinceEpoch}");
      final UploadTask uploadTask = ref.putFile(imageFile!);

      uploadTask.whenComplete(() async {
        final url = await ref.getDownloadURL();
        print("Image uploaded: $url");
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageFile != null) Expanded(child: Image(image: FileImage(imageFile!))),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text("Pick image from gallery"),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text("Take a picture"),
              ),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text("Upload image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
