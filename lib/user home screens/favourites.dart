import 'package:flutter/material.dart';
import 'package:relm/user%20home%20screens/Lastbookpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<DocumentSnapshot> favoriteBooks = []; // Store document snapshots

  @override
  void initState() {
    super.initState();
    loadFavoriteBooks();
  }

  Future<void> loadFavoriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favoriteBookIds');
    if (savedFavorites != null) {
      setState(() {
        favoriteBooks = []; // Clear existing favorite books
        // Fetch the document snapshots of favorite books from Firestore
        savedFavorites.forEach((bookId) {
          FirebaseFirestore.instance
              .collection('BooksInCatgeories') // Replace 'books' with your collection name
              .doc(bookId)
              .get()
              .then((snapshot) {
            setState(() {
              favoriteBooks.add(snapshot);
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Favorites'),
      // ),
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          // Here you can retrieve the details of each favorite book and display them
          String bookTitle = favoriteBooks[index]['NameOfBook'];
           String bookSubTitle = favoriteBooks[index]['AuthorName']; // Example: Replace 'title' with your field name
          return ListTile(
            title: Text(bookTitle),
            subtitle:Text(bookSubTitle) ,
            onTap: () {
              // Navigate to the details page with the document snapshot of the favorite book
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(ds: favoriteBooks[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
