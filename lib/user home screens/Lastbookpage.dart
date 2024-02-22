import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:relm/admin/categoryadmin/viewpdf.dart';
import 'package:relm/user%20home%20screens/Music/noteBook.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDetailsPage extends StatefulWidget {
  final DocumentSnapshot ds;
  const BookDetailsPage({Key? key, required this.ds}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
    late bool isFavorite = false;
  Uint8List? bytes;
  Uint8List? bytesauth;


    @override
  void initState() {
    super.initState();
    loadFavoriteState();
    String imageUrl = widget.ds['ImageOfBook'];
    print(imageUrl);

    bytes = base64Decode(imageUrl);

    String imageUrlauth = widget.ds['ImageOfAuthor'];
    print(imageUrl);

    bytesauth = base64Decode(imageUrlauth);
  }
    Future<void> loadFavoriteState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('isFavorite${widget.ds.id}') ?? false;
    });
  }

  Future<void> saveFavoriteState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFavorite${widget.ds.id}', value);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/total baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 270,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
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
                                      offset: Offset(0, 3),
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
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 350,
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:  Color.fromARGB(255, 35, 26, 26)
                                          .withOpacity(0.5),
                                      spreadRadius: 7,
                                      blurRadius: 15,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.memory(bytes!, fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text(
                                              '${widget.ds['NameOfBook']}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontStyle: FontStyle.italic,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.grey.withOpacity(
                                                        0.5), // Set shadow color and opacity
                                                    offset: Offset(2, 2),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                                decoration: TextDecoration.none,
                    
                                                wordSpacing: 2.0,
                    
                                                color: Colors
                                                    .black, // Change text color to black
                                                letterSpacing: 0.3,
                                                // shadows: [
                                                //   Shadow(
                                                //     color: Colors
                                                //         .white, // Change shadow color to white
                                                //     offset: Offset(1, -1),
                                                //     blurRadius: 3,
                                                //   ),
                                                // ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PDFViewerPage(
                                                  pdfUrl: widget.ds['PdfUrl'])));
                                    },
                                    child: const Icon(FeatherIcons.bookOpen),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(55, 55),
                                      elevation: 10,
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(FeatherIcons.music),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(55, 55),
                                      elevation: 10,
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isFavorite =
                                            !isFavorite; // Toggle favorite state
                                      });
                                      await saveFavoriteState(isFavorite);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: isFavorite ? Colors.red : null,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(55, 55),
                                      elevation: 10,
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookNoteAdd()));
                                    },
                                    child: const Icon(Icons.edit),
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: const Color.fromARGB(255, 43, 40, 40),
                                      
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(55, 55),
                                      elevation: 10,
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Container(
                                                color: const Color.fromARGB(
                                                    255, 51, 49, 49),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width, // Adjust height as needed
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                        child: Text("Book Details",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    SizedBox(height: 10),
                                                    Center(
                                                      child: Text(
                                                        "${widget.ds['NameOfBook']}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 0.3,
                                                          fontSize: 23,
                                                          shadows: [
                                                            Shadow(
                                                              color: Colors
                                                                  .white, // Change shadow color to white
                                                              offset: Offset(1, 1),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(
                                                          11.0),
                                                      child: Text(
                                                        '${widget.ds['BookDescription']}',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            letterSpacing: 0.3,
                                                            fontStyle:
                                                                FontStyle.italic),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'ABOUT THE AUTHOR',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          letterSpacing: 0.5,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        '${widget.ds['AuthorName']}',
                                                        style: TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.white,
                                                          letterSpacing: 0.5,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          shadows: [
                                                            Shadow(
                                                              color: Colors
                                                                  .white, // Change shadow color to white
                                                              offset: Offset(1, 1),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(12)),
                                                        child: Image.memory(
                                                            bytesauth!)),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(
                                                          11.0),
                                                      child: Text(
                                                        '${widget.ds['AuthorDescription']}',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          // Change text color to black
                                                          letterSpacing: 0.3,
                                                          // shadows: [
                                                          //   Shadow(
                                                          //     color: Colors
                                                          //         .white, // Change shadow color to white
                                                          //     offset: Offset(1, 1),
                                                          //     blurRadius: 3,
                                                          //   ),
                                                          // ],
                                                        ),
                                                      ),
                                                    ),
                                                    //  Text(
                                                    //   ' ${widget.ds['CatgeoryName']}',
                                                    //   style: TextStyle(
                                                    //     fontSize: 17,
                                                    //     color: Colors.black87,
                                                    //     letterSpacing: 0.5,
                                                    //     fontWeight: FontWeight.bold,
                                                    //   ),
                                                    // ),
                    
                                                    // Text(
                                                    //     "Category: ${widget.ds['CatgeoryName']}"),
                                                    // Add more details as needed
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(Icons.info_outline),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      minimumSize: const Size(55, 55),
                                      elevation: 10,
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
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
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}