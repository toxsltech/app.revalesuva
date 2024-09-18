import 'package:audioplayers/audioplayers.dart';

import '../../../../export.dart';
import '../models/response_models/podcast_details_response.dart';

class PodcastDetailController extends GetxController {
  @override
  void onClose() {
    audioPlayer.value.stop();
    // TODO: implement onClose
    super.onClose();
  }

  final Rx<AudioPlayer> audioPlayer = AudioPlayer().obs;
  RxInt progress = 0.obs;
  int page = 0;
  ScrollController scrollController = ScrollController();

  var productId;
  PodcastListDetailsResponseModel podcastListDetailsResponseModel =
      PodcastListDetailsResponseModel();
  RxList<PodcastDetails> podcastDetails = <PodcastDetails>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      productId = Get.arguments["productId"];
      getPodCastDetails();
    }
    super.onInit();
  }
  RxBool isLoading = false.obs;

  getPodCastDetails() {
    isLoading.value= true;
    podcastDetails.clear();
    APIRepository()
        .podcastDetailsListApiCall(page: page, productId: productId)
        .then(
      (value) {
        isLoading.value= false;
        if (value != null) {
          podcastListDetailsResponseModel = value;
          podcastDetails.value
              .addAll(podcastListDetailsResponseModel.list ?? []);
          podcastDetails.refresh();
          isLoading.value= false;
          update();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        isLoading.value= true;
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  void initStreams(index) {
    audioPlayer.value.getDuration().then(
      (value) {
        duration = value;
        debugPrint("dfsdfdsdsdf ${value.toString().split(".").first}");
        update();
        return duration;
      },
    );
    audioPlayer.value.getCurrentPosition().then(
      (value) {
        return audioPosition = value;
      },
    );
    update();
    debugPrint("dfsdfdsdsdf ${duration.toString().split(".").first}");
    _durationSubscription = audioPlayer.value.onDurationChanged.listen(
      (durations) {
        // duration = durations;
        debugPrint("Duration :: " + duration.toString());
        update();
      },
    );

    _positionSubscription = audioPlayer.value.onPositionChanged.listen(
      (positions) {
        audioPosition = positions;
        debugPrint("Position : " + audioPosition.toString());
        update();
      },
    );

    _playerCompleteSubscription = audioPlayer.value.onPlayerComplete.listen(
      (event) {
        audioPlayer.value.seek(Duration.zero);
        audioPosition = Duration.zero;
        // podcastDetails.value[index].isPlaying = false;
        audioPlayer.value.stop();
        audioPlayer.value = AudioPlayer();
        debugPrint("Audio Complete");
        // getPodCastDetails();
        podcastDetails.refresh();
        update();
      },
    );

    RxBool isPlaying = false.obs;

    _playerStateChangeSubscription =
        audioPlayer.value.onPlayerStateChanged.listen(
      (state) {
        podcastDetails.value[index].isPlaying = false;
      },
    );
  }

  paginateItemsList(int page) {
    scrollController.addListener(
      () async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (page < podcastListDetailsResponseModel.meta!.pageCount! - 1) {
            page++;
            getPodCastDetails();
          }
        }
      },
    );
  }

  Duration? duration;
  Duration? audioPosition;
  RxList<episodeModel> episodeList = [
    episodeModel(
        title: "Episode 1",
        description: "First podcast on this topic",
        song:
            'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
        isPlaying: false), //assets/icons/about.png
    episodeModel(
        title: "Episode 2",
        description: "Second podcast on this topic",
        song:
            'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
        isPlaying: false),
    episodeModel(
        title: "Episode 3",
        description: "Third podcast on this topic",
        song:
            'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
        isPlaying: false), //assets/music/mp3.wav
  ].obs;

  Future<void> playSong(String filePath) async {
    // await audioPlayer.value.setSourceAsset(filePath);
    // await audioPlayer.value.play(UrlSource(filePath));
    await audioPlayer.value.play(UrlSource('https://example.com/my-audio.wav'));
  }

  Future<void> pauseSong(String filePath) async {
    await audioPlayer.value.pause();
  }

  void updateProgress(String? song, int position, int duration) {
    this.progress.value = position;

    // this.duration.value = duration;

    update();
  }

  Future<void> _playAudio(String url) async {
    await audioPlayer.value.play(UrlSource(url));

    audioPlayer.value.pause();
  }
}

class episodeModel {
  String? title;
  String? description;
  String? song;
  bool? isPlaying;

  episodeModel({this.title, this.description, this.song, this.isPlaying});
}
