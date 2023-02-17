import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:trafic_bordeaux/core/app_export.dart';
import 'package:trafic_bordeaux/core/constants/color_palette.dart';
import 'package:trafic_bordeaux/core/utils/validation_functions.dart';
import 'package:trafic_bordeaux/ui/widgets/icon_button.dart';
import 'package:trafic_bordeaux/ui/widgets/primary_button.dart';
import 'package:trafic_bordeaux/ui/widgets/textfield.dart';

class Authentication extends StatelessWidget {
  final AuthType authType;
  const Authentication({Key? key, required this.authType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ThemeModeController themeModeController = Get.put(ThemeModeController());
    return Scaffold(
      body:Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: authController.formKey,
            child:  Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: CustomIconButton(
                            onPressed: () => Get.toNamed('/home'),
                            icon: Icon(Icons.close,
                                color: themeModeController.isDark.value
                                    ? Colors.black
                                    : Colors.white),
                            type: TypeIconButton.outlined),
                    ),

                    SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(top:60.0),
                        child: Text(
                          authType == AuthType.login ? 'titleLogin'.tr : 'titleRegister'.tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Column(
                        children: [
                      CustomTextField(
                          fillColor: ColorPalette.inputBackgroundColor,
                          borderColor: ColorPalette.inputBorderColor,
                          controller: authController.emailController,
                          placeholder: "emailPlaceholder".tr,
                          validator: (value) {
                            return Validators.isValidEmail(value, context);
                          }),
                      const SizedBox(height: 12),
                      CustomTextField(
                        fillColor: ColorPalette.inputBackgroundColor,
                        borderColor: ColorPalette.inputBorderColor,
                        controller: authController.passwordController,
                        password: true,
                        placeholder: "password".tr,
                        validator: (value) {
                          return Validators.atLeastOne(value, context);
                        },
                      ),
                      authType == AuthType.register
                          ? Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: CustomTextField(
                                fillColor: ColorPalette.inputBackgroundColor,
                                borderColor: ColorPalette.inputBorderColor,
                                controller: authController.passwordController,
                                password: true,
                                placeholder: "password".tr,
                                validator: (value) {
                                  return Validators.atLeastOne(value, context);
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomButton(
                          height: 30,
                          label:
                              authType == AuthType.login ? 'login'.tr : 'register'.tr,
                          color: themeModeController.isDark.value
                              ? Colors.black
                              : ColorPalette.ctaButton,
                          onPressed: () => {
                            if (authController.formKey.currentState!.validate())
                              {authController.registerWithEmailAndPassword(context)}
                          },
                          width: 300,
                        ),
                      ),
                    ]),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          authType == AuthType.login
                              ? 'newUser'.tr
                              : 'alreadyRegistered'.tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                            onPressed: () => {
                              authType == AuthType.login ? Get.toNamed('/register') : Get.toNamed('/login')
                            },
                            child: Text(
                                authType == AuthType.login
                                    ? 'registerNow'.tr
                                    : 'loginNow'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: ColorPalette.ctaButton,
                                        fontWeight: FontWeight.bold)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
