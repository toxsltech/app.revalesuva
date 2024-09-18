import '../../../export.dart';
import '../staticPages/controllers/static_page_controller.dart';

class DrawerWidget extends StatelessWidget {
  final List<DrawerModel> drawerList;
  DrawerWidget({super.key, required this.drawerList});

  final StaticPageController staticPageController =
      Get.put(StaticPageController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final MyAccountModel? myAccountModel = MyAccountModel();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backGroundColor,
      width: Get.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_sharp),
              ),
              _profileImage(),
              Container(
                padding: EdgeInsets.all(margin_10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius_10),
                ),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: drawerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return listTile(
                        icon: drawerList[index].icon,
                        text: drawerList[index].title,
                        onTap: drawerList[index].onTap);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: textFieldColor,
                      thickness: 1.3,
                    );
                  },
                ),
              ).marginSymmetric(horizontal: margin_15, vertical: margin_15)
            ],
          ),
        ],
      ),
    );
  }

  _profileImage() {
    return Center(
      child: Column(
        children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            CircleAvatar(
              radius: radius_50,
              backgroundColor: Colors.grey.shade300,
              child: AssetImageWidget(
                imageUrl: iconProfile,
                imageFitType: BoxFit.fill,
              ),
            ).paddingAll(margin_20),
            Positioned(
                child: IconButton(
              icon: Icon(
                Icons.edit,
                size: height_15,
              ),
              onPressed: () {},
              splashRadius: radius_5,
              style: IconButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.green.shade100),
            ))
          ]),
          TextView(
                  text: 'לערוך תמונה',
                  // text: 'Edit a photo',
                  textStyle: textStyleBodySmall().copyWith(
                      fontSize: font_13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white))
              .marginOnly(top: margin_5)
        ],
      ),
    );
  }

  listTile({text, icon, onTap}) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              AssetImageWidget(
                      imageUrl: icon,
                      imageHeight: 20,
                      imageWidth: 20,
                      imageFitType: BoxFit.contain)
                  .marginOnly(right: margin_10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: font_15,
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );
}

Widget profileHeader(loginController, homeController) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              TextView(
                text: 'Username',
                textStyle: textStyleTitle(),
              ),
              TextView(
                text: loginController.myAccountModel?.email ?? '',
                textStyle: textStyleTitle(),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
    );
