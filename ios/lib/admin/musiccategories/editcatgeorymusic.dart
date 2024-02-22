import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class EditCatMusic extends StatefulWidget {
  final DocumentSnapshot ds;

  EditCatMusic({Key? key, required this.ds}) : super(key: key);

  @override
  State<EditCatMusic> createState() => _EditCatMusicState();
}

class _EditCatMusicState extends State<EditCatMusic> {
  final TextEditingController updatedmuiccatname = TextEditingController();

  File? image1;
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    // Load the image when the widget is initialized
    String imageUrl = widget.ds['Image'];
    bytes = base64Decode(imageUrl);
    // Set image1 to null, as we are displaying image23 by default
    image1 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD BOOK', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/total baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: updatedmuiccatname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '${widget.ds['MusicCategoryName']}',
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 150,
              width: 200,
              child:
                  image1 != null ? Image.file(image1!) : Image.memory(bytes!),
              // Display the image or an empty container
            ),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Text('Change Image'),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () async {
                   if (updatedmuiccatname.text.isEmpty) {
      // Show a snackbar to inform the user to fill in the required fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the fields.'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      return; 
    }
    
                  String imageUrl = '';
               if (image1 != null) {
      // Read the image file as bytes
      List<int> imageBytes = await image1!.readAsBytes();
      // Encode the bytes to base64 string
      String base64Image = base64Encode(imageBytes);
      // Construct the data URL
      imageUrl = '${base64Image}';
    }
                  

                  Map<String, dynamic> updateInfo = {
                    "MusicCategoryName": updatedmuiccatname.text,
                    "Image": imageUrl,
                    "Id":widget.ds.id,
                  };
                  await fireDatabase().updateCategory(widget.ds.id, updateInfo).then((value) {
                      Navigator.pop(context);
                  });
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(63, 63, 63, 2)),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image1 = File(pickedFile.path);
      });
    }
  }
}
