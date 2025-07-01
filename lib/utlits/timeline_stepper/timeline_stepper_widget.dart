import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../resources/resources.dart';

class TimelineStepperWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String leadingImage;
  final Widget widget;

  const TimelineStepperWidget(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.leadingImage,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13.h,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
            height: 40,
            width: 40,
            indicator: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: R.appColors.primaryColor),
              child: Image.asset(
                leadingImage,
                scale: 4,
              ),
            )),
        beforeLineStyle: LineStyle(
            color: R.appColors.primaryColor.withValues(alpha: 0.33),
            thickness: 12),
        endChild: widget,
      ),
    );
  }
}
