import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/login_view.dart';
import 'package:memo_ri_app/src/language/model/language_model.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../utlits/safe_area_widget.dart';
import '../../../utlits/image_picker/image_widget.dart';

class LanguageView extends StatefulWidget {
  static final String route = "/LanguageView";

  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  List<LanguageModel> languageModelList = [
    LanguageModel(imagePath: R.appImages.usaFlag, countryName: "english"),
    LanguageModel(imagePath: R.appImages.spanishFlag, countryName: "spanish"),
  ];

  bool? isFromSetting;

  int selectedLang = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isFromSetting = Get.arguments["isFromSetting"];

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        appBar: GlobalWidgets.bottomSheetAppBar(
          showBackArrowBtn: (isFromSetting ?? false),
        ),
        backgroundColor: R.appColors.primaryColor,
        bottomSheet: bottomSheetBody(),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: R.decoration.bottomSheetDecor(),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "select_your_language".L(),
                    style: R.textStyles
                        .urbanist(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ...List.generate(
                    languageModelList.length,
                    (index) => languageItemWidget(index: index),
                  )
                ],
              ),
            ),
          ),
          CustomButton(
              onPressed: () => (isFromSetting ?? false)
                  ? Get.back()
                  : Get.offAllNamed(LoginView.route),
              title: "continue"),
        ],
      ),
    );
  }

  Widget languageItemWidget({required int index}) {
    return GestureDetector(
      onTap: () {
        selectedLang = index;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selectedLang == index
                ? R.appColors.primaryColor
                : R.appColors.white,
            border: Border.all(
                color: selectedLang != index
                    ? R.appColors.borderColor
                    : R.appColors.primaryColor,
                width: 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ImageWidget(
                  height: 40,
                  width: 40,
                  isFile: true,
                  showCameraIcon: false,
                  assetImagePath: languageModelList[index].imagePath,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  languageModelList[index].countryName.L(),
                  style: R.textStyles.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: selectedLang == index
                          ? R.appColors.white
                          : R.appColors.hintColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
