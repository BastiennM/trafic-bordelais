import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/ui/widgets/app_bar.dart';

import '../widgets/icon_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          CustomIconButton(onPressed: () { Get.toNamed('/login'); }, icon: const Icon(Icons.person),)
        ],
      ),
      body: Placeholder(),
    );
  }
}
