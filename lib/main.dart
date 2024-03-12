import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relm/firebase_options.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/splash/splash_Screen.dart';

Future<void> initializeHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter<AddNoteUser>(AddNoteUserAdapter());

  await Hive.openBox<AddNoteUser>('BookNote');
}

void main() async {
  await initializeHive();
    // await initPathProvider();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato'),
      home: splash(),
    );
  }

Future initPathProvider()async{
  
}
}