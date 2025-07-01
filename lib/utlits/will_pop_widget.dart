import 'package:flutter/services.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';

import '../resources/bot_toast/zbot_toast.dart';

class PopScopeWidget {
  static DateTime? currentBackPressTime;

  static onPopInvokedWithResult(didPop, result) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      ZBotToast.showToastSuccess(
        subTitle: "press_again_to_exit".L(),
        message: "press_again".L(),
      );
      return false;
    }
    SystemNavigator.pop();
  }
}
