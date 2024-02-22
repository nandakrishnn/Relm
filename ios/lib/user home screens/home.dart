import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:relm/user%20home%20screens/Music.dart';
import 'package:relm/user%20home%20screens/category.dart';
import 'package:relm/user%20home%20screens/favourites.dart';
import 'package:relm/user%20home%20screens/homescreen.dart';
import 'package:relm/user%20home%20screens/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final screens = [
    home1(),
    Music(),
    Categories(),
    Favourites(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Signup baground.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          screens[index],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Color.fromRGBO(76, 114, 115, 5),
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(63, 63, 63, 5),
        items: <Widget>[
          _buildNavItem(Icons.home, 'Home', index == 0),
          _buildNavItem(Icons.music_note, 'Music', index == 1),
          _buildNavItem(Icons.category_sharp, 'Categories', index == 2),
          _buildNavItem(Icons.favorite_border, 'Favourites', index == 3),
          _buildNavItem(Icons.person_pin, 'Profile', index == 4),
        ],
        height: 75,
        index: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(top: isSelected ? 0 : 21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white, // Set the icon color to white
          ),
          if (!isSelected)
            SizedBox(height: 4),
          if (!isSelected)
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
