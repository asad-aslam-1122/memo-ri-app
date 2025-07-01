import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/resources.dart';
import 'package:memo_ri_app/routes/app_routes.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view_model/event_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view_model/home_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view_mode/memory_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view_model/subscription_vm.dart';
import 'package:memo_ri_app/src/core/no_internet_view.dart';
import 'package:memo_ri_app/src/landing/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: R.appColors.transparent,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventVm()),
        ChangeNotifierProvider(create: (context) => HomeVm()),
        ChangeNotifierProvider(create: (context) => SubscriptionVm()),
        ChangeNotifierProvider(create: (context) => MemoryVm()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          Get.to(() => const NoInternetScreen());
        }
        break;
      default:
        break;
    }
  }

  void startConnectionStream() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        getPages: AppRoutes.pages,
        theme: ThemeData(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: R.appColors.white,
              hourMinuteColor: R.appColors.primaryColor,
              hourMinuteTextColor: R.appColors.white,
              dialHandColor: R.appColors.primaryColor,
              dialTextStyle: R.textStyles.urbanist(
                  color: WidgetStateColor.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return R.appColors.white;
                      }
                      return R.appColors.primaryColor;
                    },
                  ),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              dayPeriodTextStyle: R.textStyles.urbanist(
                  // color: WidgetStateColor.resolveWith(
                  //   (states) {
                  //     if (states.contains(WidgetState.selected)) {
                  //       return R.appColors.white;
                  //     }
                  //     return R.appColors.primaryColor;
                  //   },
                  // ),
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              dialBackgroundColor:
                  R.appColors.highLightColor.withValues(alpha: .3),
              dayPeriodBorderSide: BorderSide(color: R.appColors.borderColor),
              dayPeriodColor: R.appColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hourMinuteTextStyle: R.textStyles.urbanist(
                color: R.appColors.white,
                fontSize: 28.sp,
              ),
              timeSelectorSeparatorTextStyle: WidgetStatePropertyAll(R
                  .textStyles
                  .urbanist(fontSize: 30.sp, fontWeight: FontWeight.w900)),
              timeSelectorSeparatorColor:
                  WidgetStatePropertyAll(R.appColors.black),
              cancelButtonStyle: ButtonStyle(
                textStyle: WidgetStatePropertyAll(R.textStyles.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: R.appColors.black)),
                backgroundColor: WidgetStatePropertyAll(R.appColors.white),
                foregroundColor:
                    WidgetStatePropertyAll(R.appColors.middleGreyColor),
                overlayColor:
                    WidgetStatePropertyAll(R.appColors.middleGreyColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: R.appColors.middleGreyColor),
                  ),
                ),
              ),
              confirmButtonStyle: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(R.appColors.primaryColor),
                foregroundColor: WidgetStatePropertyAll(R.appColors.white),
                overlayColor: WidgetStatePropertyAll(R.appColors.primaryColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: R.appColors.middleGreyColor),
                  ),
                ),
              ),
            ),
            primaryColor: R.appColors.primaryColor,
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(R.appColors.white))),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: R.appColors.primaryColor,
              selectionColor: R.appColors.primaryColor.withValues(alpha: 0.5),
              selectionHandleColor: R.appColors.primaryColor,
            )),
        title: 'Memo-ri',
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: SplashView.route,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
