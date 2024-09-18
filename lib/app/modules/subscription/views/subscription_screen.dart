/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */




import 'package:health_fitness/app/modules/subscription/controllers/subscription_controller.dart';

import '../../../../../export.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SubscriptionController>(
            init: SubscriptionController(),
            builder: (controller) {
          return _body();
        }),
      ),
    );
  }

  Widget _body() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: ListView.separated(
          itemCount: controller.subscriptionPlansList.length,
            itemBuilder: (context,index)=>_listItemLayout(
                controller.subscriptionPlansList[index],index
            ),
          separatorBuilder: (context,index)=>SizedBox(height: height_10)

      ),
    );
  }

  Widget _listItemLayout(data,index){
    return Container(
      width: Get.width,
      height: height_180,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(radius_10)
      ),
      margin: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
      padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_20),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextView(
                text: 'Desc',
              maxLine: 5,
              textStyle:textStyleTitle(),
            ),
          ).marginOnly(bottom: height_10),
          MaterialButtonWidget(
              onPressed: () {
                  controller.requestPurchase(
                      controller.getItem()[index],);
              },
              buttonText: 'Subscribe',
              textColor: Colors.black
          ),
        ],
      ),
    );
  }
}

