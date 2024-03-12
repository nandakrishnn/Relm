import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relm/user%20home%20screens/Music/addbokk.dart';
import 'package:relm/user%20home%20screens/Music/edit_Note.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class BookNoteAdd extends StatefulWidget {
  const BookNoteAdd({super.key});

  @override
  State<BookNoteAdd> createState() => _BookNoteAddState();
}

class _BookNoteAddState extends State<BookNoteAdd> {
  final TextEditingController seachctrl = TextEditingController();

  bool matchesSearchQuery(String query, String booktitle, String bookdes) {
    booktitle = booktitle.toLowerCase();
    bookdes = bookdes.toLowerCase();
    query = query.toLowerCase();
    return booktitle.contains(query) || bookdes.contains(query);
  } 

  @override
  void initState() {
    super.initState();
    getAllNote();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteFeild()),
          );
        },
        backgroundColor: Color.fromRGBO(63, 63, 63, 5),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
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
            SizedBox(height: 27),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
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
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: seachctrl,
                onChanged: (query) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.white,
                  filled: true,
                  hintText: 'Search..',
                  hintStyle: const TextStyle(color: Colors.white),
                  fillColor: const Color.fromRGBO(63, 63, 63, 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ),
ValueListenableBuilder(
  valueListenable: dataListNotifierNote,
  builder: (BuildContext context, List<AddNoteUser> savedNote, Widget? child) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: savedNote.length,
        itemBuilder: (context, index) {
          final data = savedNote[index];
          if (seachctrl.text.isEmpty ||
              matchesSearchQuery(seachctrl.text, data.title!, data.description!)) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                
                  child: Column(
                    children: [
                      Dismissible(
                        key: Key(data.id.toString()),
                        confirmDismiss: (direction) => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Are you sure you want to delete?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          DelNote(data.id!);
                                          savedNote.removeAt(index);
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'))
                                ],
                                shape: RoundedRectangleBorder(),
                              );
                            }),
                        onDismissed: (direction) {
                          setState(() {});
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                        child: Container(
                          // height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(163, 255, 255, 255)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.dock),
                                    Text(
                                      data.title!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditNoteScreen(
                                                      data: data,
                                                    )));
                                      },
                                      child: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12,),
                                  child: Text(
                                    data.description!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.5,
                                    ),
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        
          return Container();
        },
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }
}
