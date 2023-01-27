import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/ui/widgets/app_bar.dart';
import '../widgets/primary_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 20,
            children: [
              CustomButton(label: 'Buttons', onPressed: () { Get.toNamed('/buttons'); }, width: 120),
              CustomButton(label: 'Input', onPressed: () { Get.toNamed('/inputs'); }, width: 120),
              CustomButton(label: 'Dialogs & Popup', onPressed: () { Get.toNamed('/dialog_popup'); }, width: 120),
              CustomButton(label: 'Modal', onPressed: () { Get.toNamed('/modal'); }, width: 120),
            ],
          ),
        ),
      ),
    );
  }
}
