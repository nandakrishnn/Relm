import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MusicPlayPage extends StatefulWidget {
  final DocumentSnapshot ds;
  const MusicPlayPage({Key? key, required this.ds}) : super(key: key);


  @override
  State<MusicPlayPage> createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState
        String imageUrl = widget.ds['Image'];
      
    bytes = base64Decode(imageUrl);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        title: const Text('PLAY MUSIC', style: TextStyle(color: Colors.white)),
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
            // mainAxisAlignment: MainAxisAlignment.center
            
            children: [
              // SizedBox(height: 36,),
              Container(
                height: 280,
                width: 230,
                // color: Colors.amber,
                child: Image.memory(bytes!),
              ),
              Text(widget.ds['MusicName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              SizedBox(height: 4,),
              Text(widget.ds['MusicAuthorName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold))
            ],
          ),
      ),
    );
  }
}

