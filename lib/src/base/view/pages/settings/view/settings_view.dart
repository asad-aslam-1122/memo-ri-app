import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/change_password_view.dart';
import 'package:memo_ri_app/src/auth/view/login_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/contact_us_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/delete_account_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/my_profile_view.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view/subscription_view.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view_model/subscription_vm.dart';
import 'package:memo_ri_app/src/language/view/language_view.dart';
import 'package:memo_ri_app/utlits/custom_switch_button.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:memo_ri_app/utlits/simple_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../auth/view/terms_and_privacy_view.dart';
import '../model/settings_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<SettingsModel> credentialSegmentList = [
    SettingsModel(
        imagePath: R.appImages.profileUserIcon, title: "my_profile", id: 0),
    SettingsModel(
        imagePath: R.appImages.passwordIcon, title: "change_password", id: 1),
    SettingsModel(
        imagePath: R.appImages.languageIcon, title: "change_language", id: 2),
  ];

  List<SettingsModel> termsPolicySegmentList = [
    SettingsModel(
        imagePath: R.appImages.termsIcon, title: "terms_of_conditions", id: 3),
    SettingsModel(
        imagePath: R.appImages.privacyIcon, title: "privacy_policy", id: 4),
    SettingsModel(
        imagePath: R.appImages.contactUsIcon, title: "contact_us", id: 5),
  ];

  List<SettingsModel> leaveAccountSegmentList = [
    SettingsModel(
        imagePath: R.appImages.deleteIcon, title: "delete_account", id: 6),
    SettingsModel(imagePath: R.appImages.logoutIcon, title: "logout", id: 7),
  ];

  int remainDays = 2;
  int leftSpace = 50;
  int totalSpace = 150;
  bool fingerPrintEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionVm>(builder: (context, subscriptionVm, child) {
      return Scaffold(
        backgroundColor: R.appColors.lightGreyColor,
        appBar: AppBar(
          backgroundColor: R.appColors.primaryColor,
          surfaceTintColor: R.appColors.primaryColor,
          centerTitle: true,
          title: Text(
            "settings".L(),
            style: R.textStyles.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 19.sp,
                color: R.appColors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: Column(
            children: [
              subscriptionVm.hasSubscribed
                  ? subscribedContainer()
                  : subscribeContainer(subscriptionVm: subscriptionVm),
              SizedBox(
                height: 16,
              ),
              menuListContainer(settingModelList: credentialSegmentList),
              SizedBox(
                height: 16,
              ),
              fingerPrintWidget(),
              SizedBox(
                height: 16,
              ),
              menuListContainer(settingModelList: termsPolicySegmentList),
              SizedBox(
                height: 16,
              ),
              menuListContainer(settingModelList: leaveAccountSegmentList),
            ],
          ),
        ),
      );
    });
  }

  Widget fingerPrintWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: R.decoration.shadowDecor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "fingerprint_login".L(),
            style: R.textStyles
                .urbanist(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          CustomSwitchButton(
              value: fingerPrintEnabled,
              onChanged: (newValue) {
                fingerPrintEnabled = newValue;
                setState(() {});
              },
              color: R.appColors.primaryColor)
        ],
      ),
    );
  }

  Widget subscribeContainer({required SubscriptionVm subscriptionVm}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: R.decoration.shadowDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: R.textStyles.urbanist(
                      fontSize: 15,
                      color: R.appColors.hintColor,
                      fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(text: "free_subscription".L()),
                    TextSpan(
                      text: " \t $remainDays ${"days_left".L()}",
                      style: R.textStyles.urbanist(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: R.appColors.red,
                      ),
                    ),
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "upgrade_to_premium".L(),
                style: R.textStyles
                    .urbanist(fontSize: 17.sp, fontWeight: FontWeight.w600),
              ),
              GlobalWidgets.smallBtn(
                  onPressed: () {
                    subscriptionVm.hasFreeTrial = true;
                    subscriptionVm.update();
                    Get.toNamed(SubscriptionView.route,
                        arguments: {"isFromSetting": true});
                  },
                  title: "subscribe")
            ],
          ),
        ],
      ),
    );
  }

  Widget subscribedContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12) + EdgeInsets.only(left: 20),
      decoration: R.decoration.shadowDecor(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "yearly_plan".L(),
                  style: R.textStyles
                      .urbanist(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: R.textStyles.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: R.appColors.hintColor,
                        ),
                        children: [
                          TextSpan(text: "next_subscription".L()),
                          TextSpan(
                            text:
                                " \t ${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                            style: R.textStyles.urbanist(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: R.appColors.red,
                            ),
                          ),
                        ])),
                SizedBox(
                  height: 8,
                ),
                LinearPercentIndicator(
                  lineHeight: 4,
                  animation: true,
                  animationDuration: 500,
                  animateFromLastPercent: true,
                  percent: leftSpace / totalSpace,
                  barRadius: Radius.circular(8),
                  progressColor: R.appColors.primaryColor,
                  backgroundColor: R.appColors.hintColor,
                  padding: EdgeInsets.only(right: 25.w),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "${"storage_left".L()}  $leftSpace/$totalSpace gb",
                  style: R.textStyles
                      .urbanist(fontWeight: FontWeight.w500, fontSize: 14.sp),
                )
              ],
            ),
          ),
          PopupMenuButton<int>(
            padding: EdgeInsets.all(0),
            elevation: 4,
            iconSize: 16,
            color: R.appColors.white,
            position: PopupMenuPosition.under,
            icon: Icon(
              Icons.more_vert,
              color: R.appColors.black,
            ),
            onSelected: (value) {
              print("Selected: $value");
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  height: 15,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  onTap: () => Get.toNamed(SubscriptionView.route,
                      arguments: {"isFromSetting": true}),
                  child: Text(
                    "unsubscribe".L(),
                    style: R.textStyles
                        .urbanist(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuListContainer({required List<SettingsModel> settingModelList}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: R.decoration.shadowDecor(),
      child: Column(
        children: List.generate(
          settingModelList.length,
          (index) => menuItemWidget(settingModel: settingModelList[index]),
        ),
      ),
    );
  }

  Widget menuItemWidget({required SettingsModel settingModel}) {
    return GestureDetector(
      onTap: () =>
          navigationOnTab(id: settingModel.id, title: settingModel.title.L()),
      child: Container(
        color: R.appColors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  settingModel.imagePath,
                  scale: 4,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  settingModel.title.L(),
                  style: R.textStyles.urbanist(fontSize: 15.sp),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: R.appColors.black.withValues(alpha: 0.6),
            )
          ],
        ),
      ),
    );
  }

  void navigationOnTab({required int id, String? title}) {
    switch (id) {
      case 0:
        {
          print("$title Clicked");
          Get.toNamed(MyProfileView.route);
          break;
        }
      case 1:
        {
          print("$title Clicked");
          Get.toNamed(ChangePasswordView.route,
              arguments: {"isFromSetting": true});
          break;
        }
      case 2:
        {
          print("$title Clicked");
          Get.toNamed(LanguageView.route, arguments: {"isFromSetting": true});
          break;
        }
      case 3:
        {
          print("$title Clicked");
          Get.toNamed(TermsAndPrivacyView.route,
              arguments: {"title": "terms_and_conditions"});
          break;
        }
      case 4:
        {
          print("$title Clicked");
          Get.toNamed(TermsAndPrivacyView.route,
              arguments: {"title": "privacy_policy"});
          break;
        }
      case 5:
        {
          print("$title Clicked");
          Get.toNamed(ContactUsView.route,
              arguments: {"title": "privacy_policy"});
          break;
        }
      case 6:
        {
          print("$title Clicked");
          Get.toNamed(DeleteAccountView.route);
          break;
        }
      case 7:
        {
          print("$title Clicked");
          Get.bottomSheet(SimpleSheet(
            onRightPressed: () => Get.offAllNamed(LoginView.route),
            rightBtnTitle: "logout",
            iconColor: R.appColors.red,
            subTitle: "are_you_sure_you_want_to_logout".L(),
            imagePath: R.appImages.logoutIcon,
          ));
          break;
        }
      default:
        {
          print("Invalid Screen");
          break;
        }
    }
  }
}
