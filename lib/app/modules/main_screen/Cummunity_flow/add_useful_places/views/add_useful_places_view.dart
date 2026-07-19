import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_useful_places_controller.dart';

class AddUsefulPlacesView extends GetView<AddUsefulPlacesController> {
  const AddUsefulPlacesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddUsefulPlacesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddUsefulPlacesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
