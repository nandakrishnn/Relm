import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/musiccategories/musicincategories.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart'; 

class EditMusicField extends StatefulWidget {
  final DocumentSnapshot ds;

  const EditMusicField({Key? key, required this.ds}) : super(key: key);

  @override
  _EditMusicFieldState createState() => _EditMusicFieldState();
}

class _EditMusicFieldState extends State<EditMusicField> {
  final TextEditingController musicAuthorController = TextEditingController();
  final TextEditingController musicNameController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController filenameController = TextEditingController();
  File? image;
  File? file;
  String? fileurl;
  Uint8List? bytes;
  File? image1;
  late String filename;

  @override
  void initState() {
    super.initState();
    // Set initial values for text fields
    musicAuthorController.text = widget.ds['MusicAuthorName'];
    musicNameController.text = widget.ds['MusicName'];
    categoryNameController.text = widget.ds['CatgeoryName'];
    String imageUrl = widget.ds['Image'];
    bytes = base64Decode(imageUrl);
    String musicUrl = widget.ds['MusicUrl'];
    filename = musicUrl.split('/').last; 
    filenameController.text = filename;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Music', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/total baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: musicAuthorController,
                  decoration: InputDecoration(labelText: 'Author Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: musicNameController,
                  decoration: InputDecoration(labelText: 'Music Name'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: categoryNameController,
                  decoration: InputDecoration(labelText: 'Category Name'),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    height: 150,
                    width: 200,
                    child: image1 != null
                        ? Image.file(image1!)
                        : Image.memory(bytes!),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      pickImage();
                    },
                    child: Text('Choose New Image'),
                  ),
                ),
                SizedBox(height: 20.0),
                 TextFormField(
                controller: filenameController, 
                decoration: InputDecoration(labelText: 'Music File Name'), // Display filename
              ),SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                        final result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result != null) {
                        final path = result.files.single.path!;
                        setState(() {
                          file = File(path);
                          filename = basename(path); // Extract filename from path
                        filenameController.text = filename; 
                        });
                      }
                      
                    },
                    child: Text('Choose New Music File'),
                  ),
                ),
                
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String imageUrl = '';
                      String musicUrl = '';
                  
                      if (image1 != null) {
                        // Read the image file as bytes
                        List<int> imageBytes = await image1!.readAsBytes();
                        // Encode the bytes to base64 string
                        String base64Image = base64Encode(imageBytes);
                        // Construct the data URL
                        imageUrl = '${base64Image}';
                      }
                      else{
                         imageUrl = widget.ds['Image'];
                      }
                  
                      if (file != null) {
                        final fileName = basename(file!.path);
                        final destination = 'files/$fileName';
                  
                        final ref = FirebaseStorage.instance.ref(destination);
                  
                        // Upload the file to Firebase Storage
                        await ref.putFile(file!);
                  
                        // Get the download URL of the uploaded file
                        final downloadURL = await ref.getDownloadURL();
                        musicUrl = downloadURL;
                      }
                      else{
                        musicUrl = widget.ds['MusicUrl'];
                      }
                  
                      // Update music details
                      Map<String, dynamic> updatedMusicDetails = {
                        'MusicAuthorName': musicAuthorController.text,
                        'MusicName': musicNameController.text,
                        'CatgeoryName': categoryNameController.text,
                        'Image': imageUrl,
                        'MusicUrl': musicUrl,
                      };
                  
                      await fireDatabase()
                          .updatemusicdetails(widget.ds.id, updatedMusicDetails);
                          
                  
                      // Show confirmation message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Music details updated successfully!+${musicUrl}'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Navigate back to previous screen
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>categoryMusicList(category: ,)));
                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          ),
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
