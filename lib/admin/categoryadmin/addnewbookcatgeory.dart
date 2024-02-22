import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

//this page okay

class AddBookCatgeory extends StatefulWidget {
  AddBookCatgeory({super.key});

  @override
  State<AddBookCatgeory> createState() => _AddBookCatgeoryState();
}

final TextEditingController bookcatname = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
File? image;

class _AddBookCatgeoryState extends State<AddBookCatgeory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD BOOK CATEGORY',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Signup baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Form
              (
                key:formKey ,
                child: TextFormField(
                  
                  validator: (value){
                    if(value==null){
                      return 'Add the catgegory';
                
                    }
                    else if(value.length<3){
                      return 'Enter a valid catgeory';
                    }
                 
                  },
                  controller: bookcatname,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.category_sharp),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Book Catgeory',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Card(
                elevation: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 150,
                    width: 200,
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/category.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: const Text(
                    'Change Image',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () async {
                  
                  String id = randomAlphaNumeric(10);
                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an image to proceed.'),
                        duration: Duration(seconds: 2),
                        backgroundColor:
                            Colors.red, // Adjust the duration as needed
                      ),
                    );
                  }
                  if (formKey.currentState!.validate() && image != null) {
                  List<int> imageBytes = image!.readAsBytesSync();
                  // Encode image bytes to base64 string
                  String base64Image = base64Encode(imageBytes);

                  Map<String, dynamic> bokCatgeoryinfo = {
                    'BookCategoryName': bookcatname.text,
                    'BookCategoryImage': base64Image,
                    'Id': id
                  };

                  await fireDatabase()
                      .addBookCatgeorydetials(bokCatgeoryinfo, id)
                      .then((value) => {
                            print('added successfully'),
                          });

                  // Now you can use the musicCategoryInfo map as needed
                  print(bokCatgeoryinfo);
                  bookcatname.clear();
                  setState(() {
                    image = null;
                  });

                  Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromRGBO(63, 63, 63, 5)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 14.0), // Adjust padding as needed
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          24.0), // Adjust border radius as needed
                    ),
                  ),
                  elevation: MaterialStateProperty.all(
                      8), // Adjust elevation as needed
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black.withOpacity(
                            0.5); // Change overlay color when pressed
                      }
                      return Colors
                          .transparent; // No overlay color when not pressed
                    },
                  ),
                ),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    fontSize: 18.0, // Adjust font size as needed
                    fontWeight: FontWeight.bold, // Adjust font weight as needed
                    color: Colors.white,
                  ),
                ),
              )
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

    setState(() {
      image = File(pickedFile.path);
    });
  }
}
