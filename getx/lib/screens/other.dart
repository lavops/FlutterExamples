import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/counterController.dart';

class OtherScreen extends StatelessWidget {
  final CounterController _counterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("OTHER SCREEN OPENED ${_counterController.counter.value}."),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("GO BACK TO HOME SCREEN"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
