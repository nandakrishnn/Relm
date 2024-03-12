import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:relm/user%20home%20screens/last_bookpage.dart';

class BookCategoryDetails extends StatefulWidget {
  final String category;
  const BookCategoryDetails({Key? key, required this.category});

  @override
  State<BookCategoryDetails> createState() => _BookCategoryDetailsState();
}

class _BookCategoryDetailsState extends State<BookCategoryDetails> {
  Stream? BookinCAtegoriesStream;
  final TextEditingController searchcontrol = TextEditingController();
  final FocusNode searchnode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchItemsInCategory(widget.category);
    print(widget.category);
  }

  @override
  void dispose() {
    searchcontrol.dispose();
    super.dispose();
  }

  Widget buildBookItem(DocumentSnapshot ds) {
    String base64 = '${ds["ImageOfBook"]}';
    Uint8List bytes = base64Decode(base64);
    Image image = Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
    String authorDescription = ds["AuthorDescription"];
    String authorName = ds["AuthorName"];
    String bookDescription = ds["BookDescription"];
    String authorimage = ds["ImageOfAuthor"];
    String bookImage = ds["ImageOfBook"];
    String nameOfBook = ds["NameOfBook"];
    String pdfofbook = ds["PdfUrl"];
    String bookCategory = ds["CatgeoryName"];
    String bookaudio = ds["AudioUrl"];

    bool matchesSearchQuery(String query) {
      String bookName = ds["NameOfBook"].toString().toLowerCase();
      String authorName = ds["AuthorName"].toString().toLowerCase();
      query = query.toLowerCase();
      return bookName.contains(query) || authorName.contains(query);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          if (searchcontrol.text.isEmpty ||
              matchesSearchQuery(searchcontrol.text))
            Card(
              elevation: 15,
              child: GestureDetector(
                onTap: () {
                  // Add book details to Firestore
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
                        builder: (context) => BookDetailsPage(ds: ds),
                      ),
                    );
                  }).catchError((error) {
                    print("Failed to add book details: $error");
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 115,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${ds["NameOfBook"]}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${ds["AuthorName"]}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
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
        ],
      ),
    );
  }

  Widget addBookinCategoryDetails() {
    return StreamBuilder(
      stream: BookinCAtegoriesStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs;
          return Column(
            children: documents.map((ds) => buildBookItem(ds)).toList(),
          );
        } else {
          return Container(
            child: Text('Book Comming Soon :)'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          searchnode.unfocus();
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Signup baground.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 255,
                        // color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back)),
                            //  SizedBox(width: 50,),
                            Row(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            focusNode: searchnode,
                            controller: searchcontrol,
                            onChanged: (query) {
                              setState(
                                  () {}); // Update the UI when search query changes
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.white,
                              filled: true,
                              hintText: 'Search..',
                              hintStyle: const TextStyle(color: Colors.white),
                              fillColor: const Color.fromRGBO(63, 63, 63, 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        StreamBuilder(
                          stream: BookinCAtegoriesStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot> documents =
                                  snapshot.data.docs;
                              return Column(
                                children: documents
                                    .map((ds) => buildBookItem(ds))
                                    .toList(),
                              );
                            } else {
                              return Center(
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Center(
                                          child: Lottie.network(
                                        'https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      )),
                                    )),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchItemsInCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("BooksInCatgeories")
          .where("CatgeoryName", isEqualTo: category)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          BookinCAtegoriesStream = Stream.value(querySnapshot);
        });
      } else {
        print("No documents found in the category: $category");
      }
    } catch (e) {
      print("Error fetching documents: $e");
    }
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
