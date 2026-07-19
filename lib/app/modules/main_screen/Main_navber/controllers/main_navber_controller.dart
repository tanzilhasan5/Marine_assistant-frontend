import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Home_flow/Home/views/home_view.dart';

class MainNavberController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const Center(child: Text('Route', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Fuel', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Community', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Profile', style: TextStyle(color: Colors.white))),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
