import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/musiccategories/editmusicinfo.dart';
import 'package:relm/admin/musiccategories/musicFeild.dart';
import 'package:relm/admin/musiccategories/musicfinalpage.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';

class categoryMusicList extends StatefulWidget {
  final String category;
  const categoryMusicList({Key? key, required this.category});

  @override
  State<categoryMusicList> createState() => _categoryMusicListState();
}

class _categoryMusicListState extends State<categoryMusicList> {
  Stream? MusicListStream;

  @override
  void initState() {
    super.initState();
    fetchItemsInCategory(widget.category);
    print(widget.category);
    setState(() {});
  }

  Widget buildMusicItem(DocumentSnapshot ds) {
    String base64 = '${ds["Image"]}';
    Uint8List bytes = base64Decode(base64);
    Image image = Image.memory(bytes);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
      child: Card(
        elevation: 15,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MusicPlayPage(ds: ds,)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: Colors.white38,
              height: 95,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 120,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: image,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${ds["MusicName"]}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 18,
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
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditMusicField(
                                                                ds: ds,
                                                              )));
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              title: Text('Edit'),
                                            ),
                                            ListTile(
                                              leading: IconButton(
                                                onPressed: () async {
                                                  // Show confirmation dialog
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Confirm Deletion'),
                                                        content: Text(
                                                            'Are you sure you want to delete this item?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: Text('No'),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              // Call delete function and fetchItemsInCategory if user confirms
                                                              await fireDatabase()
                                                                  .deleteMusic(
                                                                      ds['Id']);
                                                              print(
                                                                  'Deleted sucessfully');
                                                              await fetchItemsInCategory(
                                                                  widget
                                                                      .category);
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog

                                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const categoryMusicList(category: categoryMusicList)));
                                                            },
                                                            child: Text('Yes'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                              title: Text('Delete'),
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(Icons.more_vert_outlined),
                                color: Colors.black,
                              )
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${ds["MusicAuthorName"]}',
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
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(63, 63, 63, 5),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicField(
                onMusicAdded: () {
                  fetchItemsInCategory(widget.category);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        title: const Text('MUSIC LIST', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
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
            SizedBox(height: 15),
            Expanded(child: addMusicCategoryDetails()),
          ],
        ),
      ),
    );
  }

  Future<void> fetchItemsInCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("MusicDetailsListed")
          .where("CatgeoryName", isEqualTo: category)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          MusicListStream = Stream.value(querySnapshot);
        });
      } else {
        print("No documents found in the category: $category");
      }
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }
}
