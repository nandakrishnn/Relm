import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relm/Login.dart';
import 'package:relm/firebase_options.dart';
import 'package:relm/user%20home%20screens/database/db.dart';

Future<void> initializeHive() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
 

  // Check if the box is already open before attempting to open it
    


}


void main() async {
 
  await initializeHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
