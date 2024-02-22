



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:relm/admin/addBookAdmin.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
 
 


class CatDetails extends StatefulWidget {

  final Datamodelcat data;

  const CatDetails({Key? key, required this.data,}) : super(key: key);


  @override
  _CatDetailsState createState() => _CatDetailsState();


}

class _CatDetailsState extends State<CatDetails> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addBookAdmin()));
      },child: Text('+',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 28),),),
      appBar: AppBar(
        
        title: const Text('ADMIN PANEL', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/total baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Card(
              elevation: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
              
                    height:200,
                    width: 280,
                child: Image.file(File(widget.data.catimage)),
                ),
              
              ),
            ),
            SizedBox(height: 12,),
          Text('Catgeory Name:'+widget.data.catname!,style: TextStyle(fontSize: 22,fontWeight:FontWeight.w700),),

          SizedBox(height: 16,),
          Text('List of Books in this Category',style: TextStyle(fontWeight: FontWeight.w700),),
          
          ],
        ),
      ),

    );
  }
}