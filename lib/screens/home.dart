import 'package:budget_tracker/pages/home_page.dart';
import 'package:budget_tracker/pages/profile_page.dart';
import 'package:budget_tracker/widgets/Dialogs/add_budget_dialog.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: "Profile",
    ),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0; // Current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Budget Tracker",
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (builder) {
                  return AddBudgetDialog(
                    budget: (budget ) { 
                      
                    },
                  );
                }
              );
            }, 
            icon: const Icon(
              Icons.attach_money,
            ),
          ),
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}