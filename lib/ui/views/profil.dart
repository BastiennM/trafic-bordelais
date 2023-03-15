import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import 'package:trafic_bordeaux/core/app_export.dart';
import 'package:trafic_bordeaux/core/constants/color_palette.dart';
import 'package:trafic_bordeaux/ui/widgets/icon_button.dart';
import 'package:trafic_bordeaux/ui/widgets/primary_button.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ThemeModeController themeModeController = Get.put(ThemeModeController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 130),
            Center(
            child: Text(
              'Mon profil',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ),
            Center(
            child: Text(
                authController.isConnected.value ? '' : 'isConnectedIndication'.tr,
                style: Theme.of(context).textTheme.titleSmall),
            ),
            SizedBox(height: 70),
            Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(

              child: CustomButton(
                height: 30,
                label: 'myTrips'.tr,
                color: themeModeController.isDark.value
                    ? authController.isConnected.value ? Colors.black : Colors.black.withOpacity(0.5)
                    : authController.isConnected.value ? ColorPalette.ctaButton : ColorPalette.ctaButton.withOpacity(0.5),
                onPressed: () => {},
                width: 300,
                disabled: !authController.isConnected.value,
                icon: FaIcon(FontAwesomeIcons.car,color: themeModeController.isDark.value
                    ? authController.isConnected.value ? Colors.black : Colors.white.withOpacity(0.5)
                    : authController.isConnected.value ? ColorPalette.ctaButton : ColorPalette.ctaButton.withOpacity(0.5), size: 20),
                needIcon: true,
                needArrowIcon: true,
              ),
            ),
            ),
            Visibility(child: Text('isConnectedIndicationTrip'.tr, style: Theme.of(context).textTheme.titleSmall), visible: !authController.isConnected.value,),
            Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomButton(
              height: 30,
              label: 'themesMode'.tr,
              color: themeModeController.isDark.value
                  ? Colors.black
                  : ColorPalette.ctaButton,
              onPressed: () {
                themeModeController.changeMode();
                themeModeController.saveThemeStatus();
              },
              icon: FaIcon(FontAwesomeIcons.solidMoon,color: themeModeController.isDark.value
                  ? Colors.white
                  : Colors.black, size: 20),
              needIcon: true,
              needArrowIcon: true,
              width: 300,
            ),
            ),
            Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomButton(
              height: 30,
              label: authController.isConnected.value ? 'disconnect'.tr :'login'.tr ,
              icon: authController.isConnected.value ? FaIcon(FontAwesomeIcons.arrowRightToBracket,color: themeModeController.isDark.value
                  ? Colors.white
                  : Colors.black, size: 20) : FaIcon(FontAwesomeIcons.solidUser,color: themeModeController.isDark.value
                  ? Colors.white
                  : Colors.black, size: 20),
              color: themeModeController.isDark.value
                  ? Colors.black
                  : ColorPalette.ctaButton,
              onPressed: () => {authController.isConnected.value ? authController.signOut().then((value) => Get.toNamed('/home')) : Get.toNamed('/login')},
              width: 300,
              needIcon: true,
              needArrowIcon: true,
            ),
            ),
          ]),
            CustomIconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.close,
                    color: themeModeController.isDark.value
                        ? Colors.black
                        : Colors.white),
                type: TypeIconButton.outlined),
          ],
        ),
      ),
    );
  }
}
