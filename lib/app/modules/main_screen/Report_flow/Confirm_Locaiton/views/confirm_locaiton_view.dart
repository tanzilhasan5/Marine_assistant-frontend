import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/confirm_locaiton_controller.dart';

class ConfirmLocaitonView extends GetView<ConfirmLocaitonController> {
  const ConfirmLocaitonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConfirmLocaitonView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ConfirmLocaitonView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
