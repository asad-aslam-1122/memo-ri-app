import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/landing/onboard/model/onboard_model.dart';
import 'package:memo_ri_app/utlits/image_picker/image_widget.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../resources/resources.dart';
import '../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../utlits/will_pop_widget.dart';
import '../../../language/view/language_view.dart';

class OnboardView extends StatefulWidget {
  static final String route = "/OnboardView";
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final PageController pageController = PageController();

  int pageIndexValue = 0;

  List<OnboardModel> onboardModelList = [
    OnboardModel(
      title: "turn_moments_into_memories",
      subTitle: "Easily_capture_organize_and_cherish_your_special_moments",
      imagePath: R.appImages.onBoard1,
    ),
    OnboardModel(
      title: "turn_moments_into_memories",
      subTitle: "create_beautiful_albums_with_personalized_themes_and_music",
      imagePath: R.appImages.onBoard2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: PopScopeWidget.onPopInvokedWithResult,
      child: SafeAreaWidget(
        top: true,
        backgroundColor: R.appColors.primaryColor,
        child: Scaffold(
          backgroundColor: R.appColors.primaryColor,
          body: Stack(
            children: [
              Positioned(
                left: -8.w,
                top: 10.h,
                child: GlobalWidgets.circleContainer(width: 22.w),
              ),
              Positioned(
                right: -8.w,
                bottom: 10.h,
                child: GlobalWidgets.circleContainer(width: 22.w),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed(LanguageView.route,
                            arguments: {"isFromSetting": false});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, top: 12),
                        child: Text(
                          "skip".L(),
                          style: R.textStyles.urbanist(
                              color: R.appColors.white, fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (newIndex) {
                        pageIndexValue = newIndex;
                        setState(() {});
                      },
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return pageViewManager(index: index);
                      },
                      itemCount: onboardModelList.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ) +
                        EdgeInsets.only(bottom: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                            controller: pageController,
                            count: onboardModelList.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: R.appColors.white,
                                dotHeight: 7,
                                dotWidth: 20,
                                expansionFactor: 1.3,
                                dotColor:
                                    R.appColors.white.withValues(alpha: 0.7)),
                            onDotClicked: (index) {}),
                        IconButton(
                            style: R.decoration.iconButtonDeco(),
                            onPressed: () {
                              if (pageIndexValue <
                                  onboardModelList.length - 1) {
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Get.offAllNamed(LanguageView.route,
                                    arguments: {"isFromSetting": false});
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: R.appColors.primaryColor,
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pageViewManager({required int index}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageWidget(
            height: 100.w,
            width: 100.w,
            isProfile: false,
            isFile: true,
            showCameraIcon: false,
            assetImagePath: onboardModelList[index].imagePath,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  onboardModelList[index].title.L(),
                  style: R.textStyles.urbanist(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w700,
                      color: R.appColors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  onboardModelList[index].subTitle.L(),
                  style: R.textStyles
                      .urbanist(fontSize: 16.sp, color: R.appColors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
