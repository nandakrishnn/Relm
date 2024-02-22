import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

import 'categoryadmin.dart';

class AddCategoryAdmin extends StatefulWidget {
  AddCategoryAdmin({super.key});

  @override
  State<AddCategoryAdmin> createState() => _AddCategoryAdminState();
}

File? image1;
final categoryname = TextEditingController();
final GlobalKey<FormState> globkey = GlobalKey<FormState>();

class _AddCategoryAdminState extends State<AddCategoryAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADMIN PANEL',
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
            image: AssetImage('assets/total baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 36,
              ),
              Form(
                key: globkey,
                child: TextFormField(
                  
                  controller: categoryname,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      label: const Text('Categroy Name'),
                      labelStyle: const TextStyle(color: Colors.white)),
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please add the category name')),
                      );
                    } else if (value.length <= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Please add the correct category name')),
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  height: 230,
                  width: 350,
                  child: image1 != null
                      ? Image.file(
                          image1!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/category.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                  onTap: pickImage,
                  child: const Text(
                    'Change Image',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  )),
              const SizedBox(
                height: 53,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (globkey.currentState!.validate()) {
                      if (image1 != null && categoryname.text.isNotEmpty) {
                        onButtonClicked();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryAdmin()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Please fill out all fields to continue')),
                        );
                      }
                    }
                  },
                  child: const Text('Add Category'))
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() => image1 = File(pickedFile.path));
  }

  Future<void> onButtonClicked() async {
    final cname = categoryname.text.trim();

    if (cname.isNotEmpty) {
      final data = Datamodelcat(catimage: image1?.path ?? '', catname: cname);
       await addCategoryAdmin(data);
      
       

      categoryname.clear();
      
      image1 = null; 
    }
  }
}
