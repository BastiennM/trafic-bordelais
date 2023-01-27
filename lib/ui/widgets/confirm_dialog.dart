import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final void Function()? confirmAction;
  final void Function()? cancelAction;
  const ConfirmDialog({super.key, required this.title, this.description = '', this.confirmText = "", this.cancelText = "", this.cancelAction, this.confirmAction});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: width,
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: confirmText != "" || cancelText != "" ? 4 : 16),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.subtitle1,),
            description != '' ? Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(description, style: Theme.of(context).textTheme.bodyText2,),
            ) : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                confirmText != "" ? TextButton(onPressed: confirmAction ?? () => Navigator.of(context).pop(), child: Text(confirmText, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor))) : const SizedBox.shrink(),
                cancelText != "" ? TextButton(onPressed: cancelAction ?? () => Navigator.of(context).pop(), child: Text(cancelText,style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor),)) : const SizedBox.shrink()
              ],
            )
          ],
        )
      ),
    );
  }
}
