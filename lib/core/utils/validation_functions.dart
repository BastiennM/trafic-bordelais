import 'package:trafic_bordeaux/core/app_export.dart';

class Validators {
  static atLeastOne(value, context) => value != null && value != ""
      ? null
      : 'atLeastOne'.tr;

  static zipCodeValidator(value, context) => RegExp(
    '^[0-9]{5}\$',
    caseSensitive: false,
    multiLine: false,
  ).hasMatch(value) &&
      !(atLeastOne(value, context) != null)
      ? null
      : 'zipCode'.tr;

  static codeValidator(value, context) => RegExp(
    "^[a-zA-Z0-9]{6}\$",
    caseSensitive: false,
    multiLine: false,
  ).hasMatch(value)
      ? null
      : 'code'.tr;

  static isValidEmail(value, context) =>
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value)
          ? null
          : 'validEmail'.tr;

  static isValidUrl(value, context) =>
      RegExp(r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
          .hasMatch(value)
          ? null
          : 'validUrl'.tr;

  static String? errorText(controller) {
    final text = controller.value.text;
    if (text.isEmpty) {
      return 'atLeastOne'.tr;
    }
    if (text.length < 4) {
      return 'tooShort'.trParams({'number': 4.toString()});
    }
    return null;
  }
}
