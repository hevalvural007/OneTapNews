import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ot_news/ui/screens/account_screen.dart';
import 'package:ot_news/ui/screens/home_screen.dart';
import 'package:ot_news/ui/screens/search_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  int selectedIndex = 0;
  var pages = [HomeScreen(),SearchScreen(),AccountScreen()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFEB4A7B),
            Color(0xFF5A2E98),
          ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight

          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 10),
          child: GNav(
            color: Colors.white70,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white.withOpacity(0.15),
            gap: 8,
            padding: EdgeInsets.all(16),

            tabs: [
              GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.magnifyingGlass,
                text: 'Search',
              ),
              GButton(
                icon: FontAwesomeIcons.user,
                text: 'Account',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
