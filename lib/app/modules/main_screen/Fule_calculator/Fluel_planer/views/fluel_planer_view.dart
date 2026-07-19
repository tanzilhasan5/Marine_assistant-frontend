import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fluel_planer_controller.dart';

class FluelPlanerView extends GetView<FluelPlanerController> {
  const FluelPlanerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FluelPlanerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FluelPlanerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
