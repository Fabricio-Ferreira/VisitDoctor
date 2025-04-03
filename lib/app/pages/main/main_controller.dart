import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/clients/pages/client_list/client_page.dart';
import 'package:visit_doctor/app/pages/home/pages/home/home_page.dart';
import 'package:visit_doctor/app/pages/visits/pages/visits_list/visits_page.dart';

import '../../enum/app_tab.dart';

class MainController extends GetxController {
  PageController _pageController = PageController();
  final _currentIndex = 0.obs;
  final pages = <Widget>[].obs;

  int get currentIndex => _currentIndex.value;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    _pageController = PageController(initialPage: currentIndex);
    pages.addAll(const [
      HomePage(),
      ClientPage(),
      VisitsPage(),
    ]);
    super.onInit();
  }

  void changePage(AppTab tab) {
    final index = tab.index;
    _currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
