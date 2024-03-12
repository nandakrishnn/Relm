import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:relm/user%20home%20screens/database/firebasedb.dart';
import 'package:relm/user%20home%20screens/view_musicincat.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicCategoryAdminState();
}

class _MusicCategoryAdminState extends State<Music> {
  Stream? musicCatStream;

  void initState() {
    super.initState();
    getonload();
  }

  void getonload() async {
    final stream = await fireDatabase().getmusiccatgories();
    if (mounted) {
      setState(() {
        musicCatStream = stream;
      });
    }
  }

  Widget addMuCatgeorydetials() {
    return StreamBuilder(
      stream: musicCatStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  String base64 = '${ds["Image"]}';
                  Uint8List bytes = base64Decode(base64);
                  Image image = Image.memory(bytes);
                  return Padding(
                    padding: const EdgeInsets.only(left: 14, right: 12),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewCatMusic(
                                          category: ds['MusicCategoryName'],
                                        )));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .27,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Darker shadow color
                                    blurRadius: 10, // Increase the blur radius
                                    spreadRadius:
                                        4, // Increase the spread radius
                                    offset: Offset(5,
                                        5), // Adjust the offset to control the shadow direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: image.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '${ds["MusicCategoryName"]}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0, -3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: SizedBox(
                      child: Center(
                        child: Lottie.network(
                          'https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json',
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    )),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            Expanded(child: addMuCatgeorydetials())
          ],
        ),
      ),
    );
  }
}
