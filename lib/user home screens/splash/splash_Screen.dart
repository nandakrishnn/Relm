import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:relm/Login.dart';
import 'package:relm/user%20home%20screens/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

const saveKey = 'isLoggedIn';

// ignore: camel_case_types
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => splashState();
}

// ignore: camel_case_types
class splashState extends State<splash> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child:Lottie.network('https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json')
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotologin() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> checkUser() async {
    final shared = await SharedPreferences.getInstance();
    final userlogged = shared.getBool(saveKey);
    if (userlogged == null || userlogged == false) {

      gotologin();

    } else {
          // await Future.delayed(const Duration(milliseconds: 2600));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }
}