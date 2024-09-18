/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitleText;
  final actionWidget;
  final bottomPadding;
  final topPadding;
  final Color? bgColor;
  final appBarTitleWidget;
  final leadingIcon;
  final bool? isDrawerIcon;
  final bool? isBackIcon;
  final bool? centerTitle;
  final Function? onTap;
  final TextStyle? titleTextStyle;

  CustomAppBar({
    Key? key,
    this.appBarTitleText,
    this.onTap,
    this.actionWidget,
    this.bottomPadding,
    this.topPadding,
    this.isDrawerIcon = false,
    this.appBarTitleWidget,
    this.leadingIcon,
    this.isBackIcon = true,
    this.centerTitle = false,
    this.bgColor,
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: height_65,
      elevation: 0.0,
      bottomOpacity: 0.0,
      leading: isBackIcon! ? _backIcon() : Container(),
      centerTitle: false,
      leadingWidth: width_50,
      surfaceTintColor: Colors.transparent,
      title: appBarTitleWidget ??
          (appBarTitleText != "" || appBarTitleText != null
              ? TextView(
                  text: appBarTitleText ?? "",
                  textAlign: TextAlign.start,
                  textStyle: titleTextStyle ??
                      textStyleHeadlineMedium().copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ).paddingOnly(
                  top: margin_10,
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                )),
      shadowColor: Colors.transparent,
      backgroundColor: bgColor ?? Colors.white,
      actions: actionWidget ?? [],
    );
  }

  _backIcon() {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: leadingIcon ??
            AssetImageWidget(
              imageUrl: (isDrawerIcon == true ? iconMenu : iconBack),
              imageWidth: isDrawerIcon == true ? height_65 : height_65,
              imageHeight: isDrawerIcon == true ? height_65 : height_65,
            ).paddingOnly(
              top: topPadding ?? margin_15,
              left: margin_5,
              bottom:
                  isDrawerIcon == false ? bottomPadding ?? margin_2 : margin_2,
            ),
        onTap: () {
          if (onTap == null) {
            Get.back(result: true);
          } else {
            onTap!();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height_50);
}
