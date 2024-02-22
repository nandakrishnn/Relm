// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class EditCategory extends StatefulWidget {

  final Datamodelcat detcat;
  const EditCategory({super.key, required this.detcat});

  

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

    late TextEditingController catname;
    File?image;
   
    

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catname=TextEditingController(text: widget.detcat.catname);
    image=File(widget.detcat.catimage);
    print("ID in initState: ${widget.detcat.id1}");
  


  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
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
              image: AssetImage('assets/Signup baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              
              children: [
                const SizedBox(height: 15,),
               ClipRRect(
                borderRadius: BorderRadius.circular(12),
                 child: Container(
                  height: 150,
                  width: 270,
                  color: Colors.amber,
                  child: Image.file(image!,fit: BoxFit.cover,),
                 ),
               ),
               const SizedBox(height: 12,),
               GestureDetector(
                onTap: (){
                  pickImage();
                },
                child: const Text('Change Image',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                 const SizedBox(height: 8,),
                Form(child: 
                TextFormField(
                  controller: catname,
                  decoration:const InputDecoration(
                    labelText: 'Category Name',
                    border: const OutlineInputBorder()
                  ),
                )),
                const SizedBox(height: 12,),
                ElevatedButton(onPressed: (){
                  onupdate();
                  Navigator.pop(context);
                }, child: const Text('Update Book'))
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
Future<void> onupdate() async {
  final ucatname = catname.text.trim();

  final id = widget.detcat.id1;// Access ID from widget
  print("ID before updating: $id");

  if (id != null) {
    final catDB = await Hive.openBox<Datamodelcat>('relmcat');
    try {
      final existingData = catDB.get(id);

      if (existingData != null) {
        final updatedData = Datamodelcat(
          id1: id,
          catname: ucatname,
          catimage: image?.path ?? existingData.catimage, // Use existing image path if new image is null
        );
        final success = await editCat(id, updatedData);
        if (success) {
          Navigator.pop(context);
        } else {
          // Handle error
          print('Failed to update category');
        }
      } else {
        print('Existing data is null');
      }
    } catch (e) {
      print('Error retrieving data from database: $e');
    } finally {
      await catDB.close();
    }
  } else {
    print('ID is null');
    // Handle null ID case
  }
}
}