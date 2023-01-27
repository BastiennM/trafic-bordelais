import 'dart:async';

import 'package:flutter/material.dart';
import '../core/utils/validation_functions.dart';
import '../ui/widgets/app_bar.dart';
import '../ui/widgets/primary_button.dart';
import '../ui/widgets/snackbar.dart';
import '../ui/widgets/textfield.dart';

class InputsView extends StatefulWidget {
  const InputsView({Key? key}) : super(key: key);

  @override
  State<InputsView> createState() => _InputsViewState();
}

class _InputsViewState extends State<InputsView> {
  TextEditingController defaultController = TextEditingController();
  TextEditingController floatingController = TextEditingController();
  TextEditingController textAboveController = TextEditingController();
  TextEditingController hintUnderController = TextEditingController();
  TextEditingController leadingIconController = TextEditingController();
  TextEditingController trailingIconController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future successMessage() {
    return Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        loading = !loading;
      });
      return CustomSnackbar().buildSnackbar('Bravo', 'Vous avez validé le formulaire', TypeMessage.success);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Inputs',),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 20,
                children: [
                  CustomTextField(
                    controller: defaultController,
                    placeholder: "Default Simple Text Field",
                    validator: (value) {
                      return Validators.atLeastOne(value, context);
                    },
                  ),
                  CustomTextField(
                    controller: floatingController,
                    placeholder: "Floating label Text Field",
                    label: "My floating label text field",
                    validator: (value) {
                      return Validators.atLeastOne(value, context);
                    },
                  ),
                  CustomTextField(
                    controller: textAboveController,
                    placeholder: "Floating label Text Field",
                    labelAbove: "My text above input",
                    validator: (value) {
                      return Validators.atLeastOne(value, context);
                    },
                  ),
                  CustomTextField(
                    controller: hintUnderController,
                    placeholder: "Floating label Text Field",
                    labelAbove: "My text above input",
                    labelUnder:
                        "My text under input giving some hint on what is about",
                    validator: (value) {
                      return Validators.atLeastOne(value, context);
                    },
                  ),
                  CustomTextField(
                    controller: leadingIconController,
                    placeholder: "Input with leading icon",
                    prefix: const Icon(Icons.search),
                    validator: (value) {
                      return Validators.atLeastOne(value, context);
                    },
                  ),
                  CustomTextField(
                      controller: trailingIconController,
                      placeholder: "Input with confirmation & error",
                      needConfirmationSuffix: true,
                      validator: (value) {
                        return Validators.atLeastOne(value, context);
                      }),
                  CustomButton(
                    label: 'Submit',
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          loading = !loading;
                          successMessage();
                        }
                      });
                    },
                    loading: loading,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
