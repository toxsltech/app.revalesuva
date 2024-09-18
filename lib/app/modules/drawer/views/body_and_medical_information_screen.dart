// import '../../../../export.dart';
// import '../../../core/translations/local_keys.dart';
// import '../../../core/values/validator.dart';
// import '../controllers/body_and_meedical_details_controller.dart';
//
// class BodyAndMedicalScreen extends GetView<BodyAndMedicalDetailController> {
//   const BodyAndMedicalScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: _appBar(),
//       body: _body(),
//     ));
//   }
//
//   _appBar() {
//     return CustomAppBar(
//       leadingIcon: Icon(
//         Icons.arrow_back_ios,
//         size: font_24,
//       ).paddingOnly(top: margin_18, left: margin_10),
//       appBarTitleText: keyBackToPersonalProfile.tr,
//       titleTextStyle: textStyleBody1(),
//     );
//   }
//
//   _body() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextView(
//                   text: keyBodyDataAndMedialInformation.tr,
//                   textStyle:
//                       textStyleBody1().copyWith(fontWeight: FontWeight.bold))
//               .marginSymmetric(vertical: margin_10),
//           TextView(
//                   text: KeyPicturesBefore.tr,
//                   textStyle:
//                       textStyleBody1().copyWith(fontWeight: FontWeight.bold))
//               .marginSymmetric(vertical: margin_10),
//           Row(
//             children: [
//               _containerDesign(image: iconImg1, title: keyFront.tr),
//               _containerDesign(image: iconImg2, title: keySide.tr),
//               _containerDesign(image: iconImg3, title: keyBack.tr),
//             ],
//           ),
//           Obx(
//             () => Container(
//               padding: EdgeInsets.all(margin_10),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(radius_10)),
//               child: !controllers.isEdit.value
//                   ? _bodyDataDetail()
//                   : _editBodyDataDetailForm(),
//             ).marginSymmetric(vertical: margin_10),
//           ),
//           Obx(() =>
//               controllers.isEdit.value ? _button(onTap: () {}) : emptySizeBox()),
//           Obx(
//             () => Container(
//               padding: EdgeInsets.all(margin_10),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(radius_10)),
//               child: !controllers.editMedicalQus.value
//                   ? _medicalQuestionairesView()
//                   : _medicalQuestionairesView(),
//             ).marginSymmetric(vertical: margin_15),
//           ),
//           Obx(() => controllers.editMedicalQus.value
//               ? _button(onTap: () {})
//               : emptySizeBox()),
//         ],
//       ).marginSymmetric(horizontal: margin_15),
//     );
//   }
//
//   _containerDesign({image, title}) {
//     return Column(
//       children: [
//         Container(
//           height: height_90,
//           width: height_90,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(radius_10),
//               border: Border.all(color: Colors.black)),
//           child: ClipRRect(
//               borderRadius: BorderRadius.circular(radius_10),
//               child: AssetImageWidget(
//                 imageUrl: image,
//                 imageFitType: BoxFit.fill,
//               )),
//         ),
//         TextView(
//                 text: title,
//                 textStyle: textStyleBodyMedium().copyWith(fontSize: font_14))
//             .marginSymmetric(vertical: margin_5),
//       ],
//     ).marginOnly(left: margin_10);
//   }
//
//   _button({onTap}) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: MaterialButtonWidget(
//         buttonRadius: radius_20,
//         minWidth: Get.width * 0.25,
//         padding: margin_8,
//         buttonText: keyUpdate.tr,
//         buttonColor: Colors.grey.shade800,
//         onPressed: onTap,
//       ),
//     );
//   }
//
//   _bodyDataDetail() => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _titleAndEdit(
//               title: keyBodyData.tr,
//               onTap: () {
//                 controllers.isEdit.value = !controllers.isEdit.value;
//               }),
//           _customText("${keyWeight.tr} : 60"),
//           _customText("${keyHeight.tr} : 156"),
//           _customText("${keyAge.tr} : 25"),
//           Row(
//             children: [
//               Icon(
//                 Icons.remove_red_eye_outlined,
//                 color: Colors.black,
//                 size: font_20,
//               ).marginOnly(left: margin_10),
//               TextView(
//                   text: keyViewBloodTestForm.tr,
//                   textStyle: textStyleBody2().copyWith(
//                       fontWeight: FontWeight.w400,
//                       fontSize: font_13,
//                       decoration: TextDecoration.underline)),
//             ],
//           ).marginSymmetric(vertical: margin_10)
//         ],
//       );
//
//   _editBodyDataDetailForm() {
//     return Form(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextView(
//                   text: keyBodyData.tr,
//                   textStyle:
//                       textStyleBody2().copyWith(fontWeight: FontWeight.bold))
//               .marginOnly(bottom: margin_10),
//           EditRow(
//             title: keyWeight.tr,
//             texField: TextFieldWidget(
//               radius: radius_10,
//               hint: '60',
//               decoration: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius_10),
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               isOutlined: true,
//               hintStyle: textStyleBodyMedium()
//                   .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: margin_10, horizontal: margin_15),
//               textController: controllers.weightController,
//               inputAction: TextInputAction.next,
//               inputType: TextInputType.text,
//               validate: (value) => Validator.ValidateFields(value),
//             ),
//           ),
//           EditRow(
//             title: keyHeight.tr,
//             texField: TextFieldWidget(
//               radius: radius_10,
//               hint: '170',
//               maxLength: 10,
//               inputAction: TextInputAction.next,
//               inputType: TextInputType.number,
//               decoration: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius_10),
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               isOutlined: true,
//               hintStyle: textStyleBodyMedium()
//                   .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: margin_10, horizontal: margin_15),
//               textController: controllers.heightController,
//               validate: (value) => Validator.ValidateFields(value),
//             ),
//           ),
//           EditRow(
//             title: keyAge.tr,
//             texField: TextFieldWidget(
//               radius: radius_10,
//               hint: '27',
//               decoration: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius_10),
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               isOutlined: true,
//               hintStyle: textStyleBodyMedium()
//                   .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: margin_10, horizontal: margin_15),
//               textController: controllers.ageController,
//               inputAction: TextInputAction.done,
//               inputType: TextInputType.emailAddress,
//               validate: (value) => Validator.ValidateName(value),
//             ),
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.remove_red_eye_outlined,
//                 color: Colors.black,
//                 size: font_20,
//               ).marginOnly(left: margin_10),
//               TextView(
//                   text: keyViewBloodTestForm.tr,
//                   textStyle: textStyleBody2().copyWith(
//                       fontWeight: FontWeight.w400,
//                       fontSize: font_13,
//                       decoration: TextDecoration.underline)),
//             ],
//           ).marginSymmetric(vertical: margin_10)
//         ],
//       ),
//     );
//   }
//
//   Widget EditRow({required String title, required Widget texField}) => Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: TextView(
//                     textAlign: TextAlign.start,
//                     text: title + " :",
//                     textStyle: textStyleBody2().copyWith(
//                         fontWeight: FontWeight.bold, fontSize: font_12))
//                 .paddingOnly(top: margin_11, right: margin_5),
//           ),
//           Expanded(flex: 3, child: texField),
//         ],
//       ).paddingOnly(bottom: margin_10);
//
//   _customText(text) => TextView(
//           text: text,
//           textStyle: textStyleBody2()
//               .copyWith(fontWeight: FontWeight.w400, fontSize: font_12))
//       .paddingOnly(top: margin_10);
//
//   Widget _titleAndEdit({title, onTap}) {
//     return Row(
//       children: [
//         TextView(
//             text: title,
//             textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.bold)),
//         Spacer(),
//         onTap != null
//             ? GestureDetector(
//                 onTap: onTap,
//                 child: Icon(
//                   Icons.mode_edit_outlined,
//                   size: height_18,
//                 ),
//               )
//             : emptySizeBox()
//       ],
//     );
//   }
//
//   _medicalQuestionairesView() {
//     return Column(
//       children: [
//         Obx(
//           () => _titleAndEdit(
//               title: keyMedicalQuestionnaire.tr,
//               onTap: controllers.editMedicalQus.value
//                   ? null
//                   : () {
//                       controllers.editMedicalQus.value =
//                           !controllers.editMedicalQus.value;
//                     }),
//         ),
//         _medicalQuestionnairesList(),
//       ],
//     );
//   }
//
//   _medicalQuestionnairesList() {
//     return Obx(() => ListView.separated(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: controllers.medicalQuestionList.length,
//           itemBuilder: (context, index) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextView(
//                         text: '${index + 1}. ', textStyle: textStyleBody2()),
//                     Expanded(
//                       child: TextView(
//                           textAlign: TextAlign.start,
//                           text:
//                               controllers.medicalQuestionList[index].question ??
//                                   '',
//                           textStyle:
//                               textStyleBody2().copyWith(fontSize: font_13)),
//                     ),
//                   ],
//                 ),
//                 controllers.editMedicalQus.value
//                     ? Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Radio(
//                                 activeColor: Colors.black,
//                                 // groupValue: controllers.groupValue[index],
//                                 groupValue: controllers
//                                     .medicalQuestionList[index].groupValue,
//                                 value: controllers
//                                     .medicalQuestionList[index].isSelected,
//                                 onChanged: (val) {
//                                   controllers.medicalQuestionList[index]
//                                           .isSelected =
//                                       !controllers.medicalQuestionList[index]
//                                           .isSelected;
//                                   controllers.medicalQuestionList.refresh();
//                                   print(val);
//                                 },
//                               ),
//                               TextView(
//                                   text: 'Yes', textStyle: textStyleBody2()),
//                               Radio(
//                                 activeColor: Colors.black,
//                                 // groupValue: controllers.groupValue[index],
//                                 groupValue: controllers
//                                     .medicalQuestionList[index].groupValue,
//                                 value: !controllers
//                                     .medicalQuestionList[index].isSelected,
//                                 onChanged: (val) {
//                                   print(val);
//                                   controllers.medicalQuestionList[index]
//                                           .isSelected =
//                                       !controllers.medicalQuestionList[index]
//                                           .isSelected;
//                                   controllers.medicalQuestionList.refresh();
//                                 },
//                               ),
//                               TextView(text: 'No', textStyle: textStyleBody2()),
//                             ],
//                           ),
//                           if (controllers.medicalQuestionList[index].isSelected)
//                             _detailForm(),
//                         ],
//                       )
//                     : TextView(
//                             text:
//                                 controllers.medicalQuestionList[index].answer ??
//                                     '',
//                             textStyle: textStyleBodySmall().copyWith(
//                                 fontSize: font_11, fontWeight: FontWeight.w400))
//                         .marginSymmetric(horizontal: margin_15),
//               ],
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return Divider(
//               color: Colors.grey.shade400,
//               thickness: 1.3,
//             ).marginSymmetric(vertical: margin_10);
//           },
//         ).marginSymmetric(vertical: margin_10));
//   }
//
//   _detailForm() {
//     return EditRow(
//       title: keyDetail.tr,
//       texField: TextFieldWidget(
//         radius: radius_10,
//         hint: 'I have blood pressure problem.',
//         decoration: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius_10),
//             borderSide: BorderSide(color: Colors.grey.shade400)),
//         isOutlined: true,
//         hintStyle: textStyleBodyMedium()
//             .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
//         contentPadding:
//             EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
//         textController: controllers.detailController,
//         inputAction: TextInputAction.done,
//         inputType: TextInputType.text,
//         validate: (value) => Validator.ValidateFields(value),
//       ),
//     );
//   }
// }
