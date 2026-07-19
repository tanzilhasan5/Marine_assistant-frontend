import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/suggested_route_controller.dart';

class SuggestedRouteView extends GetView<SuggestedRouteController> {
  const SuggestedRouteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuggestedRouteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SuggestedRouteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
