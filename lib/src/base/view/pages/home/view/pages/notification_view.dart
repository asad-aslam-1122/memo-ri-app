import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../../utlits/safe_area_widget.dart';
import '../../model/notification_model.dart';

class NotificationView extends StatefulWidget {
  static final String route = "/NotificationView";
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<NotificationModel> notificationModelList = [
    NotificationModel(
        title: "Upcoming Event Reminder",
        subTitle:
            "John's Birthday is tomorrow! Don’t forget to join the celebration.",
        imagePath: R.appImages.eventIcon,
        receiveTime: DateTime(2025),
        isNew: true),
    NotificationModel(
        title: "Storage Almost Full",
        subTitle: "Your storage is 90% full. Consider freeing up space.",
        imagePath: R.appImages.alertSignImg,
        receiveTime: DateTime.parse("2012-02-27 13:27:00,123456789z"),
        isNew: false),
    NotificationModel(
        title: "Storage Almost Full",
        subTitle:
            "Alia's Birthday is tomorrow! Don’t forget to join the celebration.",
        imagePath: R.appImages.eventIcon,
        receiveTime: DateTime.parse("2012-02-27 13:27:00,123456789z"),
        isNew: false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        appBar: GlobalWidgets.bottomSheetAppBar(
          height: 12.h,
          showBackArrowBtn: true,
        ),
        backgroundColor: R.appColors.primaryColor,
        body: bottomSheetBody(),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: R.decoration.bottomSheetDecor(),
      child: Column(
        children: [
          Text(
            "notifications".L(),
            style: R.textStyles
                .urbanist(fontSize: 23.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notificationModelList.length,
              itemBuilder: (context, index) {
                NotificationModel notificationModel =
                    notificationModelList[index];
                return notificationItem(notificationModel: notificationModel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationItem({
    required NotificationModel notificationModel,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: notificationModel.receiveTime == DateTime(2025)
              ? R.appColors.lightGreyColor.withValues(alpha: 0.7)
              : null),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  notificationModel.imagePath,
                  scale: 4,
                  color: R.appColors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            notificationModel.title,
                            style: R.textStyles.urbanist(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                          if (DateTime(2025) ==
                              notificationModel.receiveTime) ...[
                            SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              radius: 2.5,
                              backgroundColor: R.appColors.red,
                            )
                          ]
                        ],
                      ),
                      Text(
                        notificationModel.subTitle,
                        style: R.textStyles.urbanist(
                            fontSize: 15.sp,
                            color: R.appColors.middleGreyColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationModel.receiveTime == DateTime(2025)
                      ? "now"
                      : "2hr ago",
                  style: R.textStyles.urbanist(fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: R.appColors.middleGreyColor.withValues(alpha: .4),
          )
        ],
      ),
    );
  }
}
