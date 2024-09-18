import 'package:health_fitness/export.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? padding;
  final double? horizontalPadding;
  final onPressed;
  final decoration;
  final elevation;
  final bool? isSocial;
  final EdgeInsetsGeometry? customPadding;
  final double? fontsize;
  final Widget? iconWidget, buttonWidget;

  const MaterialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonColor,
    this.customPadding,
    this.textColor,
    this.buttonRadius = defaultRaduis,
    this.decoration,
    this.isSocial = false,
    this.buttonWidget,
    this.onPressed,
    this.elevation,
    this.iconWidget,
    this.fontsize,
    this.minWidth,
    this.minHeight,
    this.padding,
    this.horizontalPadding,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: minHeight,
        splashColor: Colors.transparent,
        minWidth: minWidth ?? Get.width,
        color: buttonColor ?? colorAppColor,
        elevation: elevation ?? radius_4,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(buttonRadius!)),
        onPressed: onPressed,
        padding: customPadding ??
            EdgeInsets.symmetric(
                vertical: padding ?? margin_15,
                horizontal: horizontalPadding ?? margin_1),
        child: buttonWidget ??
            TextView(
                text: buttonText!,
                textStyle: textStyleButton().copyWith(
                    color: textColor ?? Colors.white,
                    fontSize: fontsize,
                    fontWeight: FontWeight.w600)));
  }
}
