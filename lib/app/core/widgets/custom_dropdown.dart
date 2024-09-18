/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../export.dart';
import '../utils/helper_widget.dart';
import '../values/app_colors.dart';

class DropDownWidget extends StatelessWidget {
  final String? hint;
  final String? tvHeading;
  final FocusNode? focusNode;
  final itemSelected;
  final List<DropdownMenuItem<Object>>? dropdownMenuItems;
  final String? Function(Object?)? validate;
  final Color? color;
  final double? radius;
  final icon;
  final Function(Object?)? onChanged;
  RxBool isFocused = false.obs;

  DropDownWidget({
    Key? key,
    this.hint,
    this.tvHeading,
    this.focusNode,
    this.itemSelected,
    this.dropdownMenuItems,
    this.validate,
    this.radius,
    this.color,
    this.icon,
    this.onChanged,
  }) {
    isFocused.value = focusNode?.hasFocus == true;
    focusNode?.addListener(() {
      isFocused.value = focusNode?.hasFocus == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tvHeading != null
            ? TextView(
          text: tvHeading!,
          textStyle: textStyleBodyLarge().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ).paddingOnly(
          bottom: height_10,
        )
            : emptySizeBox(),
        ButtonTheme(
          alignedDropdown: true,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius_10)),
            child: DropdownButtonFormField(
              focusNode: focusNode,
              validator: validate,
              isDense: true,
              decoration: InputDecoration(
                // errorBorder: InputBorder.none,
                errorMaxLines: 1,
                errorStyle: TextStyle(color: Colors.red),

                contentPadding: EdgeInsets.symmetric(
                  vertical: margin_13,
                ),
                isDense: true,
                hintStyle: Theme.of(Get.context!)
                    .textTheme
                    .headline1!
                    .copyWith(
                    fontSize: font_13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                enabledBorder: _decorationWidget(),
                focusedBorder: _decorationWidget(),
              ),
              style: Theme.of(Get.context!).textTheme.headline1!.copyWith(
                  fontSize: font_14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              hint: TextView(
                text: hint ?? "Select Item",
                textStyle: textStyleBodyLarge()
                    .copyWith(color: Colors.black),
              ),
              isExpanded: true,
              icon: icon ??
                  Transform.rotate(
                      angle: 4.71239,
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                      )),
              iconSize: margin_18,
              iconEnabledColor: color ?? Colors.grey,
              value: itemSelected,
              items: dropdownMenuItems,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _decorationWidget() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? radius_10),
      borderSide: BorderSide(color: Colors.white, width: width_1));
}
