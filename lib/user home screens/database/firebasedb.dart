// ignore: camel_case_types
// ignore_for_file: await_only_futures, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class fireDatabase{
  //music catgeory section admin
  Future addMuCatgeorydetials(Map<String,dynamic>musicCatgeoryinfo,dynamic id)async{
      return await FirebaseFirestore.instance.collection("MusicCatgeory").doc(id).set(musicCatgeoryinfo);
  }
  Future<Stream<QuerySnapshot>>getmusiccatgories()async{
    return await FirebaseFirestore.instance.collection("MusicCatgeory").snapshots();
  }

  Future updateCategory(String id,Map<String,dynamic>updateInfo)async{

  return await FirebaseFirestore.instance.collection("MusicCatgeory").doc(id).update(updateInfo);
}
  Future deleteCategory(String id,)async{

  return await FirebaseFirestore.instance.collection("MusicCatgeory").doc(id).delete();
}


//music list section admin
  Future addMusicCategoryDetails(Map<String, dynamic> musicListsInfo, String ListsId) async {
    return await FirebaseFirestore.instance.collection("MusicDetailsListed").doc(ListsId).set(musicListsInfo);
  }
    Future<Stream<QuerySnapshot>> getMusicList() async {
    return await FirebaseFirestore.instance.collection("MusicDetailsListed").snapshots();
  }

  Future updatemusicdetails(String id,Map<String,dynamic>musicListsInfo)async{

  return await FirebaseFirestore.instance.collection("MusicDetailsListed").doc(id).update(musicListsInfo);
}


  Future deleteMusic(String id,)async{

  return await FirebaseFirestore.instance.collection("MusicDetailsListed").doc(id).delete();
  
}

//bookcategories admin
Future addBookCatgeorydetials(Map<String,dynamic>bokCatgeoryinfo,dynamic id)async{
      return await FirebaseFirestore.instance.collection("BookCategories").doc(id).set(bokCatgeoryinfo);
  }
  Future<Stream<QuerySnapshot>>getbookcatgories()async{
    return await FirebaseFirestore.instance.collection("BookCategories").snapshots();
  }
  Future updateBookCategory(String id,Map<String,dynamic>updateBookCat)async{

  return await FirebaseFirestore.instance.collection("BookCategories").doc(id).update(updateBookCat);
}
  Future deleteBookCategory(String id,)async{

  return await FirebaseFirestore.instance.collection("BookCategories").doc(id).delete();
  
}

//addbooks in categoris
  Future addBookdetailsinCategory(Map<String, dynamic> BookListsInfo, String ListsId) async {
    return await FirebaseFirestore.instance.collection("BooksInCatgeories").doc(ListsId).set(BookListsInfo);
  }
    Future<Stream<QuerySnapshot>>addbookcatgories()async{
    return await FirebaseFirestore.instance.collection("BooksInCatgeories").snapshots();
  }
  
  Future updateBookDeatils(String id,Map<String,dynamic>updateBookcontent)async{

  return await FirebaseFirestore.instance.collection("BooksInCatgeories").doc(id).update(updateBookcontent);
}
  Future deleteBookDetails(String id,)async{

  return await FirebaseFirestore.instance.collection("BooksInCatgeories").doc(id).delete();
  
}

//user details
Future Userdetials(Map<String,dynamic>Userinfo,dynamic id)async{
      return await FirebaseFirestore.instance.collection("UserDetails").doc(id).set(Userinfo);
  }


  Future<Stream<QuerySnapshot>>getUserDetails()async{
    return await FirebaseFirestore.instance.collection("UserDetails").snapshots();
  }

 Future updateUserDetails(String id,Map<String,dynamic>updateUser)async{

  return await FirebaseFirestore.instance.collection("UserDetails").doc(id).update(updateUser);
}

//recently viewed books

  Future addToRecentlyViewed(Map<String, dynamic> recentlyViewedAddition, String ListsId) async {
    return await FirebaseFirestore.instance.collection("RecentlyViewedBooks").doc(ListsId).set(recentlyViewedAddition);

  }
  
  Future<Stream<QuerySnapshot>> getRecentBooks(String userId) async {
  return FirebaseFirestore.instance
      .collection("RecentlyViewedBooks")
      .where("UserId", isEqualTo: userId)
      .snapshots();
}
//favourites 
Future addToFavourites(Map<String,dynamic>addFavourites,String ListsId)async{
   await FirebaseFirestore.instance.collection("Favorites").doc(ListsId).set(addFavourites);
}
Future<Stream<QuerySnapshot>>getFavourites(String userId)async{
  return FirebaseFirestore.instance.collection("Favorites").where("UserId",isEqualTo: userId).snapshots();
}

  Future removeFavourites(String Bookid,String UserId)async{
  return await FirebaseFirestore.instance.collection("Favorites").doc(Bookid).delete();
}
Future favouritesRemove(String bookName,String UserId,String authorName)async{
 try{
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection('Favorites').where("NameOfBook",isEqualTo:bookName ).where("AuthorName",isEqualTo: authorName).where("UserId",isEqualTo: UserId).get();
    if(querySnapshot.docs.isNotEmpty){
      
      for(DocumentSnapshot doc in querySnapshot.docs){
        await doc.reference.delete();
      }
    }
    else{
      print('No matching documet')
;    }
 }
 catch(e){
print(e);
 }
}
}







