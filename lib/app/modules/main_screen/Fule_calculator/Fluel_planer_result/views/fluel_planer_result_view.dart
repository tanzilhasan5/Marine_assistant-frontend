import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fluel_planer_result_controller.dart';

class FluelPlanerResultView extends GetView<FluelPlanerResultController> {
  const FluelPlanerResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FluelPlanerResultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FluelPlanerResultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
