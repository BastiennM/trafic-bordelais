import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trafic_bordeaux/core/constants/constants.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';
import 'package:trafic_bordeaux/ui/widgets/snackbar.dart';

import '../../core/constants/color_palette.dart';

class StateRoadIndicator {
  Widget getRoadIndicator(EtatVoie currentEtat) {
    return Container(
      width:50,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          border: Border.all(color: getColorIndicator(currentEtat))
        ),
        child: Center(child: getSvgIndicator(currentEtat))
    );
  }

  Widget getSvgIndicator(EtatVoie currentEtat) {
    Widget svgIndicator;

    Map possibilities = {
      EtatVoie.INCONNU: const Text('?', style: TextStyle(fontSize: 20)),
      EtatVoie.DENSE: SvgPicture.string(orangeCarState),
      EtatVoie.EMBOUTEILLE: SvgPicture.string(redTurtleState),
      EtatVoie.FLUIDE: SvgPicture.string(greenRabbitState),
    };

    svgIndicator = possibilities[currentEtat] ??
        const Text('?', style: TextStyle(fontSize: 28));

    return svgIndicator;
  }

  Color getColorIndicator(EtatVoie currentEtat) {
    Color colorIndicator;

    Map possibilities = {
      EtatVoie.INCONNU: ColorPalette.grey200,
      EtatVoie.DENSE: ColorPalette.orangeRoadState,
      EtatVoie.EMBOUTEILLE: ColorPalette.redRoadState,
      EtatVoie.FLUIDE: ColorPalette.greenRoadState,
    };

    colorIndicator = possibilities[currentEtat] ?? ColorPalette.grey100;

    return colorIndicator;
  }

  TypeMessage getTypeMessage(EtatVoie currentEtat) {
    TypeMessage typeMessage;

    Map possibilities = {
      EtatVoie.INCONNU: TypeMessage.informational,
      EtatVoie.DENSE: TypeMessage.warning,
      EtatVoie.EMBOUTEILLE: TypeMessage.error,
      EtatVoie.FLUIDE: TypeMessage.success,
    };

    typeMessage = possibilities[currentEtat] ?? TypeMessage.informational;

    return typeMessage;
  }
}
