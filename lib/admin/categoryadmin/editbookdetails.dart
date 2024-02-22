import 'dart:convert';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:relm/admin/categoryadmin/BooksinCategories.dart';

import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class EditBookDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  final String category1 ;

  const EditBookDetails({Key? key, required this.ds, required this.category1}) : super(key: key);

  @override
  State<EditBookDetails> createState() => _EditBookDetailsState();
}

class _EditBookDetailsState extends State<EditBookDetails> {

  final TextEditingController bookDescriptionController = TextEditingController();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookAuthorController = TextEditingController();
  final TextEditingController authorDescriptionController = TextEditingController();
  final TextEditingController bookCategoryController = TextEditingController();
  final TextEditingController pdfNameController = TextEditingController();
  final TextEditingController audioNameController = TextEditingController();
  File? bookImage;
  File? authorImage;
  String? bookImageUrl;
  String? authorImageUrl;
  String? pdfFileUrl;
  String? audioFileUrl;

  @override
  void initState() {
    super.initState();
    bookNameController.text = widget.ds['NameOfBook'];
    bookDescriptionController.text = widget.ds['BookDescription'];
    bookAuthorController.text = widget.ds['AuthorName'];
    authorDescriptionController.text = widget.ds['AuthorDescription'];
    bookCategoryController.text = widget.ds['CatgeoryName'];
    bookImageUrl = widget.ds['ImageOfBook'];
    authorImageUrl = widget.ds['ImageOfAuthor'];
    pdfFileUrl = widget.ds['PdfUrl'];
    audioFileUrl = widget.ds['AudioUrl'];
  

    // Set initial values for PDF file and audio file names
    final pdfFileName = pdfFileUrl?.split('/').last ?? '';
    pdfNameController.text = pdfFileName;

    final audioFileName = audioFileUrl?.split('/').last ?? '';
    audioNameController.text = audioFileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT BOOK DETAILS', style: TextStyle(color: Colors.white)),
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
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 19,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: bookNameController,
                        decoration: InputDecoration(
                          labelText: 'Name of the Book',
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
                        controller: bookDescriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description of the Book',
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
                        controller: bookAuthorController,
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
                        controller: authorDescriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description of the Author',
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
                        controller: bookCategoryController,
                        decoration: InputDecoration(
                          labelText: 'Book Category',
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
                SizedBox(
                  height: 19,
                ),
                TextFormField(
                  controller: pdfNameController,
                  decoration: InputDecoration(
                    labelText: 'Pdf file selected',
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
                  onTap: selectPdfFile,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      child: Center(
                        child: Text('CHOOSE YOUR PDF'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                TextFormField(
                  controller: audioNameController,
                  decoration: InputDecoration(
                    labelText: 'Audio file selected',
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
                  onTap: selectAudioFile,
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
                  height: 19,
                ),
                GestureDetector(
                  onTap: pickBookImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      child: Center(
                        child: bookImage != null ? Image.file(bookImage!) : Image.memory(base64Decode(bookImageUrl!)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                GestureDetector(
                  onTap: pickAuthorImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      child: Center(
                        child: authorImage != null ? Image.file(authorImage!) : Image.memory(base64Decode(authorImageUrl!)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await uploadFilesAndUpdateBook().then((value) {
                      setState(() {
                        
                      });
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => BookCategoryDetailsAdmin(category: widget.category1,))));
                    // Navigator.pop(context);
                  },
                  child: Text('UPDATE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectPdfFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      pdfFileUrl = path;
    });
  }

  Future<void> selectAudioFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      audioFileUrl = path;
    });
  }

  Future<void> pickBookImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      bookImage = File(pickedFile.path);
    });
  }

  Future<void> pickAuthorImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      authorImage = File(pickedFile.path);
    });
  }

 Future<void> uploadFilesAndUpdateBook() async {
  if (bookImage != null) {
    final imageBytes = await bookImage!.readAsBytes();
    bookImageUrl = base64Encode(imageBytes);
  }

  if (authorImage != null) {
    final imageBytes = await authorImage!.readAsBytes();
    authorImageUrl = base64Encode(imageBytes);
  }

  if (pdfFileUrl != null && pdfFileUrl!.startsWith('file:')) {
    final fileName = basename(pdfFileUrl!);
    final destination = 'files/$fileName';
    final ref = FirebaseStorage.instance.ref(destination);
    await ref.putFile(File(pdfFileUrl!));
    final downloadURL = await ref.getDownloadURL();
    pdfFileUrl = downloadURL;
  }

  if (audioFileUrl != null && audioFileUrl!.startsWith('file:')) {
    final fileName = basename(audioFileUrl!);
    final destination = 'audio/$fileName';
    final ref = FirebaseStorage.instance.ref(destination);
    await ref.putFile(File(audioFileUrl!));
    final downloadURL = await ref.getDownloadURL();
    audioFileUrl = downloadURL;
  }

  final updateBookContent = {
    'NameOfBook': bookNameController.text,
    'ImageOfBook': bookImageUrl,
    'BookDescription': bookDescriptionController.text,
    'AuthorName': bookAuthorController.text,
    'AuthorDescription': authorDescriptionController.text,
    'ImageOfAuthor': authorImageUrl,
    'PdfUrl': pdfFileUrl,
    'CatgeoryName': bookCategoryController.text,
    'AudioUrl': audioFileUrl,
  };

  await fireDatabase().updateBookDeatils(widget.ds.id, updateBookContent);
  
  print('Book details updated successfully!');
  

}

}
