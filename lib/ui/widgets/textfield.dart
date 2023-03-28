import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';
import '../../core/constants/color_palette.dart';
import '../../core/constants/themes.dart';
import '../../core/utils/validation_functions.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final String labelUnder;
  final String labelAbove;
  final String label;
  final Widget? prefix;
  final bool password;
  final double circularBorder;
  final Color? fillColor;
  final Function? validator;
  final bool needConfirmationSuffix;
  final Color? borderColor;

  const CustomTextField({Key? key,
    required this.controller,
    this.placeholder = "",
    this.label = "",
    this.labelUnder = "",
    this.labelAbove = "",
    this.circularBorder = 6,
    this.prefix,
    this.needConfirmationSuffix = false,
    this.fillColor,
    this.password = false,
    this.validator,
    this.borderColor}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focus = FocusNode();
  Color labelAboveColor = ColorPalette.grey200;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() => labelAboveColor = _focus.hasFocus ? Theme.of(context).primaryColor : ColorPalette.grey200);
  }

  @override
  Widget build(BuildContext context) {
    ThemeModeController themeModeController = Get.put(ThemeModeController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelAbove != "" ? Padding(
          padding: const EdgeInsets.only(bottom:8.0, left:2),
          child: Text(widget.labelAbove,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: labelAboveColor)),
        ) : const SizedBox.shrink(),
        TextFormField(
          onChanged: (text) => setState(() => widget.controller.text),
          cursorColor: Themes.primary, //<-- SEE HERE
          focusNode: _focus,
          controller: widget.controller,
          validator:  widget.validator != null
              ? (value) => widget.validator!(value)
              : null,
          style: TextStyle(height: 1, color: Theme.of(context).colorScheme.secondary, fontSize: Theme.of(context).textTheme.titleSmall!.fontSize),
          obscureText: widget.password,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorPalette.grey200),
            label: widget.label != "" ? Text(widget.label, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: widget.fillColor != null ? !themeModeController.isDark.value ? Colors.white : Colors.black : labelAboveColor, fontSize: 12),) : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: true,
            fillColor: widget.fillColor ?? Theme.of(context).focusColor,
            prefixIcon: widget.prefix,
            suffixIcon: widget.needConfirmationSuffix ? getSuffix : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(widget.circularBorder)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorPalette.errorColorText),
                borderRadius: BorderRadius.circular(widget.circularBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor ?? borderColor),
                borderRadius: BorderRadius.circular(widget.circularBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(widget.circularBorder)
            ),
            errorText: widget.needConfirmationSuffix ? Validators.errorText(widget.controller): null,
            errorStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorPalette.errorColorText),
          ),
        ),
        widget.labelUnder != "" ? Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text(widget.labelUnder,style: Theme.of(context).textTheme.titleLarge?.copyWith(color:ColorPalette.grey200)),
        ) : const SizedBox.shrink(),
      ],
    );
  }

  Widget get getSuffix{
    return Icon(
      Validators.errorText(widget.controller) != null ? Icons.close : Icons.check,
      color: Validators.errorText(widget.controller) != null ? ColorPalette.errorColorText : ColorPalette.successColorText,
    );
  }

  Color get borderColor{
    return widget.needConfirmationSuffix ? Validators.errorText(widget.controller) != null ? ColorPalette.errorColorText : ColorPalette.successColorText : Theme.of(context).primaryColor;
  }
}
