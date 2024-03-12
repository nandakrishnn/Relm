// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';
import 'package:relm/user%20home%20screens/last_bookpage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Stream<QuerySnapshot> getfavourites = const Stream.empty();
  String? currectId;

  @override
  void initState() {
    super.initState();
    getrecentfav();

    showfavourites();
  }

  Widget showfavourites() {
    Set<String> uniqueBookIds = Set();

    return StreamBuilder(
      stream: getfavourites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.5,
              
              child: Center(
                  child: Lottie.network(
                      'https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json',
                      height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                      )));
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Text(
                'Add Books to favourites to view here :)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )));
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;
        List<Widget> bookWidgets = [];

        documents.forEach((ds) {
          if (!uniqueBookIds.contains(ds['NameOfBook'])) {
            uniqueBookIds.add(ds['NameOfBook']);
            String bookName = ds["NameOfBook"];
            String authorName = ds["AuthorName"];
            String base64Image = ds["ImageOfBook"];
            String bookid = ds['BookId'];

            Widget bookWidget = Column(
              children: [
                const SingleChildScrollView(
                    child: SizedBox(
                  height: 10,
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookDetailsPage(
                                  ds: ds,
                                )));
                  },
                  child: Container(
                    color: const Color.fromRGBO(63, 63, 63, 90),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: SizedBox(
                                height: 100,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.memory(
                                    base64Decode(base64Image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      bookName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                          overflow: TextOverflow.ellipsis
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(authorName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                           maxLines: 1,
                                          overflow: TextOverflow.ellipsis
                                        )
                              ],
                            ),
                            // SizedBox(width: .3,),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                  child: IconButton(
                                iconSize: 32,
                                onPressed: () async {
                                  await fireDatabase()
                                      .removeFavourites(bookid, currectId!);
                                 
                                    showfavourites();
                                  setState(() {
                                    
                                  });

                                  print(currectId);
                                  print(ds['BookId']);
                                  print('deleeted');
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                )
              ],
            );

            bookWidgets.add(bookWidget);
          }
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: bookWidgets,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/relm logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'RELM',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color.fromRGBO(63, 63, 63, 5),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            getfavourites != null
                ? showfavourites()
                : Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Lottie.network(
                            'https://lottie.host/9e717c7f-05e3-4c3d-b448-1b157ffd9289/5x7fYf77wr.json')))
            // showfavourites(), // Show the favourites only when getfavourites is not null
          ],
        ),
      ),
    );
  }

  getrecentfav() async {
    User? userId = FirebaseAuth.instance.currentUser;
    String userorgibaid = userId!.uid;
    currectId = userorgibaid;
    print(currectId);
    Stream<QuerySnapshot> favouritesStream =
        await fireDatabase().getFavourites(userorgibaid);
    setState(() {
      getfavourites = favouritesStream;
    });
  }
}
