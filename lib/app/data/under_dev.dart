
import '../../../export.dart';
import '../core/widgets/double_back_press.dart';

class UnderDevScreen extends StatelessWidget {
  const UnderDevScreen({
    Key? key,
    /*required this.location,
      required this.error,
      required this.stackTrace*/
  }) : super(key: key);

/*  final String error;
  final String stackTrace;
  final String location;*/

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomAppBar(
            // appBarTitleText: location.toString(),
            // ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AssetImageWidget(imageUrl: iconUnderDev)],
            ))
          ],
        ),
      ),
    );
  }

  Widget _listTileIconView(
          {label, leadingIcon, onSeeAllTap, icon, description}) =>
      InkWell(
        onTap: onSeeAllTap ?? () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (leadingIcon != null)
                        ? AssetImageWidget(
                            imageFitType: BoxFit.cover,
                            imageHeight: height_25,
                            imageUrl: leadingIcon,
                          ).marginOnly(right: margin_12)
                        : SizedBox(),
                    (icon != null)
                        ? Icon(
                            icon,
                            color: Colors.black,
                            size: height_25,
                          ).marginOnly(right: margin_12)
                        : SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: label,
                          textStyle: textStyleBody2().copyWith(
                            color: Colors.black,
                            fontSize: font_15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.8,
                          child: TextView(
                            maxLine: 15,
                            text: description ?? "",
                            textStyle: textStyleBody2().copyWith(
                              color: Colors.black,
                              fontSize: font_15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: margin_16, horizontal: margin_20),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      );
}
