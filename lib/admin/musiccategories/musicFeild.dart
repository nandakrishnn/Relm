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
  const MusicField({Key? key, this.onMusicAdded}) : super(key: key);

  @override
  State<MusicField> createState() => _MusicFieldState();
}

class _MusicFieldState extends State<MusicField> {
  final TextEditingController musicAuthor = TextEditingController();
  final TextEditingController musicName = TextEditingController();
  final TextEditingController catname = TextEditingController();
  final TextEditingController ratingCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? file;
  File? image;
  String? fileurl;
  double _uploadProgress = 0;

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
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: musicAuthor,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_2),
                            labelText: 'Name of the Author',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill this feild';
                            }
                            if (value.length < 3) {
                              return 'Less number of Caharcters';
                            }
                            if (value.length > 30) {
                              return 'Limit Exceeded';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: musicName,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.music_note_outlined),
                            labelText: 'Name of the Music',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill this feild';
                            }
                            if (value.length < 2) {
                              return 'Less number of Caharcters';
                            }
                            if (value.length > 30) {
                              return 'Limit Exceeded';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: catname,
                          decoration: InputDecoration(
                            labelText: 'Name of the Category',
                            prefixIcon: const Icon(Icons.category_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill this feild';
                            }
                            if (value.length < 2) {
                              return 'Less number of Caharcters';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: ratingCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Rating of music',
                            prefixIcon: const Icon(Icons.rate_review_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                              return 'Only numbers are allowed';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: const Center(
                        child: Text(
                          'CHOOSE YOUR AUDIO',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  file != null
                      ? 'Selected File: ${file!.path.split('/').last}'
                      : 'No file selected',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (musicAuthor.text.isEmpty ||
                        musicName.text.isEmpty ||
                        catname.text.isEmpty ||
                        file == null ||
                        image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please fill all the fields to continue.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Stop further execution
                    }
                    if (formKey.currentState!.validate()) {
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
                          'CatgeoryName': catname.text,
                          'Rating': ratingCtrl.text
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
                    }
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 50)),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromRGBO(63, 63, 63,
                              0.5)) 
                      ),
                ),
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

  Future uploadmusic(BuildContext? context) async {
    if (file == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          content: Text('No image selected! Please select an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final fileName = basename(file!.path);
      final destination = 'files/$fileName';

      final ref = FirebaseStorage.instance.ref(destination);
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text('Uploading file..'),
              SizedBox(
                width: 5,
              ),
              CircularProgressIndicator()
            ],
          ),
          backgroundColor: Color.fromARGB(255, 16, 255, 120),
        ),
      );

      // Upload the file to Firebase Storage
      await ref.putFile(file!);

      final downloadURL = await ref.getDownloadURL();
      fileurl = downloadURL;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
