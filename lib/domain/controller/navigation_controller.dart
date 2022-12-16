import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  @override
  void onInit() {
    super.onInit();

    initNavigation(
      pageController: PageController(
        initialPage: AbstractNavigationTabs.homeTab,
      ),
      currentIndex: AbstractNavigationTabs.homeTab,
    );
  }

  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;

    if (_pageController.hasClients) {
      _pageController.jumpToPage(page);
      _currentIndex.value = page;
    } else {}
  }
}

abstract class AbstractNavigationTabs {
  static const int homeTab = 0;
  static const int cartTab = 1;
  static const int ordersTab = 2;
  static const int profileTab = 3;
}
