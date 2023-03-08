import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/ui/widgets/confirm_dialog.dart';
import 'package:trafic_bordeaux/ui/widgets/primary_button.dart';
import 'package:trafic_bordeaux/ui/widgets/snackbar.dart';

import '../ui/widgets/app_bar.dart';

class DialogPopupView extends StatefulWidget {
  const DialogPopupView({super.key});

  @override
  State<DialogPopupView> createState() => _DialogPopupViewState();
}

class _DialogPopupViewState extends State<DialogPopupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Dialogs & popups',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Confirmation dialog',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  label: 'Confirm dialog',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ConfirmDialog(title: 'Mon tiutkle',description: 'Ma description super longue pour voir ce que ça donne', confirmText: 'OK',cancelText: 'Annuler');
                        });
                  },
                  width: 100,
                  type: TypeButton.informational),
              const SizedBox(
                height: 40,
              ),
              Text('Simple snackbars',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  CustomButton(
                    label: 'Error',
                    onPressed: () => CustomSnackbar().buildSnackbar(
                        'Error', 'Message d\'erreur', TypeMessage.error),
                    width: 100,
                    type: TypeButton.error,
                  ),
                  CustomButton(
                      label: 'Warning',
                      onPressed: () => CustomSnackbar().buildSnackbar(
                          'Warning', 'Message de warning', TypeMessage.warning),
                      width: 100,
                      type: TypeButton.warning),
                  CustomButton(
                      label: 'Informational',
                      onPressed: () => CustomSnackbar().buildSnackbar(
                          'Informational',
                          'Message d\'information',
                          TypeMessage.informational),
                      width: 100,
                      type: TypeButton.informational),
                  CustomButton(
                      label: 'Success',
                      onPressed: () => CustomSnackbar().buildSnackbar(
                          'Success', 'Message de succès', TypeMessage.success),
                      width: 100,
                      type: TypeButton.success)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
