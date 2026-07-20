import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marine_assistant/app/modules/main_screen/Cummunity_flow/Cummunity/views/cummunity_view.dart';
import 'package:marine_assistant/app/modules/main_screen/Fule_calculator/Fluel_planer/views/fluel_planer_view.dart';
import 'package:marine_assistant/app/modules/main_screen/Report_flow/Report/views/report_view.dart';

import '../../Home_flow/Home/views/home_view.dart';

class MainNavberController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const FluelPlanerView(),
    const ReportView(),
    const CummunityView(),

  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
