import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/login_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../../utlits/custom_bottom.dart';
import '../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../utlits/safe_area_widget.dart';

class CongratulationView extends StatelessWidget {
  static final String route = "/CongratulationView";
  const CongratulationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        appBar: GlobalWidgets.bottomSheetAppBar(),
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
                  Image.asset(R.appImages.celebrateImg),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "congratulations".L(),
                    style: R.textStyles
                        .urbanist(fontSize: 21.sp, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "congratulations_disc".L(),
                      textAlign: TextAlign.center,
                      style: R.textStyles.urbanist(fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
              onPressed: () => Get.offAllNamed(LoginView.route),
              title: "login"),
        ],
      ),
    );
  }
}
