/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:ui';

import 'package:health_fitness/app/routes/app_pages.dart';

import '../../export.dart';
import 'app/core/internet_check/dependency.dart';
import 'app/core/translations/translation_service.dart';
import 'app/modules/authentication/model/login_data_model.dart';

var log = Logger();
GetStorage storage = GetStorage();
APIRepository repository = APIRepository();
// FlutterLogger flutterLogger = FlutterLogger.getInstance();
PreferenceManger preferenceManger = PreferenceManger();
CustomLoader customLoader = CustomLoader();
LoginDataModel? loginDataModel;
TextTheme textTheme = Theme.of(Get.context!).textTheme;
var tempDir;

String lastAccessedTime = "";

class GlobalVariable {
  static final GlobalKey<ScaffoldMessengerState> navState =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}

Future<void> main() async {
  initApp();
  WidgetsFlutterBinding.ensureInitialized();
  APIRepository();
  DependencyInjection.init();
  // await Firebase.initializeApp();
  // FirebaseMessaging?.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await PushNotificationsManager().init(); //activate push notification
  await GetStorage.init();
  tempDir = await getTemporaryDirectory();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: colorLightGray,
  ));

  PlatformDispatcher.instance.onError = (error, stack) {
    reportCrash(error.toString() + '\n' + stack.toString());
    return true;
  };

  FlutterError.onError = (details) async {
    if (details.stack != null) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      reportCrash(
          details.exception.toString() + '\n' + details.stack.toString());
    } else {
      FlutterError.presentError(details);
    }
  };
}

initApp() async {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stack) {
    debugPrint("error Received $error");
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (context, widget) => GetMaterialApp(
          textDirection: TextDirection.rtl,
         // theme: ThemeConfig.lightTheme,
          initialBinding: SplashBinding(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          scaffoldMessengerKey: GlobalVariable.navState,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: LoggerX.write,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          builder: EasyLoading.init(),
          defaultTransition: Transition.cupertino,
        ),
      ),
    );
  }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      //  setUserActive(0);
    }
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {
    } else if (state == AppLifecycleState.inactive) {
      preferenceManger.saveLastAppTime(DateTime.now().toString());
      preferenceManger.saveButtonClicked(false);
    } else if (state == AppLifecycleState.hidden) {
    } else if (state == AppLifecycleState.detached) {
      preferenceManger.saveLastAppTime(DateTime.now().toString());
      preferenceManger.saveButtonClicked(false);
    }
  }
}
