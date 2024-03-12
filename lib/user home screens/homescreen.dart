import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:relm/admin/musiccategories/musicfinalpage.dart';

import 'package:relm/user%20home%20screens/database/firebasedb.dart';
import 'package:relm/user%20home%20screens/last_bookpage.dart';

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  Stream? recentlyViewed;
  Stream? topRated;
  Stream? topRatedMusic;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchMusicSortedByRating();
      fetchBooksSortedByRating();
      viewRecentlyWatched();
    }
  }

  @override
  void dispose() {
    super.dispose();
    recentlyViewed = null;
    topRated = null;
    topRatedMusic = null;
  }

  Widget seeRecentlyWatched() {
    return StreamBuilder(
      stream: recentlyViewed,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs ?? [];
          documents.sort((a, b) => b['Timestamp'].compareTo(a['Timestamp']));
          LinkedHashMap<String, Widget> uniqueBooks = LinkedHashMap();

          for (var doc in documents) {
            String bookId = doc['NameOfBook'];

            if (uniqueBooks.containsKey(bookId)) {
              uniqueBooks[bookId] = GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsPage(ds: doc),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 0),
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Center(
                                child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: Image.memory(
                                        base64Decode(doc['ImageOfBook']),
                                        height: 175,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      doc['NameOfBook'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              uniqueBooks[bookId] = GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsPage(ds: doc),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 0),
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Center(
                                child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: Image.memory(
                                        base64Decode(doc['ImageOfBook']),
                                        height: 175,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      doc['NameOfBook'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          List<Widget> bookWidgets = uniqueBooks.values.toList();
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 2.5,
                          left: 2.5,
                          child: Text(
                            'Recently Viewed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // Main text
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: bookWidgets,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

//   Widget seeRecentlyWatched() {
//  return StreamBuilder(
//     stream: recentlyViewed,
//     builder: (context, snapshot) {
//       return RecentlyViewedWidget.build(context, snapshot);
//     },
//   );
//   }

  Widget topRatedBooks() {
    return StreamBuilder(
      stream: topRated,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> topRatedBooks = snapshot.data ?? [];

          return Column(
            children: [
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Stack(
                    children: [
                      Positioned(
                        top: 2.5,
                        left: 2.5,
                        child: Text(
                          'Top Rated Books',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Main text
                      Text(
                        'Top Rated Books',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topRatedBooks.map((doc) {
                    String authorDescription = doc["AuthorDescription"];
                    String authorName = doc["AuthorName"];
                    String bookDescription = doc["BookDescription"];
                    String authorimage = doc["ImageOfAuthor"];
                    String bookImage = doc["ImageOfBook"];
                    String nameOfBook = doc["NameOfBook"];
                    String pdfofbook = doc["PdfUrl"];
                    String bookCategory = doc["CatgeoryName"];
                    String bookaudio = doc["AudioUrl"];

                    return GestureDetector(
                      onTap: () {
                        String userId = getCurrentUserId();
                        FirebaseFirestore.instance
                            .collection('RecentlyViewedBooks')
                            .add({
                          'UserId': userId,
                          'AuthorDescription': authorDescription,
                          'AuthorName': authorName,
                          'BookDescription': bookDescription,
                          'ImageOfAuthor': authorimage,
                          'ImageOfBook': bookImage,
                          'NameOfBook': nameOfBook,
                          'PdfUrl': pdfofbook,
                          'Timestamp': DateTime.now(),
                          'CatgeoryName': bookCategory,
                          'AudioUrl': bookaudio
                        }).then((value) {
                          // After adding the book details, navigate to the BookDetailsPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailsPage(ds: doc),
                            ),
                          );
                        }).catchError((error) {
                          print("Failed to add book details: $error");
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.memory(
                                base64Decode(doc['ImageOfBook']),
                                height: 180,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                doc['NameOfBook'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget topMusic() {
    return StreamBuilder(
      stream: topRatedMusic,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> topRatedMusic = snapshot.data ?? [];
          return Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Stack(
                    children: [
                      Positioned(
                        top: 2,
                        left: 2,
                        child: Text(
                          'Top Rated Music',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Main text
                      Text(
                        'Top Rated Music',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topRatedMusic.map((doc) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayPage(
                              ds: doc,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: const BoxDecoration(),
                          margin: const EdgeInsets.all(8),
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: [],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(doc['Image']),
                                            height: 160,
                                            width: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        doc['MusicAuthorName'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(width: 20,)
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading =
        recentlyViewed == null || topRated == null || topRatedMusic == null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 27,
                ),
                Row(
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
                if (isLoading)
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Lottie.network(
                          'https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json',
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      topRatedBooks(),
                      topMusic(),
                      seeRecentlyWatched(),
                      const SizedBox(
                        height: 80,
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

  viewRecentlyWatched() async {
    User? userId = FirebaseAuth.instance.currentUser;
    String userrealid = userId!.uid;
    recentlyViewed = await fireDatabase().getRecentBooks(userrealid);
    setState(() {});
  }

  fetchBooksSortedByRating() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BooksInCatgeories')
        .orderBy('Bookrating', descending: true)
        .limit(4)
        .get();

    List<DocumentSnapshot> docs = querySnapshot.docs ?? [];
    docs.sort((a, b) {
      double ratingA = double.tryParse(a['Bookrating'] ?? '0') ?? 0;
      double ratingB = double.tryParse(b['Bookrating'] ?? '0') ?? 0;
      return ratingB.compareTo(ratingA);
    });

    setState(() {
      topRated = Stream.value(docs);
    });
  }

  fetchMusicSortedByRating() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('MusicDetailsListed')
        .orderBy('Rating', descending: true)
        .limit(4)
        .get();

    List<DocumentSnapshot> docs = querySnapshot.docs;
    docs.sort((a, b) {
      double ratingA = double.tryParse(a['Rating'] ?? '0') ?? 0;
      double ratingB = double.tryParse(b['Rating'] ?? '0') ?? 0;
      return ratingB.compareTo(ratingA);
    });

    setState(() {
      topRatedMusic = Stream.value(docs);
    });
  }

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }
}
