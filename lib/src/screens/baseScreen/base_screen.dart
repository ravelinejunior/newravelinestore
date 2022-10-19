import 'package:flutter/material.dart';
import 'package:newravelinestore/src/screens/cartScreen/cart_screen.dart';
import 'package:newravelinestore/src/screens/homeScreen/home_tab.dart';
import 'package:newravelinestore/src/screens/ordersScreen/orders_screen.dart';
import 'package:newravelinestore/src/screens/profileScreen/profile_screen.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTab(),
          CartTab(),
          OrdersScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        enableFeedback: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.teal[600],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              currentIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: bottomNavHomeString,
            tooltip: bottomNavHomeString,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: bottomNavCartString,
            tooltip: bottomNavCartString,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: bottomNavOrdersString,
            tooltip: bottomNavOrdersString,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: bottomNavProfileString,
            tooltip: bottomNavProfileString,
          ),
        ],
      ),
    );
  }
}
