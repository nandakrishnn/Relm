import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:relm/admin/categoryadmin/playaudioadmin.dart';
import 'package:relm/admin/categoryadmin/viewpdf.dart';
import 'package:relm/user%20home%20screens/Music/playBookAudio,.dart';

class BookDetailsAdmin extends StatefulWidget {
  final DocumentSnapshot ds;
  const BookDetailsAdmin({Key? key, required this.ds}) : super(key: key);
  @override
  State<BookDetailsAdmin> createState() => _BookDetailsAdminState();
}

class _BookDetailsAdminState extends State<BookDetailsAdmin> {
  late bool isFavorite = false;
  Uint8List? bytes;
  Uint8List? bytesauth;
  String?imageUrl;
  String?bookname;
  String?bookaudio;
  String?authorname;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.ds['ImageOfBook'];

    bytes = base64Decode(imageUrl!);

    String imageUrlauth = widget.ds['ImageOfAuthor'];

    bytesauth = base64Decode(imageUrlauth);
    bookname=widget.ds['NameOfBook'];
    bookaudio=widget.ds['AudioUrl'];
    authorname=widget.ds['AuthorName'];
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
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
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 350,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 35, 26, 26)
                                  .withOpacity(0.5),
                              spreadRadius: 7,
                              blurRadius: 15,
                              offset: const Offset(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                            offset: const Offset(2, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                        decoration: TextDecoration.none,

                                        wordSpacing: 2.0,

                                        color: Colors
                                            .black, // Change text color to black
                                        letterSpacing: 0.3,
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
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              minimumSize: const Size(55, 55),
                              elevation: 10,
                            ),
                            child: const Icon(FeatherIcons.bookOpen),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>PlayBookAudio(
                                         bookimage: imageUrl!,
                                         Bookname: bookname!,
                                         bookaudio: bookaudio!,
                                         authorname: authorname!,
                                          )));
                            },
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
                          const SizedBox(
                            width: 2,
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
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 51, 49, 49),
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Adjust height as needed
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Center(
                                                child: Text("Book Details",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const SizedBox(height: 10),
                                            Center(
                                              child: Text(
                                                "${widget.ds['NameOfBook']}",
                                                style: const TextStyle(
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
                                              padding:
                                                  const EdgeInsets.all(11.0),
                                              child: Text(
                                                '${widget.ds['BookDescription']}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    letterSpacing: 0.3,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            const Center(
                                              child: Text(
                                                'ABOUT THE AUTHOR',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Center(
                                              child: Text(
                                                '${widget.ds['AuthorName']}',
                                                style: const TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.bold,
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
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child:
                                                    Image.memory(bytesauth!)),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(11.0),
                                              child: Text(
                                                '${widget.ds['AuthorDescription']}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  // Change text color to black
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                            ),
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
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
