import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:trafic_bordeaux/core/app_export.dart';
import 'package:trafic_bordeaux/core/constants/color_palette.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';
import 'package:trafic_bordeaux/core/utils/validation_functions.dart';
import 'package:trafic_bordeaux/ui/widgets/icon_button.dart';
import 'package:trafic_bordeaux/ui/widgets/primary_button.dart';
import 'package:trafic_bordeaux/ui/widgets/textfield.dart';

class Authentication extends StatelessWidget {
  final AuthType authType;
  const Authentication({Key? key, required this.authType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    ThemeModeController themeModeController = Get.find<ThemeModeController>();
    GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

    return Scaffold(
      body:Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: authFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: CustomIconButton(
                    onPressed: () {
                      authController.clearController();
                      authType == AuthType.login ? Get.back() : Get.until((route) => Get.currentRoute == "/profil");
                    },
                    icon: Icon(Icons.arrow_back,
                        color: themeModeController.isDark.value
                            ? Colors.black
                            : Colors.white),
                    type: TypeIconButton.outlined),
              ),

              SizedBox(
                height: 210,
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
                        fillColor: themeModeController.isDark.value ? ColorPalette.grey50 : ColorPalette.greyElement,
                        borderColor: Colors.transparent,
                        controller: authController.emailController,
                        label: "emailPlaceholder".tr,
                        validator: (value) {
                          return Validators.isValidEmail(value, context);
                        }),
                    const SizedBox(height: 12),
                    CustomTextField(
                      fillColor: themeModeController.isDark.value ? ColorPalette.grey50 : ColorPalette.greyElement,
                      borderColor: Colors.transparent,
                      controller: authController.passwordController,
                      password: true,
                      label: "password".tr,
                      validator: (value) {
                        return Validators.atLeastOne(value, context);
                      },
                    ),
                    authType == AuthType.register
                        ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: CustomTextField(
                        fillColor: themeModeController.isDark.value ? ColorPalette.grey50 : ColorPalette.greyElement,
                        borderColor: Colors.transparent,
                        controller: authController.confirmPasswordController,
                        password: true,
                        label: "confirmPassword".tr,
                        validator: (value) {
                          return Validators.atLeastOne(value, context);
                        },
                      ),
                    )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomButton(
                        height: 20,
                        label:
                        authType == AuthType.login ? 'login'.tr : 'register'.tr,
                        color: themeModeController.isDark.value
                            ? Colors.black
                            : ColorPalette.ctaButton,
                        onPressed: () => {
                          if (authFormKey.currentState!.validate())
                            {authType == AuthType.register ? authController.registerWithEmailAndPassword(context) : authController.signInWithEmailAndPassword(context)}
                        },
                        width: 300,
                      ),
                    ),
                  ]),
              const Spacer(),
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
                              : 'login'.tr,
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
    );
  }
}
