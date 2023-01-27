import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'icon_button.dart';

class CustomModalBottom {
  const CustomModalBottom();

  getBottomModal(Widget content) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: Get.key.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.7,
              child: content
            ),
            Positioned(
                right: 18,
                top: 3,
                child: Container(
                  width: 40,
                  height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: CustomIconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        iconColor: Theme.of(context).colorScheme.secondary)))
          ],
        );
      },
    );
  }
}
