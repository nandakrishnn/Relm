import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:relm/user%20home%20screens/last_bookpage.dart';
import 'package:http/http.dart' as http;


class RecentlyViewedWidget {
  static Widget build(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<DocumentSnapshot> documents = snapshot.data.docs ?? [];
      documents.sort((a, b) => b['Timestamp'].compareTo(a['Timestamp']));

      LinkedHashMap<String, Widget> uniqueBooks = LinkedHashMap();

      for (var doc in documents) {
        String bookId = doc['NameOfBook'];
        String imageUrl = doc['ImageOfBook'];

        if (uniqueBooks.containsKey(bookId)) {
          // Duplicate book, handle as needed
        } else {
          uniqueBooks[bookId] = _buildBookWidget(context, doc, imageUrl);
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
              child: Container(
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
  }

  static Widget _buildBookWidget(
      BuildContext context, DocumentSnapshot doc, String imageUrl) {
    return GestureDetector(
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
                              child: FutureBuilder(
                                future: _getImage(imageUrl),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error');
                                    } else {
                                      return Image.memory(
                                        snapshot.data!,
                                        height: 175,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

static Future<Uint8List> _getImage(String imageUrl) async {
  final File file = await DefaultCacheManager().getSingleFile(imageUrl);
  if (file.existsSync()) {
    // If image exists in cache, return cached image
    return await file.readAsBytes();
  } else {
    // If image doesn't exist in cache, fetch it from network and save to cache
    http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List bytes = response.bodyBytes;
    await file.writeAsBytes(bytes);
    return bytes;
  }
}

}
