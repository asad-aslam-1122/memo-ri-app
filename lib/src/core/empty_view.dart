import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../../utlits/custom_bottom.dart';

class EmptyView extends StatelessWidget {
  final String title, subTitle, imagePath, buttonTitle;
  final VoidCallback onPressed;
  final bool? hideButton;

  const EmptyView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.buttonTitle,
    required this.onPressed,
    this.hideButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: R.appColors.primaryColor,
            fit: BoxFit.cover,
            height: 22.w,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: R.textStyles.urbanist(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subTitle,
            style: R.textStyles
                .urbanist(fontSize: 15.sp, color: R.appColors.hintColor),
          ),
          SizedBox(
            height: 60,
          ),
          CustomButton(onPressed: onPressed, width: 90.w, title: buttonTitle),
        ],
      ),
    );
  }
}
