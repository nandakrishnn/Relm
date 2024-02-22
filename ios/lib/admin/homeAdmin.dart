import 'package:flutter/material.dart';
import 'package:relm/admin/categoryadmin.dart';
import 'package:relm/admin/musiccategories/musiccategories.dart';
import 'package:relm/admin/profileScreen.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ADMIN PANEL',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(63, 63, 63, 2),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, 
       unselectedItemColor: Color.fromRGBO(63, 63, 63, 5),
        onTap: (value) {
          // Navigate to the appropriate screen based on the tapped tab
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profileAdmin()),
            );
          }
        },
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
        child: SingleChildScrollView(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
             Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryAdmin()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child:Container(
                        height: 230,
                        width: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/category.jpg'),fit:BoxFit.cover)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18,),
                  GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MusicCategoryAdmin()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child:Container(
                    height: 230,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/musiccover.jpg'),fit:BoxFit.cover)
                    ),
                  ),
                ),
              ),
                ],
              ),
          
             )
                
              ],
          ),
        ),
      ),
    );
  }
}
