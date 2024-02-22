import 'package:flutter/material.dart';
import 'package:relm/user%20home%20screens/Music.dart';

class BiNatural extends StatefulWidget {
  const BiNatural({Key? key});

  @override
  State<BiNatural> createState() => _BiNaturalState();
}

Widget tilelist(
    {required String musicimg,
    required String authorname,
    required String musicname,
    required BuildContext context,
    Function()? move}) {
  return GestureDetector(
    onTap: () {
      move!();
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 95,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 8,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                      width: 100,
                      height: 85,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Image.asset(musicimg),
                      )),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  authorname,
                  style: const TextStyle(
                    fontSize: 18, // Adjust the font size as needed
                    fontWeight: FontWeight.bold, // Add bold style for the title
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                musicname,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class _BiNaturalState extends State<BiNatural> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/total baground.jpeg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 38,
                        shadows: [Shadow(color: Colors.black)],
                      ),
                    ),
                    const SizedBox(
                      width: 69,
                    ),
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
              const SizedBox(
                height: 14,
              ),
              tilelist(
                  musicimg: 'assets/samadi.jpeg',
                  authorname: '            Music By Ajja',
                  musicname: '         Binatural Beats 1.0',
                  context: context,
                  move: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Music()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
