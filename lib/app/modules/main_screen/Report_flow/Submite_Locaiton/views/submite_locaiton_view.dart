import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/submite_locaiton_controller.dart';

class SubmiteLocaitonView extends GetView<SubmiteLocaitonController> {
  const SubmiteLocaitonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubmiteLocaitonView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubmiteLocaitonView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
