import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/categoryadmin/BookDetails.dart';
import 'package:relm/admin/categoryadmin/Bookfeildadmin.dart';
import 'package:relm/admin/categoryadmin/editbookdetails.dart';


//the page which shows the books in diffrent categories

class BookCategoryDetailsAdmin extends StatefulWidget {
  final String category;
  const BookCategoryDetailsAdmin({super.key, required this.category});

  @override
  State<BookCategoryDetailsAdmin> createState() => _BookCategoryDetailsAdminState();
}

class _BookCategoryDetailsAdminState extends State<BookCategoryDetailsAdmin> {
 Stream? BookinCAtegoriesStream;
 late var mainid;

  @override
  void initState() {
    super.initState();

   fetchItemsInCategory(widget.category);
   
    print(widget.category);
    setState(() {});
  }

  Widget buildBookItem(DocumentSnapshot ds) {
    String base64 = '${ds["ImageOfBook"]}';
    Uint8List bytes = base64Decode(base64);
    print(ds.id);
    Image image = Image.memory(bytes);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
      child: Material(
        elevation: 12,
        shadowColor: Color.fromRGBO(56, 38, 38, 0.984),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookDetailsAdmin(ds: ds,)));
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
                        padding: const EdgeInsets.only(left: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: image,
                        ),
                      ),
                    ),
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
                                '${ds["NameOfBook"]}',
                                 overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 4,
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
                                                  Navigator.of(context).pop();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditBookDetails(
                                                                ds: ds,
                                                                category1: widget.category,
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
                                                             Navigator.of(context).pop();
                                                            },
                                                            child: Text('No'),
                                                            
                                                          ),
                                                       TextButton(
                                                            onPressed:
                                                                () async {
                                                              // Call delete function and fetchItemsInCategory if user confirms
                                                              // await fireDatabase()
                                                              //     .deleteBookCategory(
                                                              //         "${ds['Id']}");
        
                                                              deleteDocument("BooksInCatgeories",ds['Id']);
                                                              print('hi');
                                                              print(widget.category+'hey');
                                                              print(
                                                                  ds['Id']);
                                                              await fetchItemsInCategory(
                                                                  widget
                                                                      .category);
                                                              setState(() {
                                                                 Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              });
                                                              // Close the dialog
        
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
    );
  }

  Widget addBookinCategoryDetails() {
    return StreamBuilder(
      stream:  BookinCAtegoriesStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs;
          return Column(
            children: documents.map((ds) => buildBookItem(ds)).toList(),
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
              builder: (context) => BookField(
                onBookAdded: () {
                  fetchItemsInCategory(widget.category);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        title:  Text(widget.category, style: TextStyle(color: Colors.white)),
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
            Expanded(child: addBookinCategoryDetails()),
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
  Future<void> deleteDocument(String collectionName, String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .delete();
    print('Document deleted successfully');
    await fetchItemsInCategory(widget.category);
  } catch (e) {
    print('Error deleting document: $e');
  }
  }

}