import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/domain/controller/navigation_controller.dart';
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
  final navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeTab(),
          const CartTab(),
          const OrdersScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          enableFeedback: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Colors.teal[600],
          currentIndex: navigationController.currentIndex,
          onTap: (index) {
            navigationController.navigatePageView(index);
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
      ),
    );
  }
}
