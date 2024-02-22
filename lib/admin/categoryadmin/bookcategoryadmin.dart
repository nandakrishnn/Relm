import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/categoryadmin/BooksinCategories.dart';
import 'package:relm/admin/categoryadmin/AdeditBookcategory.dart';

import 'package:relm/admin/categoryadmin/addnewbookcatgeory.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';




// this is the first page when we click on the catgeory in the admin page
class CategoryAdmin extends StatefulWidget {
  const CategoryAdmin({super.key});

  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
   Stream? BookCatStream;
  final TextEditingController updatedmuiccatname = TextEditingController();
  File? image;

  getonload() async {
    BookCatStream = await fireDatabase().getbookcatgories();
    setState(() {});
  }

  @override
  void initState() {
    getonload();
    super.initState();
  }

  Widget addBookCatgeorydetials() {
  return StreamBuilder(
    stream: BookCatStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 125
                  
              
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  
              
                  String base64 = '${ds["BookCategoryImage"]}';
                  Uint8List bytes = base64Decode(base64);
                  Image image = Image.memory(bytes);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookCategoryDetailsAdmin(category: ds['BookCategoryName'],)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        
                       
                        decoration: BoxDecoration(
                            boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 57, 54, 54).withOpacity(0.5), // Shadow color
                            spreadRadius: 10, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: Offset(0, 3), // Offset
                          ),
                        ],
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: image.image,
                            
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        '${ds["BookCategoryName"]}',
                                        
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0, -1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBookCatgeory(ds: ds,)));
                                                      },
                                                      icon: Icon(Icons.edit)),
                                                  title: Text('Edit'),
                                                ),
                                                ListTile(
                                                  leading: IconButton(
                                                      onPressed: () async {
                                                          await fireDatabase()
                                                                    .deleteBookCategory(
                                                                        ds["Id"]);
                                                      },
                                                      icon:
                                                          Icon(Icons.delete)),
                                                  title: Text('Delete'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                          Icons.more_vert_outlined),
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          )
          : Container();
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BOOK CATEGORIES',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
floatingActionButton: FloatingActionButton(
  backgroundColor: Color.fromRGBO(255, 255, 255, 0.984),
  onPressed: () {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => AddBookCatgeory(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  },
  splashColor: Colors.grey, // Set the splash color
  elevation: 10, // Adjust elevation as needed
  child: Icon(Icons.add),
  shape: CircleBorder(),
)

,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Signup baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(child: addBookCatgeorydetials())
          ],
        ),
      ),
    );
  }
  
}