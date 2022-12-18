import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final PageController _pageController = PageController(
    initialPage: AbstractNavigationTabs.homeTab,
  );
  final RxInt _currentIndex = AbstractNavigationTabs.homeTab.obs;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;

    _pageController.animateToPage(
      page = page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    _currentIndex.value = page;
  }
}

abstract class AbstractNavigationTabs {
  static const int homeTab = 0;
  static const int cartTab = 1;
  static const int ordersTab = 2;
  static const int profileTab = 3;
}
