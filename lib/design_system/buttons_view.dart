import 'package:flutter/material.dart';
import '../ui/widgets/app_bar.dart';
import '../ui/widgets/icon_button.dart';
import '../ui/widgets/primary_button.dart';
import '../ui/widgets/snackbar.dart';

class ButtonsView extends StatefulWidget {
  const ButtonsView({super.key});

  @override
  State<ButtonsView> createState() => _ButtonsViewState();
}

class _ButtonsViewState extends State<ButtonsView> {
  bool disabled = false;
  bool fill = false;
  bool loading = false;
  bool loadingOutlined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Buttons',),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height:30),
              Text('Buttons with Loading and Disabled option', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height:20),
              Wrap(
                runSpacing: 10,
                children: [
                  Row(
                    children: [
                      CustomButton(label: 'Texte', onPressed: () {  }),
                      const Spacer(),
                      CustomButton(label: 'Texte', onPressed: () {  }, fill: fill),
                    ]
                  ),
                  Row(
                      children: [
                        CustomButton(label: 'Loading', onPressed: () { setState(() => loading = !loading);}, loading: loading),
                        const Spacer(),
                        CustomButton(label: 'Loading', onPressed: () { setState(() => loadingOutlined = !loadingOutlined);}, loading: loadingOutlined, fill: fill),
                      ]
                  ),
                  CustomButton(label: 'Disabled', onPressed: () { setState(() => disabled = !disabled);}, disabled: disabled, width: double.infinity),
                ],
              ),
              const Spacer(),
              Text('Buttons with different color and type using snackbars on click',textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height:20),
              Wrap(
                runSpacing: 10,
                children: [
                  CustomButton(label: 'Error', onPressed: () { CustomSnackbar().buildSnackbar('Erreur', 'Erreur lors de la saisie', TypeMessage.error);},width:150, type: TypeButton.error,needIcon: true),
                  CustomButton(label: 'Warning', onPressed: () { CustomSnackbar().buildSnackbar('Warning', 'Attention, votre mot de passe est faible', TypeMessage.warning);},width:150, type: TypeButton.warning,needIcon: true),
                  CustomButton(label: 'Bravo', onPressed: () { CustomSnackbar().buildSnackbar('Bravo', 'Vous avez validé le formulaire', TypeMessage.success);},width:150, type: TypeButton.success,needIcon: true),
                  CustomButton(label: 'Le Saviez-vous ?', onPressed: () { CustomSnackbar().buildSnackbar('Le Saviez-vous ?', 'Je m\'appelle Bastien', TypeMessage.informational);},width:150, type: TypeButton.informational,needIcon: true),
                ]
              ),
              const Spacer(),
              Text('Different icons with color',textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height:20),
              Wrap(
                  spacing: 10,
                  children: [
                    CustomIconButton(onPressed: () => CustomSnackbar().buildSnackbar('IconButton', 'Vous avez cliqué sur l\'icône', TypeMessage.informational), icon: const Icon(Icons.add), type: TypeIconButton.filled),
                    CustomIconButton(onPressed: () => CustomSnackbar().buildSnackbar('IconButton', 'Vous avez cliqué sur l\'icône', TypeMessage.informational), icon: const Icon(Icons.add), type: TypeIconButton.icon),
                    CustomIconButton(onPressed: () => CustomSnackbar().buildSnackbar('IconButton', 'Vous avez cliqué sur l\'icône', TypeMessage.informational), icon: const Icon(Icons.add), type: TypeIconButton.outlined)
                  ]
              ),
              const Spacer()
            ],
          ),
        ),
    );
  }
}
