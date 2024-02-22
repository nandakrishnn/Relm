import 'package:flutter/material.dart';
import 'package:relm/Login.dart';

class profileAdmin extends StatelessWidget {
  const profileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          ElevatedButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
          }, child: Text('signout'))
          ],
        ),
      ),
    );
  }
}