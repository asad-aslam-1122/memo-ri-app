import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import 'my_loader.dart';

class ZBotToast {
  static Future loadingClose() async {
    BotToast.cleanAll();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  static loadingShow() async {
    BotToast.showCustomLoading(
        toastBuilder: (func) {
          return MyLoader(
            color: R.appColors.red,
          );
        },
        allowClick: false,
        clickClose: false,
        backgroundColor: Colors.transparent);
    Future.delayed(const Duration(seconds: 60), () => loadingClose());
  }

  static showToastSuccess(
      {required String message,
      Duration? duration,
      required String subTitle}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin:
                EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: R.appColors.white,
                boxShadow: [
                  BoxShadow(
                      color: R.appColors.black.withValues(alpha: 0.2),
                      spreadRadius: 8,
                      blurRadius: 30)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      R.appImages.successIcon,
                      scale: 4,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message,
                          style: R.textStyles.urbanist(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        Text(
                          subTitle,
                          style: R.textStyles.urbanist(
                              fontSize: 14.sp,
                              color: R.appColors.black.withValues(alpha: .38)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        clickClose: true,
        crossPage: true,
        align: Alignment.topCenter,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 4));
  }

  static showToastError(
      {required String message,
      Duration? duration,
      required String subTitle}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin:
                EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: R.appColors.white,
                boxShadow: [
                  BoxShadow(
                      color: R.appColors.black.withValues(alpha: 0.2),
                      spreadRadius: 8,
                      blurRadius: 30)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message,
                          style: R.textStyles.urbanist(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        Text(
                          subTitle,
                          style: R.textStyles.urbanist(
                              fontSize: 14.sp,
                              color: R.appColors.black.withValues(alpha: .38)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        clickClose: true,
        crossPage: true,
        align: Alignment.topCenter,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 4));
  }

  static showToastSomethingWentWrong({Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFFE6532D),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Error",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            "something_went_wrong".L(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 5));
  }
}
