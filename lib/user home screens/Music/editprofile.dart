import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class EditProfile extends StatefulWidget{
  final Map<String, dynamic> userData;
  final String cuser;
  final Function(Map<String, dynamic>) onUpdateUserData;


  EditProfile({
    Key? key,
    required this.userData, required this.cuser, required this.onUpdateUserData,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  late TextEditingController updateuname;
  late TextEditingController updateemail;
  late TextEditingController updatepass;
  late TextEditingController updateperu;
  late Map<String, dynamic> _userData;
  Uint8List? profile;
  late String? finaloimage;
@override
void initState() {
  super.initState();
  
  _userData = widget.userData ?? {};
  updateuname = TextEditingController(text: widget.userData['username']);
  updateemail = TextEditingController(text: widget.userData['email'] ?? '');
  updatepass = TextEditingController(text: widget.userData['Password'] ?? '');
  updateperu = TextEditingController(text: widget.userData['Name'] ?? '');
  
  String base64 = widget.userData["Image"] ?? '';
  Uint8List? bytes = base64.isNotEmpty ? base64Decode(base64) : null;
  profile = bytes;
  if (profile != null) {
    image = File.fromRawPath(profile!);
  }
}

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 64),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    backgroundImage: image != null ? MemoryImage(profile!) : null,
                    // child: image == null
                    //     ? const Icon(
                    //         Icons.person,
                    //         size: 50.0,
                    //         color: Color.fromRGBO(11, 206, 131, 1),
                    //       )
                    //     : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: const Text(
                    'Change Image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: updateuname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Username',
                        labelText: 'Username',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: updateperu,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Name',
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      controller: updateemail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Email',
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: updatepass,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                     
                        if(image!=null){
                            List<int> imageBytes = image!.readAsBytesSync();
                    // Encode image bytes to base64 string
                    String base64Image = base64Encode(imageBytes);
                    finaloimage=base64Image;
                        }else{
                          finaloimage=widget.userData['Image'];
                        }
                       
                        // Encode image bytes to base64 string
                    
                 
                        Map<String, dynamic> updateUser = {
                          'Name': updateperu.text,
                          'username': updateuname.text,
                          'Image': finaloimage,
                          'email':updateemail.text,
                          'Password':updatepass.text

                        };
                        final currentUser = FirebaseAuth.instance.currentUser;
                        print(widget.cuser);

                        if (currentUser != null) {
                         
                          print(currentUser);
                        
                        } else {
                        
                          print('No user is currently signed in.');
                        }
                        print(currentUser);
                        await fireDatabase()
                            .updateUserDetails(currentUser!.uid, updateUser)
                            .then((value) {
                           widget.onUpdateUserData(updateUser);
                          Navigator.pop(context);
                        });
                        
                        ButtonStyle(
                            shadowColor: MaterialStatePropertyAll(
                                Color.fromRGBO(255, 13, 13, 0.984)));
                      },
                      child: const Text(
                        'Update',
                        style:
                            TextStyle(color: Color.fromRGBO(63, 63, 63, 0.984)),
                      ),
                    )
                  ],
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
    if (pickedFile == null) return;

    setState(() {
      image = File(pickedFile.path);
       List<int> imageBytes = image!.readAsBytesSync();
    profile = Uint8List.fromList(imageBytes);
    });
  }
}
