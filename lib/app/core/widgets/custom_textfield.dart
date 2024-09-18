/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/export.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final String? tvHeading;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final double? labelMargin;
  final Color? courserColor;
  final validate;
  final hintStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final bool? hideBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxline;
  final bool? optional;
  final decoration;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? shadow;
  final bool? obscureText;
  final bool? isOutlined;
  final labelTextStyle;
  final Function(String value)? onChange;
  final inputFormatter;
  final errorColor;
  final List<TextInputFormatter>? formatter;

  const TextFieldWidget(
      {this.hint,
      this.labelText,
      this.tvHeading,
      this.inputType,
      this.textController,
      this.hintStyle,
      this.courserColor,
      this.validate,
      this.onChange,
      this.decoration,
      this.radius,
      this.focusNode,
      this.readOnly = false,
      this.shadow,
      this.onFieldSubmitted,
      this.inputAction,
      this.height,
      this.width,
      this.contentPadding,
      this.isOutlined = false,
      this.maxline = 1,
      this.minLine = 1,
      this.maxLength,
      this.color,
      this.hideBorder = true,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.onTap,
      this.inputFormatter,
      this.errorColor,
      this.labelTextStyle,
      this.labelMargin,
      this.optional,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView(
                          text: labelText ?? "",
                          textStyle: labelTextStyle ??
                              textStyleBodyLarge().copyWith(
                                  color: isOutlined == true
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontWeight: FontWeight.w600))
                      .paddingOnly(bottom: labelMargin ?? margin_0),
                  (optional == true)
                      ? TextView(
                          text: "(Optional)",
                          textStyle: textStyleBodySmall().copyWith(
                            color: headingTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : emptySizeBox()
                ],
              )
            : Container(),
        TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            obscureText: obscureText ?? false,
            controller: textController,
            focusNode: focusNode,
            keyboardType: inputType,
            maxLength: maxLength,
            onChanged: onChange,
            cursorColor: courserColor ?? colorAppColor,
            inputFormatters: inputFormatter ??
                [
                  FilteringTextInputFormatter(
                      RegExp(
                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                      allow: false),
                ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxline,
            minLines: minLine,
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,
            validator: validate,
            style: Theme.of(Get.context!).textTheme.headline1!.copyWith(
                fontSize: font_14,
                fontWeight: FontWeight.w500,
                color: Colors.black),
            decoration: inputDecoration()),
      ],
    );
  }

  inputDecoration() => InputDecoration(
      counterText: "",
      errorMaxLines: 2,
      errorStyle: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
          fontSize: font_10,
          fontWeight: FontWeight.w500,
          color: errorColor ?? Colors.red),
      isDense: true,
      filled: true,
      contentPadding: contentPadding ??
          EdgeInsets.only(left: margin_30, top: margin_10, bottom: margin_10),
      prefixIcon: prefixIcon,
      suffixIcon: isOutlined == true ? null : suffixIcon,
      hintText: hint,
      hintStyle: hintStyle ??
          textStyleBodyMedium().copyWith(
              color: Colors.grey.shade500, fontWeight: FontWeight.w500),
      // labelText: labelText,
      fillColor: color ?? Colors.white,
      border: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_30),
                borderSide: BorderSide.none),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ),
      focusedErrorBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_30),
                borderSide: BorderSide.none),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ),
      errorBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? margin_30),
                  borderSide: BorderSide.none),
              shadow: BoxShadow(
                color: shadow == true ? Colors.transparent : Colors.grey[200]!,
                blurRadius: margin_2,
                spreadRadius: margin_2,
              )),
      focusedBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? margin_30),
                  borderSide: BorderSide.none),
              shadow: BoxShadow(
                color: shadow == true ? Colors.transparent : Colors.grey[200]!,
                blurRadius: margin_2,
                spreadRadius: margin_2,
              )),
      enabledBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_30),
                borderSide: BorderSide.none),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ));
}

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow? shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow!.toPaint();
    final Rect bounds =
        rect.shift(shadow!.offset).inflate(shadow!.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => hashValues(borderSide, child, shadow);
}
