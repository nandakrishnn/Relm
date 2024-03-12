import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/musiccategories/musicfinalpage.dart';

class ViewCatMusic extends StatefulWidget {
  final String category;
  const ViewCatMusic({super.key, required this.category});

  @override
  State<ViewCatMusic> createState() => _ViewCatMusicState();
}

class _ViewCatMusicState extends State<ViewCatMusic> {
  Stream? MusicListStream;

  @override
  void initState() {
    super.initState();
    fetchItemsInCategory(widget.category);
    print(widget.category);
    // Fetch items in the "demo" category
  }

  Widget buildMusicItem(DocumentSnapshot ds) {
    
    String base64 = '${ds["Image"]}';
    Uint8List bytes = base64Decode(base64);
    Image image = Image.memory(bytes);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MusicPlayPage(
                      ds: ds,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(48, 0, 0, 0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                blurRadius: 10, // Soften the shadow
                spreadRadius: 5, // Extend the shadow
                offset: Offset(0, 3), // Offset of the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: Color.fromARGB(28, 35, 34, 34),
              height: 95,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: image,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${ds["MusicName"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${ds["MusicAuthorName"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
    
  }


  Widget addMusicCategoryDetails() {
    
    return StreamBuilder(
      stream: MusicListStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs;
          return Column(
            children: documents.map((ds) => buildMusicItem(ds)).toList(),
          );
        } else {
          return Container(
            child: const Center(
                child: Text(
              'Music Comming Soon :)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
          );
        }
      },
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:CustomAppBar(),
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
            const SizedBox(height: 27),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 270,
                  // color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
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
            const SizedBox(height: 15),
            Expanded(child: addMusicCategoryDetails()),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }

 void fetchItemsInCategory(String category) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("MusicDetailsListed")
        .where("CatgeoryName", isEqualTo: category)
        .get();

    if (querySnapshot.docs.isNotEmpty && mounted) {
      setState(() {
        MusicListStream = Stream.value(querySnapshot);
      });
    } else {
      if (mounted) {
        setState(() {
          MusicListStream = Stream.value(null);
        });
      }
    }
  } catch (e) {
    print("Error fetching documents: $e");
  }
}

}
