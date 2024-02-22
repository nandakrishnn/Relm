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
        print(imageUrl);
      
    bytes = base64Decode(imageUrl);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        title:  Text(widget.ds['MusicName'], style: TextStyle(color: Colors.white)),
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
              SizedBox(height: 60,),
              Container(
                height: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 15,
                    offset: Offset(4, 4)

                  ),
                  BoxShadow(
                     color: Colors.grey.shade500,
                    blurRadius: 15,
                    offset: Offset(-4, -4)
                  )
                ]
              ),
                child:  Image.memory(bytes!),
              ),
                      SizedBox(height: 3,),
             Text(
  widget.ds['MusicName'],
  style: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Change the text color as needed
    shadows: [
      Shadow(
        color: Colors.grey.withOpacity(0.5), // Set shadow color and opacity
        offset: Offset(2, 2), // Set shadow offset
        blurRadius: 2, // Set shadow blur radius
      ),
    ],
    decoration: TextDecoration.underline, // Add underline decoration
    decorationColor: Colors.blue, // Set underline color
    decorationStyle: TextDecorationStyle.solid, // Set underline style
    letterSpacing: 1.5, // Adjust letter spacing as needed
    wordSpacing: 2.0, // Adjust word spacing as needed
    fontStyle: FontStyle.italic, // Apply italic font style
    // fontFamily: 'Roboto', // Specify custom font family
    // shadows: [
    //   // Shadow(
    //   //   color: Colors.black,
    //   //   offset: Offset(1, 1),
    //   //   blurRadius: 3,
    //   // ),
    // ],
  ),
),

              SizedBox(height: 5,),
             Text(
  widget.ds['MusicAuthorName'],
  style: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    shadows: [
      Shadow(
        color: Colors.grey.withOpacity(0.5), // Set shadow color and opacity
        offset: Offset(2, 2),   blurRadius: 2,
      ),
    ],
    decoration: TextDecoration.none, 
    letterSpacing: 1.0, 
    wordSpacing: 2.0, 
    fontStyle: FontStyle.normal, 
    fontFamily: 'Roboto', 
    // shadows: [
    //   Shadow(
    //     color: Colors.black,
    //     offset: Offset(1, 1),
    //     blurRadius: 3,
    //   ),
    // ],
  ),
),

              // // Text(widget.ds['MusicName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              // Card(
              //   elevation: 12,
              //   child: Container(
              //     height: 280,
              //     width: 230,
              //     // color: Colors.amber,
              //     // child: Image.memory(bytes!),
              //   ),
              // ),
              //  SizedBox(height: 14,),
              // // Text(widget.ds['MusicName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              // SizedBox(height: 4,),
              // Text(widget.ds['MusicAuthorName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
              // Slider(min:0,
              // max: 100,
              // value: 40,
              // onChanged: (value){},
              // activeColor: Colors.white,
              // inactiveColor: Colors.white54,

              
              // )
            
            ],
          ),
      ),
    );
  }

   // Text(widget.ds['MusicName'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
             
}

