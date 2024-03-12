import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class AddMusCatAdmin extends StatefulWidget {
  AddMusCatAdmin({super.key});

  @override
  State<AddMusCatAdmin> createState() => _AddMusCatAdminState();
}

final TextEditingController muiccatname = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

File? image;

class _AddMusCatAdminState extends State<AddMusCatAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD MUSIC CATEGORY',
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
              const SizedBox(
                height: 25,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this feild';
                    }
                    if (value.length > 25) {
                      return ' Limit Exceeded';
                    }
                  },
                  controller: muiccatname,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_rounded),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Music Catgeory',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
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
              const SizedBox(
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
            ElevatedButton(
  onPressed: () async {
    String id = randomAlphaNumeric(10);
    if (formKey.currentState!.validate()) {
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Select an image to proceed',
          ),
          backgroundColor: Colors.red,
        ));
      } else {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Uploading data, please wait..."),
            ],
          ),
        ));


        List<int> imageBytes = image!.readAsBytesSync();
      
        String base64Image = base64Encode(imageBytes);

        Map<String, dynamic> musicCategoryInfo = {
          'MusicCategoryName': muiccatname.text,
          'Image': base64Image,
          'Id': id
        };
        await fireDatabase()
            .addMuCatgeorydetials(musicCategoryInfo, id)
            .then((value) {
          print('added successfully');
       
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });

        print(musicCategoryInfo);
        muiccatname.clear();
        setState(() {
          image = null;
        });

        Navigator.pop(context);
      }
    }
  },
  child: const Text('ADD'),
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
