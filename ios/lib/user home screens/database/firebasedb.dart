// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';

class fireDatabase{
  //catgeory section
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


//music section
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
}
