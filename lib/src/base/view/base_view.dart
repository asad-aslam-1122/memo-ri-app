import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/home_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/memory_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/settings_view.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utlits/will_pop_widget.dart';
import '../model/base_model.dart';
import 'pages/events/view/event_view.dart';

class BaseView extends StatefulWidget {
  static final String route = "/BaseView";
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int currentIndex = 0;

  List<Widget> pagesList = [
    HomeView(),
    EventView(),
    MemoryView(),
    SettingsView()
  ];

  List<BaseModel> baseModelList = [
    BaseModel(title: "home", iconPath: R.appImages.homeIcon),
    BaseModel(title: "events", iconPath: R.appImages.eventIcon),
    BaseModel(title: "memory", iconPath: R.appImages.memoryIcon),
    BaseModel(title: "settings", iconPath: R.appImages.settingIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: PopScopeWidget.onPopInvokedWithResult,
        child: SafeAreaWidget(
            top: true,
            backgroundColor: R.appColors.primaryColor,
            child: Scaffold(
                backgroundColor: R.appColors.lightGreyColor,
                body: pagesList[currentIndex],
                bottomNavigationBar: Container(
                  height: 62,
                  decoration: BoxDecoration(
                      color: R.appColors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 10,
                            color: R.appColors.black.withValues(alpha: .1)),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        baseModelList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            currentIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            color: R.appColors.white,
                            width: 18.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    baseModelList[index].iconPath,
                                    height: 19,
                                    width: 19,
                                    color: currentIndex == index
                                        ? R.appColors.primaryColor
                                        : R.appColors.middleGreyColor,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    baseModelList[index].title.L(),
                                    style: R.textStyles.poppins(
                                      fontSize: 10,
                                      fontWeight: currentIndex == index
                                          ? FontWeight.w500
                                          : null,
                                      dontGiveTextHeight: true,
                                      color: currentIndex == index
                                          ? R.appColors.primaryColor
                                          : R.appColors.middleGreyColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ))));
  }
}
