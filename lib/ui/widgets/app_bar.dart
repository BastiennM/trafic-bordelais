import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:provider/provider.dart';
import '../../core/constants/config.dart';
import 'icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    final themeModeController = Get.put(ThemeModeController());
    return AppBar(
      backgroundColor: Colors.transparent,
        actions: actions,
        elevation: 0,
        leading: leading
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
