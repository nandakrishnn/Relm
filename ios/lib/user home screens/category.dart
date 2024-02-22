import 'dart:io';
import 'package:flutter/material.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context){
    usercat();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Signup baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                SizedBox(height: 25),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Icon(Icons.search_rounded, color: Colors.white),
                    fillColor: Color.fromRGBO(76, 114, 115, 5),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child:  ValueListenableBuilder(
                    valueListenable:dataListNotifiercat ,
                    builder: (BuildContext context, List<Datamodelcat> Datacat,Widget? child) {
                      return  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 140,
                        
                      ),
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final data=Datacat[
                          index
                        ];
                        return Card(
                          
                          elevation: 10,
                          child: Column(
                            children: [
                              Container(
                                width: 100, // Set a specific width
                                height: 100, // Set a specific height
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  
                                ),
                                child: Image.file(File(data.catimage)), 
                              ),
                              Text(data.catname!)
                            ],
                          ),
                        );
                      },
                      itemCount: Datacat.length,
                    );
                    },
                  
                  )
                ),
              ],
            ),
          ),
        ),
      ),



    );
    
  }
  Future<void>usercat()async{
   await getAllCategories();
  }
}
