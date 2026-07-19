import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_package_controller.dart';

class SubscriptionPackageView extends GetView<SubscriptionPackageController> {
  const SubscriptionPackageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriptionPackageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriptionPackageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
