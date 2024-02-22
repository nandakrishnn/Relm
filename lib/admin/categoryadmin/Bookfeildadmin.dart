// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';
import 'package:relm/admin/categoryadmin/playaudioadmin.dart';

import 'package:relm/admin/categoryadmin/viewpdfbookfeild.dart';

import 'package:relm/user%20home%20screens/database/firebasedb.dart';

//this is the page showing the details in the floating actionbutton in the bookcatgeory
class BookField extends StatefulWidget {
  final Function()? onBookAdded;
  const BookField({Key? key, this.onBookAdded}) : super(key: key);

  @override
  State<BookField> createState() => _BookFieldState();
}

class _BookFieldState extends State<BookField> {
  final TextEditingController BookDescription = TextEditingController();
  final TextEditingController Bookname = TextEditingController();
  final TextEditingController bookAuthor = TextEditingController();
  final TextEditingController Authordes = TextEditingController();
  final TextEditingController BoookCategory = TextEditingController();
  final GlobalKey<FormFieldState> fromkey = GlobalKey();
  File? file;
  File? Musicfile;
  File? imagebook;
  File? image1author;
  String? fileurl;
  String? Audiofileurl;
  double fileUploadProgress = 0;
  double musicFileUploadProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD BOOKDETAILS',
            style: TextStyle(color: Colors.white)),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Form(
                  key: fromkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value){
                        //   if(value!.isEmpty){
                        //       return 'Enter The name';
                        //   }
                        //   else if(value.length<3){
                        //     return 'Enter the correct name';
                        //   }
                        //   else{
                        //     return null;
                        //   }
                        // },
                        controller: Bookname,

                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.book_online),
                          labelText: 'Name of the Book',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   validator: (value){
                        //   if(value!.isEmpty){
                        //       return 'Enter The name';
                        //   }
                        //   else if(value.length<3){
                        //     return 'Enter the correct Descritption';
                        //   }
                        //   else{
                        //     return null;
                        //   }
                        // },
                        controller: BookDescription,
                        maxLines: null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.description),
                          labelText: 'Description of the Book',
                          hintMaxLines: 55,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextFormField(
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   validator: (value){
                        //   if(value!.isEmpty){
                        //       return 'Enter The name';
                        //   }
                        //   else if(value.length<3){
                        //     return 'Enter the correct Author name';
                        //   }
                        //   else{
                        //     return null;
                        //   }
                        // },
                        controller: bookAuthor,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_2),
                          labelText: 'Name of the Author',
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
                const SizedBox(
                  height: 19,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value){
                  //       if(value!.isEmpty){
                  //           return 'Enter The name';
                  //       }
                  //       else if(value.length<3){
                  //         return 'Enter the correct Descritption';
                  //       }
                  //       else{
                  //         return null;
                  //       }
                  //     },
                  controller: Authordes,
                  maxLines: null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_outlined),
                    hintMaxLines: 45,
                    labelText: 'Description of the Author',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value){
                  //       if(value!.isEmpty){
                  //           return 'Enter The name';
                  //       }
                  //       else if(value.length<3){
                  //         return 'Enter the correct Book catgeory';
                  //       }
                  //       else{
                  //         return null;
                  //       }
                  //     },
                  controller: BoookCategory,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.category_rounded),
                    labelText: 'Book Category',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: const Center(
                        child: Text(
                          'CHOOSE YOUR PDF',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                //   child: LinearProgressIndicator(
                //     value: fileUploadProgress,
                //     minHeight: 10,
                //     backgroundColor: Colors.grey[300],
                //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                //   ),
                // ),

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
                  height: 12,
                ),

                GestureDetector(
                  onTap: selectMusicFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: const Center(
                        child: Text(
                          'CHOOSE YOUR AUDIOFILE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                
                Text(
                  Musicfile != null
                      ? 'Selected File: ${Musicfile!.path.split('/').last}'
                      : 'No file selected',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
              

                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (file != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewAdmin(
                                        filePath: file!.path,
                                      )));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Select a pdf to view'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Icon(FeatherIcons.file),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size(55, 55),
                        elevation: 10,
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (Musicfile != null) {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Add a music to play',
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                        // final player=AudioCache();
                        // player.loadPath(Audiofileurl!);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayAudioAdmin(filepath: Musicfile!.path,)));
                      },
                      child: const Icon(FeatherIcons.music),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size(55, 55),
                        elevation: 10,
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Card(
                  elevation: 13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 200,
                      width: 250,
                      child: imagebook != null
                          ? Image.file(imagebook!)
                          : Image.asset('assets/noimageimage.jpg'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Text(
                    'Choose book image',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Colors.black
                              .withOpacity(0.5), // Set shadow color and opacity
                          offset: const Offset(1, 1), // Set shadow offset
                          blurRadius: 2, // Set shadow blur radius
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                Card(
                  elevation: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 150,
                      width: 250,
                      child: image1author != null
                          ? Image.file(image1author!)
                          : Image.asset(
                              'assets/noimageimage.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImage1();
                  },
                  child: Text(
                    'Choose  Author image',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Colors.black
                              .withOpacity(0.5), // Set shadow color and opacity
                          offset: const Offset(1, 1), // Set shadow offset
                          blurRadius: 2, // Set shadow blur radius
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (Bookname.text.isEmpty ||
                        BookDescription.text.isEmpty ||
                        bookAuthor.text.isEmpty ||
                        Authordes.text.isEmpty ||
                        BoookCategory.text.isEmpty) {
                      // Show a Snackbar to inform the user to fill in all the fields
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please fill in all the fields to continue.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Exit the function if any field is empty
                    }
                    // Check if both PDF and audio files are selected
                    if (file == null || Musicfile == null) {
                      // Show a Snackbar if any of the files is not selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please select both PDF and audio files to continue.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Exit the function if files are missing
                    }
                    // if(formKey.currentState!.validate())

                    // Upload the PDF and audio files
                    await uploadPdf(context);
                    await uploadAudio(context);

                    // Proceed to add book details only if both PDF and audio are uploaded successfully
                    if (fileurl != null && Audiofileurl != null) {
                      String id = randomAlphaNumeric(10);
                      // Check if book images are selected
                      if (imagebook != null && image1author != null) {
                        // Convert image files to bytes and encode to base64
                        List<int> imageBytes = imagebook!.readAsBytesSync();
                        String base64Imagebook = base64Encode(imageBytes);

                        List<int> imageBytesauthor =
                            image1author!.readAsBytesSync();
                        String base64Imageauthor =
                            base64Encode(imageBytesauthor);

                        // Create a map containing book details
                        Map<String, dynamic> BookListsInfo = {
                          'NameOfBook': Bookname.text,
                          'ImageOfBook': base64Imagebook,
                          'Id': id,
                          'BookDescription': BookDescription.text,
                          'AuthorName': bookAuthor.text,
                          'AuthorDescription': Authordes.text,
                          'ImageOfAuthor': base64Imageauthor,
                          'PdfUrl': fileurl,
                          'CatgeoryName': BoookCategory.text,
                          'AudioUrl': Audiofileurl
                        };

                        // Add book details to the database
                        await fireDatabase()
                            .addBookdetailsinCategory(BookListsInfo, id)
                            .then((value) {
                          print('added successfully');
                          // Fetch updated music list
                        });

                        // Call the callback function to notify the parent widget
                        if (widget.onBookAdded != null) {
                          widget.onBookAdded!();
                        }

                        // Navigate back to the previous screen
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text(
                    'ADD',
                  ),
                )

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

  Future<void> selectMusicFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      Musicfile = File(path);
    });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      imagebook = File(pickedFile.path);
    });
  }

  Future uploadPdf(BuildContext context) async {
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
      // final uploadTask = ref.putFile(file!);
      // uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      //   setState(() {
      //     fileUploadProgress = snapshot.bytesTransferred.toDouble() /
      //         snapshot.totalBytes.toDouble();
      //   });
      // });
      // Get the download URL of the uploaded file
      final downloadURL = await ref.getDownloadURL();
      fileurl = downloadURL;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File uploaded wait for Audio to be uploaded'),
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

  Future uploadAudio(BuildContext context) async {
    if (Musicfile == null) {
      // Handle the case where no audio file is selected
      return;
    }

    try {
      final fileName = basename(Musicfile!.path);
      final destination =
          'audio/$fileName'; // Adjust the destination folder as needed

      final ref = FirebaseStorage.instance.ref(destination);

      // Upload the audio file to Firebase Storage
      await ref.putFile(Musicfile!);

      // Get the download URL of the uploaded audio file
      final downloadURL = await ref.getDownloadURL();
      Audiofileurl = downloadURL;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Audio uploaded successfully! $downloadURL'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading audio file: $e');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error uploading audio file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> pickImage1() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      image1author = File(pickedFile.path);
    });
  }
}
