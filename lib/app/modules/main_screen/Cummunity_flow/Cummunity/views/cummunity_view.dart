import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cummunity_controller.dart';

class CummunityView extends GetView<CummunityController> {
  const CummunityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CummunityView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CummunityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
