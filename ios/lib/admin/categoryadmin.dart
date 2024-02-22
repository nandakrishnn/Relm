import 'dart:io';
import 'package:flutter/material.dart';
import 'package:relm/admin/addCategoryAdmin.dart';
import 'package:relm/admin/categoryDetails.dart';
import 'package:relm/admin/editCatgeory.dart';
import 'package:relm/user%20home%20screens/database/db.dart';
import 'package:relm/user%20home%20screens/database/functions.dart';

class CategoryAdmin extends StatefulWidget {
  const CategoryAdmin({Key? key}) : super(key: key);

  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}


class _CategoryAdminState extends State<CategoryAdmin> {
  @override
  void initState() {
    super.initState();
    
    // fetch();
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(63, 63, 63, 2),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddCategoryAdmin()),
          );
        },
        child: const Text('+',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,color: Colors.white)),
      ),
      appBar: AppBar(
        title: const Text('ADD CATEGORY', style: TextStyle(color: Colors.white)),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: dataListNotifiercat,
            builder:
                (BuildContext ctx, List<Datamodelcat> Datacat, Widget? child) {
              return ListView(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 170,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final data = Datacat[index];
                      return Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CatDetails(
                                              data: data,
                                            )));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: FittedBox(
                                        child:
                                            Image.file(File(data.catimage)))),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 14),
                                  child: Text(
                                    data.catname ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async{
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategory(detcat: data,)));
                                                       
                                                      },
                                                      icon: Icon(Icons.edit)),
                                                  title: Text('Edit'),
                                                ),
                                                ListTile(
                                                  leading: IconButton(
                                                      onPressed: () async {
                                                        if (data.id1 == null) {
                                                          print('id is null');
                                                        } else {
                                                        await  DelCat(data.id1!);
                                                      
                                                        // setState(() {
                                                        //   Datacat.removeAt(index);
                                                        // });
                                                        }

                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.delete)),
                                                  title: Text('Delete'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.more_vert_outlined))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: Datacat.length,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
Future<void>fetch()async{
  getAllCategories();
}
}