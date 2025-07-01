import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../../utlits/image_picker/image_widget.dart';
import 'onboard/view/onboard_view.dart';

class SplashView extends StatefulWidget {
  static final String route = "/SplashView";

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () => Get.offAllNamed(OnboardView.route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.lightGreyColor,
      body: Center(
        child: SizedBox(
          width: 80.w,
          child: ImageWidget(
            height: 22.w,
            width: 55.w,
            isFile: true,
            showCameraIcon: false,
            assetImagePath: R.appImages.appImg,
          ),
        ),
      ),
    );
  }
}
