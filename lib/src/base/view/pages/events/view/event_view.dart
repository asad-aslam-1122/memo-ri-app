import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/events/model/event_model.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view/pages/create_event_view.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view/pages/edit_event_view.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view_model/event_vm.dart';
import 'package:memo_ri_app/src/core/empty_view.dart';
import 'package:memo_ri_app/utlits/edit_delete_sheet.dart';
import 'package:memo_ri_app/utlits/event_description_sheet.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:memo_ri_app/utlits/simple_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventVm>(builder: (context, eventVm, child) {
      return Scaffold(
        backgroundColor: R.appColors.lightGreyColor,
        appBar: GlobalWidgets.simpleAppBar(title: "event_reminder".L()),
        body: eventVm.eventModelList.isEmpty
            ? EmptyView(
                title: "no_upcoming_event".L(),
                subTitle:
                    "add_pictures_to_make_your_occasions_unforgettable".L(),
                imagePath: R.appImages.eventIcon,
                buttonTitle: "create_event",
                onPressed: () => Get.toNamed(CreateEventView.route, arguments: {
                  "eventModel": null,
                }),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eventVm.eventModelList.any(
                      (event) => checkUpComingEvent(
                          eventDateTime: event.scheduleEvent),
                    )) ...[
                      Text(
                        "upcoming_events".L(),
                        style: R.textStyles.urbanist(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        itemCount: eventVm.eventModelList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          EventModel eventModel = eventVm.eventModelList[index];
                          if (checkUpComingEvent(
                              eventDateTime: eventModel.scheduleEvent)) {
                            return eventItem(
                                eventModel: eventModel,
                                index: index,
                                eventVm: eventVm);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                    Text(
                      "all_events".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      itemCount: eventVm.eventModelList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        EventModel eventModel = eventVm.eventModelList[index];
                        return eventItem(
                            eventModel: eventModel,
                            eventVm: eventVm,
                            index: index);
                      },
                    ),
                  ],
                ),
              ),
        floatingActionButton: eventVm.eventModelList.isNotEmpty
            ? FloatingActionButton(
                onPressed: () => Get.toNamed(CreateEventView.route, arguments: {
                  "eventModel": null,
                  "isEdit": false,
                }),
                mini: true,
                shape: CircleBorder(),
                backgroundColor: R.appColors.primaryColor,
                child: Icon(
                  Icons.add,
                  color: R.appColors.white,
                  size: 30,
                ),
              )
            : null,
      );
    });
  }

  bool checkUpComingEvent({required DateTime eventDateTime}) {
    DateTime now = DateTime.now();
    DateTime notifyTime = eventDateTime.subtract(Duration(hours: 24));
    if (now.isAfter(notifyTime) && now.isBefore(eventDateTime)) {
      return true;
    }
    return false;
  }

  Widget eventItem(
      {required EventModel eventModel,
      required EventVm eventVm,
      required int index}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: R.appColors.white, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () {
          Get.bottomSheet(EventDescriptionSheet(eventModel: eventModel));
        },
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 45,
          width: 45,
          margin: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: FileImage(File(eventModel.image)), fit: BoxFit.cover)),
        ),
        title: Text(
          eventModel.mainCateTitle.L(),
          style: R.textStyles
              .urbanist(fontWeight: FontWeight.w500, fontSize: 15.sp),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat("dd MMM yyyy").format(eventModel.scheduleEvent),
              style: R.textStyles
                  .urbanist(fontWeight: FontWeight.w500, fontSize: 15.sp),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              DateFormat("hh:mm a").format(eventModel.scheduleEvent),
              style: R.textStyles
                  .urbanist(fontWeight: FontWeight.w500, fontSize: 15.sp),
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => Get.bottomSheet(EditDeleteSheet(
                      onDeletePressed: () {
                        Get.back();
                        Get.bottomSheet(SimpleSheet(
                          onRightPressed: () {
                            eventVm.eventModelList.remove(eventModel);
                            eventVm.update();
                            Get.back();
                          },
                          iconColor: R.appColors.red,
                          imagePath: R.appImages.deleteIcon,
                          subTitle:
                              "are_you_sure_you_want_to_delete_this_event".L(),
                          rightBtnTitle: "delete",
                        ));
                      },
                      onEditPressed: () {
                        Get.back();
                        Get.toNamed(EditEventView.route, arguments: {
                          "eventModel": eventModel,
                          "indexValue": index,
                        });
                      },
                    )),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.more_vert,
                  size: 18,
                )),
          ],
        ),
      ),
    );
  }
}
