import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view_model/subscription_vm.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/simple_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../utlits/safe_area_widget.dart';
import '../../../../../../utlits/timeline_stepper/timeline_stepper_widget.dart';
import '../../../base_view.dart';

class SubscriptionView extends StatefulWidget {
  static final String route = "/SubscriptionView";

  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView>
    with SingleTickerProviderStateMixin {
  bool? isFromSetting;

  @override
  void initState() {
    super.initState();

    isFromSetting = Get.arguments["isFromSetting"];

    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  late TabController tabController;

  List<String> onetimeCoreFeatures = [
    "lifetime_access_to_the_apps_core_features_like_audio_tracks_and_image_editor",
  ];
  List<String> annualCoreFeatures = [
    "access_to_all_audio",
    "add_unlimited_images_in_the_video",
  ];
  List<String> monthlyCoreFeatures = [
    "limited_audios",
    "add_limited_images_in_the_video_eg_15_images",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Consumer<SubscriptionVm>(
          builder: (context, subscriptionVm, child) => DefaultTabController(
                initialIndex: 0,
                length: tabBarOptions.length,
                child: Scaffold(
                  appBar: GlobalWidgets.bottomSheetAppBar(
                      showBackArrowBtn: isFromSetting ?? false),
                  backgroundColor: R.appColors.primaryColor,
                  body: bottomSheetBody(subscriptionVm: subscriptionVm),
                ),
              )),
    );
  }

  List<String> tabBarOptions = [
    "one_time",
    "annual",
    "monthly",
  ];

  Widget bottomSheetBody({required SubscriptionVm subscriptionVm}) {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: R.decoration.bottomSheetDecor(),
      child: Column(
        children: [
          Text(
            "how_your_trial_works".L(),
            style: R.textStyles
                .urbanist(fontSize: 21.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "first_30_days_free_and_150mb_cloud_storage".L(),
            style: R.textStyles.urbanist(fontSize: 16.sp),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 39,
              width: 80.w,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              decoration: R.decoration.generalDecoration(
                  radius: 20, backgroundColor: R.appColors.lightGreyColor),
              child: TabBar(
                onTap: (index) {
                  setState(() {});
                },
                automaticIndicatorColorAdjustment: true,
                controller: tabController,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: R.appColors.transparent,
                indicatorColor: R.appColors.primaryColor,
                unselectedLabelColor: R.appColors.black,
                indicator: R.decoration.generalDecoration(
                    radius: 20, backgroundColor: R.appColors.primaryColor),
                labelColor: R.appColors.white,
                labelStyle: R.textStyles.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
                tabs: List.generate(
                  tabBarOptions.length,
                  (index) => Tab(
                    icon: Text(
                      tabBarOptions[index].L(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TimelineStepperWidget(
                  isFirst: true,
                  isLast: false,
                  isPast: true,
                  leadingImage: R.appImages.checkIcon,
                  widget: endWidgetTile(
                      title: tileTitleManager(),
                      subTitleWidget: firstSubtitleWidget()),
                ),
                TimelineStepperWidget(
                  isFirst: false,
                  isLast: false,
                  isPast: true,
                  leadingImage: R.appImages.appsIcon,
                  widget: endWidgetTile(
                      title: "core_features".L(),
                      subTitleWidget: coreSubTitleWidget(
                          coreFeatList: coreFeatSubTitleManager())),
                ),
                TimelineStepperWidget(
                  isFirst: false,
                  isLast: true,
                  isPast: false,
                  leadingImage: R.appImages.databaseIcon,
                  widget: endWidgetTile(
                      title: "cloud_storage".L(),
                      subTitleWidget: Text(
                        "${"you_will_receive".L()} ${cloudStorageSpace()}gb ${"cloud_storage".L()}.",
                        style: R.textStyles.urbanist(fontSize: 15.sp),
                      )),
                ),
                if (subscriptionVm.hasSubscribed) ...[
                  SizedBox(
                    height: 10,
                  ),
                  subscribedContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  clickingOnSub()
                ],
              ],
            ),
          )),
          if (!subscriptionVm.hasSubscribed) clickingOnSub(),
          CustomButton(
              onPressed: () async {
                if (subscriptionVm.hasSubscribed) {
                  Get.bottomSheet(SimpleSheet(
                      onRightPressed: () async {
                        subscriptionVm.hasSubscribed = false;
                        await Get.offAllNamed(BaseView.route);
                        subscriptionVm.update();

                        if (subscriptionVm.hasSubscribed == false) {
                          ZBotToast.showToastSuccess(
                            message: "package_unsubscribed".L(),
                            subTitle:
                                "you_successfully_un_subscribed_the_package"
                                    .L(),
                          );
                        }
                      },
                      rightBtnTitle: "unsubscribe",
                      iconColor: null,
                      imagePath: R.appImages.unSubscribedImg,
                      subTitle:
                          "are_you_sure_you_want_to_unsubscribe_this_package"
                              .L()));
                } else {
                  subscriptionVm.hasSubscribed = true;
                  await Get.offAllNamed(BaseView.route);
                  subscriptionVm.update();
                }
              },
              backgroundColor:
                  subscriptionVm.hasSubscribed ? R.appColors.white : null,
              borderColor: subscriptionVm.hasSubscribed
                  ? R.appColors.primaryColor
                  : null,
              textColor: subscriptionVm.hasSubscribed
                  ? R.appColors.primaryColor
                  : null,
              title: subscriptionVm.hasSubscribed
                  ? "unsubscribe"
                  : "subscribe_now"),
          if (subscriptionVm.hasFreeTrial && !subscriptionVm.hasSubscribed)
            freeTrialWidget(subscriptionVm: subscriptionVm),
        ],
      ),
    );
  }

  Widget clickingOnSub() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 35) + EdgeInsets.only(bottom: 20),
      child: Text(
        "by_clicking_on_subscribe_you_agree_to_privacy_policy_and_terms_condition"
            .L(),
        textAlign: TextAlign.center,
        style: R.textStyles.urbanist(fontSize: 15.sp),
      ),
    );
  }

  Widget firstSubtitleWidget() {
    if (tabController.index == 0) {
      return RichText(
        text: TextSpan(
          style: R.textStyles.urbanist(fontSize: 15.sp),
          children: [
            TextSpan(
              text: "\$20.00\t",
              style: R.textStyles.urbanist(
                  fontWeight: FontWeight.w600,
                  color: R.appColors.primaryColor,
                  fontSize: 21.sp),
            ),
            TextSpan(
              text: "a_one_time_fixed_price".L(),
            ),
          ],
        ),
      );
    } else if (tabController.index == 1) {
      return RichText(
        text: TextSpan(
          style: R.textStyles.urbanist(
              fontSize: 15.sp,
              color: R.appColors.primaryColor,
              fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: "\$30.00\t",
                style: R.textStyles.urbanist(
                    fontWeight: FontWeight.w600,
                    color: R.appColors.primaryColor,
                    fontSize: 21.sp)),
            TextSpan(
              text: "\$35.00",
              style: R.textStyles.urbanist(
                  fontWeight: FontWeight.w600,
                  textDecoration: TextDecoration.lineThrough,
                  color: R.appColors.middleGreyColor,
                  fontSize: 16.sp),
            ),
            TextSpan(
                text: "\t \$2.8\t",
                style: R.textStyles.urbanist(
                    fontWeight: FontWeight.w600,
                    color: R.appColors.primaryColor,
                    fontSize: 21.sp)),
            TextSpan(text: "per_month".L()),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: R.textStyles.urbanist(
              fontSize: 15.sp,
              color: R.appColors.primaryColor,
              fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: "\$4.00\t",
                style: R.textStyles.urbanist(
                    fontWeight: FontWeight.w600,
                    color: R.appColors.primaryColor,
                    fontSize: 21.sp)),
            TextSpan(text: "per_month".L()),
          ],
        ),
      );
    }
  }

  Widget coreSubTitleWidget({required List<String> coreFeatList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        coreFeatList.length,
        (index) {
          return Text(
            "${coreFeatList[index].L()}.",
            style: R.textStyles.urbanist(fontSize: 15.sp),
          );
        },
      ),
    );
  }

  Widget freeTrialWidget({required SubscriptionVm subscriptionVm}) {
    return GestureDetector(
      onTap: () {
        subscriptionVm.hasFreeTrial = false;
        subscriptionVm.update();
        Get.offAllNamed(BaseView.route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
              horizontal: 20,
            ) +
            EdgeInsets.only(top: 12),
        color: R.appColors.white,
        child: Center(
          child: Text(
            "start_my_free_trial".L(),
            style: R.textStyles.urbanist(
                fontSize: 15.sp,
                color: R.appColors.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  String tileTitleManager() {
    if (tabController.index == 0) {
      return "life_time".L();
    } else if (tabController.index == 1) {
      return "annual".L();
    } else {
      return "monthly".L();
    }
  }

  String cloudStorageSpace() {
    if (tabController.index == 0) {
      return "50";
    } else if (tabController.index == 1) {
      return "150";
    } else {
      return "50";
    }
  }

  List<String> coreFeatSubTitleManager() {
    if (tabController.index == 0) {
      return onetimeCoreFeatures;
    } else if (tabController.index == 1) {
      return annualCoreFeatures;
    } else {
      return monthlyCoreFeatures;
    }
  }

  Widget endWidgetTile({
    required String title,
    required Widget subTitleWidget,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
            horizontal: 12,
          ) +
          EdgeInsets.only(top: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: R.textStyles
                .urbanist(fontWeight: FontWeight.w700, fontSize: 17.sp),
          ),
          subTitleWidget,
        ],
      ),
    );
  }

  Widget subscribedContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12) +
          EdgeInsets.only(left: 20, right: 10),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: R.appColors.lightGreyColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: R.textStyles.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: R.appColors.primaryColor,
                  ),
                  children: [
                    TextSpan(text: "next_subscription".L()),
                    TextSpan(
                      text:
                          " \t ${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                    ),
                  ])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0) +
                EdgeInsets.only(top: 5),
            child: LinearPercentIndicator(
              lineHeight: 4,
              animation: true,
              animationDuration: 500,
              animateFromLastPercent: true,
              percent: 50 / 150,
              barRadius: Radius.circular(8),
              progressColor: R.appColors.primaryColor,
              backgroundColor: R.appColors.hintColor,
              padding: EdgeInsets.only(right: 25.w),
            ),
          ),
          Text(
            "${"storage_left".L()}  50/150 gb",
            style: R.textStyles
                .urbanist(fontWeight: FontWeight.w500, fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}
