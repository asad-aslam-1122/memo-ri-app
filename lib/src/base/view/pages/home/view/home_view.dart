import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view_model/event_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/albums_view.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/notification_view.dart';
import 'package:memo_ri_app/utlits/create_edit_cate_album.dart';
import 'package:memo_ri_app/utlits/edit_delete_sheet.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:memo_ri_app/utlits/simple_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../events/model/event_model.dart';
import '../model/category_model.dart';
import '../view_model/home_vm.dart';

class HomeView extends StatefulWidget {
  static final String route = "/HomeView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Consumer2<HomeVm, EventVm>(
        builder: (context, homeVm, eventVm, child) {
          return Scaffold(
            backgroundColor: R.appColors.lightGreyColor,
            appBar: AppBar(
              backgroundColor: R.appColors.primaryColor,
              surfaceTintColor: R.appColors.primaryColor,
              title: Text(
                "memo_ri".L(),
                style: R.textStyles
                    .zenDots(fontSize: 24.sp, color: R.appColors.white),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(NotificationView.route);
                    },
                    icon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: R.appColors.white,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  if (eventVm.eventModelList.any(
                    (event) =>
                        checkUpComingEvent(eventDateTime: event.scheduleEvent),
                  )) ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "upcoming_events".L(),
                        style: R.textStyles.urbanist(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      itemCount: eventVm.eventModelList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        EventModel eventModel = eventVm.eventModelList[index];
                        if (checkUpComingEvent(
                            eventDateTime: eventModel.scheduleEvent)) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: R.appColors.highLightColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: R.appColors.black
                                          .withValues(alpha: 0.2),
                                      spreadRadius: 0,
                                      blurRadius: 18)
                                ]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      margin: EdgeInsets.only(left: 12),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(eventModel.image)),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          eventModel.subCateTitle,
                                          style: R.textStyles.urbanist(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          "${DateFormat("dd MMM yyyy").format(eventModel.scheduleEvent)} ${DateFormat("hh:mm a").format(eventModel.scheduleEvent)}",
                                          style: R.textStyles.urbanist(
                                              fontSize: 14.sp,
                                              color: R.appColors.black
                                                  .withValues(alpha: .38)),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "memo_ri_hub".L(),
                        style: R.textStyles.urbanist(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          homeVm.recommendedCateList[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AlbumsView.route, arguments: {
                            "categoryModel": categoryModel,
                            "isRecommended": true,
                            "index": index,
                          });
                        },
                        child: GlobalWidgets.cateAndAlbumItems(
                          useAsset: true,
                          imagePath: categoryModel.cateImage,
                          title: categoryModel.cateTitle,
                        ),
                      );
                    },
                    itemCount: homeVm.recommendedCateList.length,
                    shrinkWrap: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (homeVm.userCateModelList.isNotEmpty) ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "my_categories".L(),
                          style: R.textStyles.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 0,
                          mainAxisExtent: 120),
                      itemBuilder: (context, index) {
                        CategoryModel categoryModel =
                            homeVm.userCateModelList[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AlbumsView.route, arguments: {
                              "categoryModel": categoryModel,
                              "isRecommended": false,
                              "index": index,
                            });
                          },
                          onLongPress: () => Get.bottomSheet(
                              EditDeleteSheet(onDeletePressed: () {
                            Get.back();
                            Get.bottomSheet(SimpleSheet(
                                onRightPressed: () {
                                  Get.back();

                                  homeVm.userCateModelList
                                      .remove(categoryModel);
                                  homeVm.update();
                                },
                                leftBtnTitle: "cancel",
                                rightBtnTitle: "delete",
                                imagePath: R.appImages.deleteIcon,
                                iconColor: R.appColors.red,
                                subTitle:
                                    "${"are_you_sure_you_want_to_delete".L()} category?"));
                          }, onEditPressed: () {
                            Get.back();
                            Get.bottomSheet(CreateEditCateAlbum(
                                title: "edit_category",
                                hintText: "category_name",
                                cateIndex: index,
                                isEdit: true,
                                isFromAlbum: false));
                          })),
                          child: GlobalWidgets.cateAndAlbumItems(
                            useAsset: false,
                            imagePath: categoryModel.cateImage,
                            title: categoryModel.cateTitle,
                          ),
                        );
                      },
                      itemCount: homeVm.userCateModelList.length,
                      shrinkWrap: true,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.bottomSheet(CreateEditCateAlbum(
                title: "create_category",
                hintText: "category_name",
                isFromAlbum: false,
                isRecommended: false,
                isEdit: false,
              )),
              mini: true,
              shape: CircleBorder(),
              backgroundColor: R.appColors.primaryColor,
              child: Icon(
                Icons.add,
                color: R.appColors.white,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  bool checkUpComingEvent({required DateTime eventDateTime}) {
    DateTime now = DateTime.now();
    DateTime notifyTime = eventDateTime.subtract(Duration(hours: 24));
    if (now.isAfter(notifyTime) && now.isBefore(eventDateTime)) {
      return true;
    }
    return false;
  }
}
