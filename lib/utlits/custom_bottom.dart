import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class CustomButton extends StatefulWidget {
  VoidCallback onPressed;
  String title;
  double? textSize;
  FontWeight? textWeight;
  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;
  double? radius;
  double? height;
  double? width;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.textSize,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.radius,
      this.height,
      this.width,
      this.textWeight});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 50,
      width: widget.width ?? 100.w,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
              (Set<WidgetState> states) {
                return RoundedRectangleBorder(
                    side: widget.borderColor != null
                        ? BorderSide(color: widget.borderColor!)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 10));
              },
            ),
            backgroundColor: WidgetStatePropertyAll(
                widget.backgroundColor ?? R.appColors.primaryColor),
          ),
          child: Text(
            widget.title.L(),
            style: R.textStyles.urbanist(
                fontWeight: widget.textWeight ?? FontWeight.w500,
                fontSize: widget.textSize ?? 17.sp,
                color: widget.textColor ?? R.appColors.white),
          )),
    );
  }
}
