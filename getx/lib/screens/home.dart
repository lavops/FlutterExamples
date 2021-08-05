import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/counterController.dart';
import 'package:getx/screens/other.dart';

class HomeScreen extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Clicks: ${counterController.counter.value}"),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  counterController.increment();
                  Get.to(OtherScreen());
                },
                child: Text("OPEN OTHER SCREEN"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
