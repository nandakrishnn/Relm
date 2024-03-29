import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class MusicField extends StatefulWidget {
  final Function()? onMusicAdded;
  const MusicField({Key? key,this.onMusicAdded}) : super(key: key);

  @override
  State<MusicField> createState() => _MusicFieldState();
}

class _MusicFieldState extends State<MusicField> {
  final TextEditingController musicAuthor = TextEditingController();
  final TextEditingController musicName = TextEditingController();
  final TextEditingController catname=TextEditingController();
  File? file;
  File? image;
  String? fileurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD MUSIC', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Signup baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: musicAuthor,
                        decoration: InputDecoration(
                          labelText: 'Name of the Author',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      TextFormField(
                        controller: musicName,
                        decoration: InputDecoration(
                          labelText: 'Name of the Music',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 19,),
                   TextFormField(
                        controller: catname,
                        decoration: InputDecoration(
                          labelText: 'Name of the Category',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 19,
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      child: Center(
                        child: Text('CHOOSE YOUR AUDIO'),
                      ),
                    ),
                  ),
                ),
              
            
                SizedBox(
                  height: 24,
                ),

                Text(
                  file != null
                      ? 'Selected File: ${file!.path.split('/').last}'
                      : 'No file selected',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 14,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: image != null
                        ? Image.file(image!)
                        : Image.asset('assets/noimageimage.jpg'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // if (musicAuthor.text.isEmpty ||
                      //     musicName.text.isEmpty ||
                      //     image == null ||
                      //     fileurl == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //           'Please fill all the fields to continue.'),
                      //       backgroundColor: Colors.red,
                      //     ),
                      //   );
                      //   return;
                      // }
                      await uploadmusic(context);

                      String id = randomAlphaNumeric(10);
                      if (image != null) {
                        // Convert image file to bytes
                        List<int> imageBytes = image!.readAsBytesSync();
                        // Encode image bytes to base64 string
                        String base64Image = base64Encode(imageBytes);

                        Map<String, dynamic> musicListsInfo = {
                          'MusicAuthorName': musicAuthor.text,
                          'Image': base64Image,
                          'Id': id,
                          'MusicName': musicName.text,
                          'MusicUrl': fileurl,
                          'CatgeoryName':catname.text
                        };
                       await fireDatabase()
          .addMusicCategoryDetails(musicListsInfo, id)
          .then((value) {
        print('added successfully');
        // Fetch updated music list
       
      });
 if (widget.onMusicAdded != null) {
      // Call the callback function to notify the parent widget
      widget.onMusicAdded!();
    }
      // Now you can use the musicCategoryInfo map as needed

      Navigator.pop(context);
    }
  }, child: Text('ADD')),
                // ElevatedButton(onPressed: (){
                //   uploadmusic(context);
                // }, child: Text('heu'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      image = File(pickedFile.path);
    });
  }

  Future uploadmusic(BuildContext context) async {
    if (file == null) {
      // Handle the case where no file is selected
      return;
    }

    try {
      final fileName = basename(file!.path);
      final destination = 'files/$fileName';

      final ref = FirebaseStorage.instance.ref(destination);

      // Upload the file to Firebase Storage
      await ref.putFile(file!);

      // Get the download URL of the uploaded file
      final downloadURL = await ref.getDownloadURL();
      fileurl = downloadURL;

      // Update your database with the file URL
      // Replace 'your_database_reference' with your actual database reference
      // For example, if you are using Firestore:
      // await FirebaseFirestore.instance.collection('your_collection').doc('your_document').update({'fileURL': downloadURL});

      // Display a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File uploaded successfully!$downloadURL'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
