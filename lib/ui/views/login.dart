import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'package:trafic_bordeaux/core/utils/validation_functions.dart';
import 'package:trafic_bordeaux/ui/widgets/primary_button.dart';
import 'package:trafic_bordeaux/ui/widgets/textfield.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: authController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: authController.emailController,
                placeholder: "johndoe@gmail.com",
                labelAbove: "Mail",
                validator: (value) {
                  return Validators.isValidEmail(value, context);
                }
              ),
              const SizedBox(height:10),
              CustomTextField(
                controller: authController.passwordController,
                password: true,
                placeholder: "password",
                labelAbove: "Password",
                validator: (value) {
                  return Validators.atLeastOne(value, context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(label: 'S\'inscrire', onPressed: () =>
                {
                  if (authController.formKey.currentState!.validate()) {
                    authController.registerWithEmailAndPassword(context)
                  }
                }, width: 300,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
