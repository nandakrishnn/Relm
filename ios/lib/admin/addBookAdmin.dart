import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addBookAdmin extends StatefulWidget {
  const addBookAdmin({super.key});

  @override
  State<addBookAdmin> createState() => _addBookAdminState();
}

File? image3;
File? image4;

class _addBookAdminState extends State<addBookAdmin> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                child: Container(
                  height: 280,
                  width: 250,
                  child: image3 != null
                      ? Image.file(
                          image3!,
                          fit: BoxFit.none,
                        )
                      : Image.asset(
                          'assets/add-image-icon-512x477-bihmdte6.png',
                          fit: BoxFit.fill,
                        ),
                        
                ),
              ),
              SizedBox(height: 10,),
               GestureDetector(
                onTap: pickImage,
                child: const Text(
                  'Change Image',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )),
              SizedBox(
                height: 18,
              ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        
                        labelText: 'Name of the Book',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Bold label text
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 2), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 2), // Border color when focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Description of the Book',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Bold label text
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 2), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 2), // Border color when focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 19,),
                      TextFormField(
                        maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Name of the Author',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Bold label text
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 2), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 2), // Border color when focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 19,)
                    ,  TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Description of the Author',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Bold label text
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 2), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 2), // Border color when focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ],
                ),
              )),
              SizedBox(height: 10,),
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Container(
                    height: 250,
                    width: 250,
                    child: image4 != null
                        ? Image.file(
                            image4!,
                            fit: BoxFit.none,
                          )
                        : Image.asset(
                            'assets/add-image-icon-512x477-bihmdte6.png',
                            fit: BoxFit.fill,
                          ),
                          
                  ),
              ),
                SizedBox(height: 10,),
                 GestureDetector(
                onTap: pickImage1,
                child: const Text(
                  'Change Image',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )),
                SizedBox(height: 12,),
              ElevatedButton(onPressed: (){}, child: Text('Add Book'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() => image3 = File(pickedFile.path));
  }
  Future<void> pickImage1() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() => image4 = File(pickedFile.path));
  }
}
