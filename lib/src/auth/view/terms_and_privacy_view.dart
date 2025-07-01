import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class TermsAndPrivacyView extends StatefulWidget {
  static final String route = "/TermsAndPrivacyView";

  const TermsAndPrivacyView({super.key});

  @override
  State<TermsAndPrivacyView> createState() => _TermsAndPrivacyViewState();
}

class _TermsAndPrivacyViewState extends State<TermsAndPrivacyView> {
  String? title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = Get.arguments["title"];

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
            height: 12.h,
            showBackArrowBtn: true,
            backArrowAlign: Alignment.centerLeft),
        backgroundColor: R.appColors.primaryColor,
        bottomSheet: bottomSheetBody(),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.only(top: 30),
      decoration: R.decoration.bottomSheetDecor(),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 12) + EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            if (title != null)
              Text(
                title!.L(),
                style: R.textStyles
                    .urbanist(fontSize: 21.sp, fontWeight: FontWeight.w600),
              ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est \n\n"
              "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est \n\n"
              "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est \n\n"
              "Lorem ipsum dolor sit ad minim amet, elit, sed consectetur proident, sunt in culpa qui officia deserunt mollit anim id est  adipiscsaing elit, sed do eiusmod. tempor sed to doincidid unt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamc oo laboris nisi ut aliquip exea commodo consequat. Duisau te irure dolor in reprehenderit in voluptate velit esse cillum dolore eu mollit anim id est \n\n",
              style: R.textStyles.urbanist(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
