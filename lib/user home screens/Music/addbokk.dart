import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/categoryadmin/addnewbookcatgeory.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class NoteFeild extends StatefulWidget {
  const NoteFeild({super.key});

  @override
  State<NoteFeild> createState() => _NoteFeildState();
}

class _NoteFeildState extends State<NoteFeild> {
  final TextEditingController titlecontrol = TextEditingController();
  final TextEditingController descontrol = TextEditingController();
  final GlobalKey<FormState> formKeyNote = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Signup baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 27,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 270,
                      // color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                          //  SizedBox(width: 50,),
                          Row(
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
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Card(
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 250,
                              child: Image.asset('assets/note1.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Form(
                          key: formKeyNote,
                          child: Column(
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 35,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Add a title to continue';
                                  }
                                  return null;
                                },

                                // controller: musicAuthor,
                                controller: titlecontrol,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.title_rounded),
                                  labelText: 'Title',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                 if (value == null || value.isEmpty) {
                                    return 'Add a Description to continue';
                                  }
                                  return null;
                                },
                                maxLines: null,
                                controller: descontrol,
                                // controller: musicAuthor,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.description),
                                  labelText: 'Description',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKeyNote.currentState!.validate()) {
                                    onsaved();
                                    Navigator.pop(context);
                                  }
                                  // if(formkey1.currentState!.validate())
                                  // Call validate() to trigger form validation
                                },
                                child: Text(
                                  'Save ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(63, 63, 63, 5)),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                        vertical:
                                            14.0), // Adjust padding as needed
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onsaved() async {
    final titlesaved = titlecontrol.text;
    final dessaved = descontrol.text;
    final datasaved = AddNoteUser(description: dessaved, title: titlesaved);
    addNote(datasaved);
  }
}
