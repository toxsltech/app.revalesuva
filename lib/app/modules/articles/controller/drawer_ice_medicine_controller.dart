import '../../../../export.dart';
import '../models/data_model/articles_data.dart';
import '../models/response_model/article_detail_response.dart';
import '../models/response_model/articles_response.dart';

class SideDrawerIceMedicineController extends GetxController {
  @override
  void onInit() {
    if (Get.arguments != null) {
      id = Get.arguments["id"];
      getArticleDetails();
    }
    super.onInit();
  }

  var id;

  int page = 0;

  ScrollController scrollController = ScrollController();
  ArticlesListResponseModel articlesListResponseModel =
      ArticlesListResponseModel();
  RxList<ArticleDataModel> articleList = <ArticleDataModel>[].obs;

  ArticlesDetailsResponseModel articlesDetails = ArticlesDetailsResponseModel();

  getArticleDetails() {
    APIRepository().getArticlesDetailsApiCall(id).then(
      (value) {
        if (value != null) {
          articlesDetails = value;
          update();
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

  @override
  void dispose() {
    super.dispose();
  }
}
