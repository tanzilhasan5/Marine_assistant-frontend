import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeLanguageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeLanguageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
