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
        title: Text(title ?? context.read<Config>().appName,style: Theme.of(context).textTheme.titleMedium?.copyWith(color:Colors.white)),
        actions: actions ?? [
          Obx(
                () => CustomIconButton(
                  icon: Icon(themeModeController.isDark.value ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    themeModeController.changeMode();
                    themeModeController.saveThemeStatus();
                    },
              ),
          ),
        ],
        elevation: 5.0,
        leading: leading ?? Obx(
              () => CustomIconButton(
            icon: Icon(themeModeController.isDark.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeModeController.changeMode();
              themeModeController.saveThemeStatus();
            },
                backgroundColor: Colors.transparent,
          ),
        ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
