import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/events/model/event_model.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';

class EventDescriptionSheet extends StatelessWidget {
  final EventModel eventModel;

  const EventDescriptionSheet({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: R.decoration.bottomSheetDecor(),
      child: Column(
        children: [
          GlobalWidgets.bottomSheetBar(),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.close,
                  color: R.appColors.black,
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: R.appColors.highLightColor,
                      boxShadow: [
                        BoxShadow(
                            color: R.appColors.lightGreyColor,
                            spreadRadius: 0,
                            blurRadius: 6)
                      ],
                      image: DecorationImage(
                          image: FileImage(
                              File(
                                eventModel.image,
                              ),
                              scale: 4),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  eventModel.mainCateTitle,
                  style: R.textStyles
                      .urbanist(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "date".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 17.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      DateFormat("dd MMM yyyy")
                          .format(eventModel.scheduleEvent),
                      style: R.textStyles.urbanist(
                          fontSize: 16.sp, color: R.appColors.imageShadowColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "time".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 17.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      DateFormat("hh:mm a").format(eventModel.scheduleEvent),
                      style: R.textStyles.urbanist(
                        color: R.appColors.imageShadowColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "description_".L(),
                    style: R.textStyles
                        .urbanist(fontSize: 17.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    eventModel.description,
                    style: R.textStyles.urbanist(
                        fontSize: 16.sp, color: R.appColors.imageShadowColor),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
