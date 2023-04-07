import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
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
