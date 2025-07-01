import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';

class SimpleSheet extends StatelessWidget {
  final VoidCallback onRightPressed;
  final String rightBtnTitle;
  final String? leftBtnTitle;
  final String imagePath;
  final String subTitle;
  final Color? iconColor;

  const SimpleSheet({
    super.key,
    required this.onRightPressed,
    this.leftBtnTitle,
    this.iconColor,
    required this.rightBtnTitle,
    required this.imagePath,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding:
          EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(bottom: 20),
      decoration: R.decoration.bottomSheetDecor(
        borderRadius: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalWidgets.bottomSheetBar(),
          SizedBox(
            height: 25,
          ),
          Image.asset(
            imagePath,
            color: iconColor ?? null,
            height: 15.w,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: R.textStyles
                .urbanist(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                onPressed: () => Get.back(),
                title: leftBtnTitle ?? "no",
                backgroundColor: R.appColors.white,
                borderColor: R.appColors.borderColor,
                textColor: R.appColors.middleGreyColor,
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                      onPressed: onRightPressed, title: rightBtnTitle)),
            ],
          )
        ],
      ),
    );
  }
}
