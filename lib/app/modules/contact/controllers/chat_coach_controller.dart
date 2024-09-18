import 'package:emoji_selector/emoji_selector.dart';
import 'package:health_fitness/app/modules/contact/models/data_model/chat_data_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../export.dart';
import '../models/chat_response.dart';
import '../models/send_message_response.dart';

class ChatCoachController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    loadChatList();

    timer = Timer.periodic(
      Duration(seconds: 2),
      (timer) => getNewMessage(),
    );

    await Future.delayed(
      Duration(seconds: 1),
    );
    scroll();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  Timer? timer;
  RxBool emptyCheck = true.obs;

  RxString profileImage = "".obs;
  EmojiData? emojiData;
  RxString selectedEmoji = ''.obs;
  ChatMessageResponse chatMessageResponse = ChatMessageResponse();
  SendMessageResponse sendMessageResponse = SendMessageResponse();
  ScrollController scrollController = ScrollController();
  RxList<ChatDataModel> chatList = <ChatDataModel>[].obs;
  TextEditingController chatTextController = TextEditingController();

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImage.value = file.path;
      hitSendMessageApiCall(1, files: profileImage.value);
    }
  }

  var messageType;

  File? idImage;
  String docMessage = "";

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls']);
    if (result != null) {
      idImage = File(result.files.single.path.toString());
      docMessage = idImage!.path;
      debugPrint("file:::$docMessage");
      hitSendMessageApiCall(1, files: docMessage);
    } else {
      toast("No document selected");
    }
  }

  Future<MultipartFile?> convertToMultipart(String image) async {
    debugPrint(":::::::$image");
    MultipartFile? profileMultipartImage;
    if (image != "" && !image.contains("http")) {
      profileMultipartImage =
          await MultipartFile.fromFile(image, filename: image);
    }
    debugPrint("profileMultipartImage ${profileMultipartImage.toString()}");
    return profileMultipartImage;
  }

  hitSendMessageApiCall(type, {String? files}) async {
    debugPrint("Clicked");
    var reqBody = AuthRequestModel.sendMessage(
      message: chatTextController.text.trim(),
      messageFile: await convertToMultipart(files ?? ""),
      type: type,
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().sendMessageApiCall(dataBody: reqBody).then(
      (value) {
        if (value != null) {
          sendMessageResponse = value;
          chatList.add(sendMessageResponse.detail!);
          chatTextController.clear();
          docMessage = "";
          profileImage.value = "";
          profileImage.refresh();
          scroll();
          // toast(messageResponseModel.message);
          update();
        }
        // customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        toast(error.toString());
        // customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      },
    );
  }

  void scroll() {
    debugPrint("Scrolling");
    scrollController.animateTo(100000.0,
        duration: Duration(milliseconds: 5), curve: Curves.easeIn);
  }

  getNewMessage() {
    debugPrint("Getting New Message");
    APIRepository().newMessageApiCall().then((value) {
      chatMessageResponse = value;
      debugPrint("Element:::::::::::::::$value");
      if (chatMessageResponse.list!.isNotEmpty) {
        chatMessageResponse.list!.forEach(
          (element) {
            chatList.add(element);
            scroll();
          },
        );
      }
    }, onError: (error) {
      toast(error.toString());
    });
  }

  loadChatList() {
    chatList.clear();
    APIRepository().loadChatApiCall().then(
      (value) {
        if (value != null) {
          chatMessageResponse = value;
          chatList.value.addAll(
            (chatMessageResponse.list ?? []),
          );
          chatList.refresh();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }
}
