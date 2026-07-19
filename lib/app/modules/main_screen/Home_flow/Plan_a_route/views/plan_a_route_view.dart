import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/plan_a_route_controller.dart';

class PlanARouteView extends GetView<PlanARouteController> {
  const PlanARouteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlanARouteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlanARouteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
