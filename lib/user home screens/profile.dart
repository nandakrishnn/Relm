import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relm/Login.dart';
import 'package:relm/user%20home%20screens/Music/editprofile.dart';
import 'package:relm/user%20home%20screens/splash/privacy_policy.dart';
import 'package:relm/user%20home%20screens/splash/terms_Of_use.dart';
import 'package:relm/user%20home%20screens/splash/tips_Relm.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late User? _user;
  File? image;
  late Stream<User?> _userStream;
  String? nanda;
  late Map<String, dynamic> _userData;
  Uint8List? profile;


  @override
  void initState() {
    super.initState();
 
    _user = FirebaseAuth.instance.currentUser;
    _userStream = FirebaseAuth.instance.authStateChanges();
    getUserData(); 
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('UserDetails')
        .doc(_user!.uid)
        .get();

    if (userDataSnapshot.exists) {
      setState(() {
        _userData = userDataSnapshot.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user1 = FirebaseAuth.instance.currentUser;
    print(user1);
    return Scaffold(
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
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: StreamBuilder<User?>(
                stream: _userStream,
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: Text('No user Logged in'),
                    );
                  }

                  User? user = snapshot.data;
                  return Column(
                    children: [
                      const SizedBox(height: 35,),
                      ClipOval(
                          child: SizedBox(
                              height: 150,
                              width: 150,
                              
                              child: profile != null
                                  ? Image.memory(
                                      profile!,
                                      fit: BoxFit.cover,
                                      
                                    )
                                  : const SizedBox(
                                      height: 150,
                                      width: 150,
                                    ))
                                    
                                    
                                    ),

                                        
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        nanda == null ? 'Loading..' : nanda!,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${user?.email ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(63, 63, 63, 5),
                          ),
                        ),
                        onPressed: () async {
                          // Navigate to editProfile and await the result
                          // ignore: unused_local_variable
                          final updatedData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                userData: _userData,
                                cuser: nanda!,
                                onUpdateUserData: updateUserData,
                              ),
                            ),
                          );

                          // Handle the updated data if necessary
                    
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Card(
                        elevation: 5,
                        color: const Color.fromARGB(63, 63, 63, 5),
                        shadowColor: Colors.black45,
                        child: ListTile(
                          title: const Text(
                            'Tips',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TipsPage()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 5,
                        color: const Color.fromARGB(63, 63, 63, 5),
                        shadowColor: Colors.black45,
                        child: ListTile(
                          title: const Text(
                            'Terms of use',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsOfUse()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // Card(
                      //   elevation: 5,
                      //   color: const Color.fromARGB(63, 63, 63, 5),
                      //   shadowColor: Colors.black45,
                      //   child: ListTile(
                      //     title: const Text(
                      //       'Version',
                      //       style: TextStyle(
                      //           color: Color.fromARGB(255, 255, 255, 255),
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //     trailing: IconButton(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.arrow_forward_ios_rounded),
                      //         color: Colors.white),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Card(
                        elevation: 5,
                        color: const Color.fromARGB(63, 63, 63, 5),
                        shadowColor: Colors.black45,
                        child: ListTile(
                          title: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicy()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 5,
                        color: const Color.fromARGB(63, 63, 63, 5),
                        shadowColor: Colors.black45,
                        child: ListTile(
                          title: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Are you sure you want to logout'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              FirebaseAuth.instance
                                                  .signOut()
                                                  .then((value) {
                                                singout(context);
                                              });
                                              ;
                                            },
                                            child: const Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No'))
                                      ],
                                    );
                                  },
                                );
                              },
                              icon:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Column(children: [
 Text('Version',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                      Text('1.0.0',style: TextStyle(fontSize: 15,color: Colors.white),)
                      ],)
                     
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('UserDetails')
          .doc(user!.uid)
          .get();

      if (userData.exists) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
          String name = _userData['Name'];
          nanda = name;

          // Access the value of "Image" directly and check if it's null
          dynamic imageValue = _userData['Image'];
          if (imageValue != null) {
            String base64Image = imageValue as String;
            Uint8List bytes = base64Decode(base64Image);
            profile = bytes;
          } else {
            // Handle the case where the "Image" field is null
            profile = null; // or assign a default value
          }

          // Print user data for debugging
          print('Name: $nanda'); // Print name for debugging
        });
      } else {
        print('User data not found');
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

void updateUserData(Map<String, dynamic> userData) {
  setState(() {
    _userData = userData;
    String name = userData['Name'];
    nanda = name;

    if (_userData.containsKey('Image')) {
      dynamic imageValue = _userData['Image'];
      if (imageValue != null) {
        String base64Image = imageValue as String;
        Uint8List bytes = base64Decode(base64Image);
        profile = bytes;
      } else {
      
        profile = null; 
      }
    }
  });
}

  singout(BuildContext context) async {
    final shared = await SharedPreferences.getInstance();
    await shared.clear();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (route)=>false);
}
}
