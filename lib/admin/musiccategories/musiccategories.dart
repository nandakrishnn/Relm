// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/musiccategories/AdMusicCatAdmin.dart';
import 'package:relm/admin/musiccategories/editcatgeorymusic.dart';
import 'package:relm/admin/musiccategories/musicincategories.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class MusicCategoryAdmin extends StatefulWidget {
  const MusicCategoryAdmin({super.key});

  @override
  State<MusicCategoryAdmin> createState() => _MusicCategoryAdminState();
}

class _MusicCategoryAdminState extends State<MusicCategoryAdmin> {
  Stream? MusicCatStream;
  final TextEditingController updatedmuiccatname = TextEditingController();
  File? image;

  getonload() async {
    MusicCatStream = await fireDatabase().getmusiccatgories();
    setState(() {});
  }

  @override
  void initState() {
    getonload();
    super.initState();
  }

  Widget addMuCatgeorydetials() {
    return StreamBuilder(
      stream: MusicCatStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  String base64 = '${ds["Image"]}';
                  Uint8List bytes = base64Decode(base64);
                  Image image = Image.memory(bytes);
                  // String orgid=ds['ID'];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryMusicList(category: ds['MusicCategoryName'],)));
                        },
                        child: Card(
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
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
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            child: Text(
                                              '${ds["MusicCategoryName"]}',
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          leading: IconButton(
                                                              onPressed: () {
                                                                updatedmuiccatname
                                                                        .text =
                                                                    ds["MusicCategoryName"];
                                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>editMusicCat(orgid)));
                                                                //  editCatgeorydetail(ds["Id"]);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => EditCatMusic(
                                                                              ds: ds,
                                                                            )));
                                                                            //  Navigator.pop(context);
                                                              },
                                                              icon: Icon(Icons
                                                                  .edit)),
                                                          title: Text('Edit'),
                                                        ),
                                                        ListTile(
                                                          leading: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await fireDatabase()
                                                                    .deleteCategory(
                                                                        ds["Id"]);
                                                                        Future.delayed(Duration(milliseconds:500 ));
                                                                        setState(() {
                                                                          
                                                                        });
                                                                         Navigator.pop(context);
                                                              },
                                                              
                                                              icon: Icon(Icons
                                                                  .delete)),
                                                          title:
                                                              Text('Delete'),
                                                        )
                                                      ],
                                                    );
                                                  });
                      
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
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
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
          'MUSIC CATEGORIES',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMusCatAdmin()));
        },
        child: Icon(Icons.add),
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
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(child: addMuCatgeorydetials())
          ],
        ),
      ),
    );
  }
}
