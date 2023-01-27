import 'package:flutter/material.dart';
import 'package:getx_templates/ui/widgets/app_bar.dart';
import 'package:getx_templates/ui/widgets/modal_bottom.dart';

import '../ui/widgets/primary_button.dart';

class BottomModalView extends StatelessWidget {
  const BottomModalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title:'Bottom Modal'),
      body: Center(
        child: CustomButton(label: 'Bottom Modal', onPressed: () => const CustomModalBottom().getBottomModal(SingleChildScrollView(child: Center(child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',style: Theme.of(context).textTheme.bodyText1)))
        ),)
      ),
    );
  }
}
