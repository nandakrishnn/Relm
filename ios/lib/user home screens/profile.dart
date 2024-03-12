import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relm/Login.dart';
import 'package:relm/user%20home%20screens/Music/editprofile.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  File? image;

@override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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
            child: Column(
              children: [
                // ValueListenableBuilder(
                //   valueListenable: dataListNotifier,
                //   builder: (BuildContext ctx, List<DataModel> dataList,
                //       Widget? child) {
                //     if (dataList.isEmpty) {
                //       return LinearProgressIndicator();
                //     }

                //     data = dataList.last;
                //     print('HI${data.id}');
                //     return Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(top: 85),
                //           child: CircleAvatar(
                //             radius: 80,
                //             backgroundColor: Colors.white,
                //             backgroundImage:
                //                (data.imageprof != null &&
                //                               data.imageprof!.isNotEmpty)
                //                           ? FileImage(File(data.imageprof!))
                //                           : null,
                //                       child: (data.imageprof == null ||
                //                               data.imageprof!.isEmpty)
                //                           ? const Icon(
                //                               Icons.person,
                //                               size: 50.0,
                //                               color: Color.fromRGBO(
                //                                   11, 206, 131, 1),
                //                             )
                //                           : null,
                //     ),
                //         ),
                //         const SizedBox(
                //           height: 9,
                //         ),
                //         Text(
                //           data.uname ?? '',
                //           style: const TextStyle(
                //               fontSize: 19, fontWeight: FontWeight.w700),
                //         ),
                //         Text(
                //           data.email ?? '',
                //           style: const TextStyle(
                //               fontSize: 18, fontWeight: FontWeight.w500),
                //         ),
                //         const SizedBox(
                //           height: 26,
                //         ),
                //         ElevatedButton(
                //           style: const ButtonStyle(
                //             backgroundColor: MaterialStatePropertyAll(
                //               Color.fromRGBO(63, 63, 63, 5),
                //             ),
                //           ),
                //           onPressed: () async {
                //             // Navigate to editProfile and await the result
                //             final updatedData = await Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => EditProfile(
                //                   userdata: data,
                                
                //                 ),
                //               ),
                //             );

                //             // Handle the updated data if necessary
                //             if (updatedData != null && updatedData is DataModel) {
                //               setState(() {
                //                 // Update the UI with the new data
                //                 data = updatedData;
                //               });
                //             }
                //           },
                //           child: const Text(
                //             'Edit Profile',
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ),
                //       ],
                //     );
                //   },
                // ),

                const SizedBox(
                  height: 55,
                ),

                // Additional Widgets
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                      'Privacy Policy',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Card(
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
                                return  AlertDialog(title: Text('Are you sure you want to logout'),
                              actions: [TextButton(onPressed: (){
                                FirebaseAuth.instance.signOut().then((value){
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                                });
                          ;}, child: Text('Yes')),
                                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No'))],);
                              },
                             
                            );
                            
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Future<void> fetchData() async {
  try {
    // await getAlldata(); // Retrieve data from Hive box
    setState(() {}); // Trigger a rebuild after data is fetched
  } catch (e) {
    print('Error getting data: $e');
  }
}


}
