import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/dropdown_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../model/event_model.dart';
import 'create_event_view2.dart';

class CreateEventView extends StatefulWidget {
  static final String route = "/CreateEventView";
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  String? selectedCate;
  String? selectedSubCate;
  String? selectedRecursion;
  String? selectedSubRecursionCate;
  DateTime? selectedDatTime;
  DateTime? tempDateTime;

  List<String> categoriesList = [
    "birthday",
    "anniversary",
    "baby_shower",
    "travel",
    "celebrations",
    "festivals",
  ];
  List<String> subCategoriesList = [
    "William’s Birthday",
    "Daniel’s Birthday",
    "Shaun’s Birthday",
    "John’s Birthday",
  ];

  String recursion = "recurring";

  List<String> recursionList = [
    "recurring",
    "non_recurring",
  ];
  List<String> recursionSubCateList = [
    "daily",
    "weekly",
    "monthly",
    "yearly",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.lightGreyColor,
      appBar: GlobalWidgets.simpleAppBar(title: "create_event".L()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            EdgeInsets.only(bottom: 20, top: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GlobalWidgets.labelText(labelText: "category".L()),
                    DropdownWidget(
                      hintText: "select_category",
                      list: categoriesList,
                      onChanged: (newValue) {
                        selectedCate = newValue;

                        setState(() {});
                      },
                      selectedValue: selectedCate,
                      validator: AppValidator.validateDropdown,
                    ),
                    SizedBox(height: 16),
                    if (selectedCate != null) ...[
                      DropdownWidget(
                        hintText: "select_sub_category",
                        list: subCategoriesList,
                        notLocalized: true,
                        onChanged: (newValue) {
                          selectedSubCate = newValue;

                          setState(() {});
                        },
                        selectedValue: selectedSubCate,
                        validator: AppValidator.validateDropdown,
                      ),
                      SizedBox(height: 8),
                    ],
                    if (selectedSubCate != null) ...[
                      GlobalWidgets.labelText(labelText: "event_reminder".L()),
                      DropdownWidget(
                        hintText: "non_recurring_event",
                        list: recursionList,
                        onChanged: (newValue) {
                          selectedRecursion = newValue;

                          setState(() {});
                        },
                        selectedValue: selectedRecursion,
                        validator: AppValidator.validateDropdown,
                      ),
                      SizedBox(height: 16),
                    ],
                    if (selectedRecursion != null &&
                        selectedRecursion == recursion) ...[
                      DropdownWidget(
                        hintText: "select_recursion_period",
                        list: recursionSubCateList,
                        onChanged: (newValue) {
                          selectedSubRecursionCate = newValue;
                          setState(() {});
                        },
                        selectedValue: selectedSubRecursionCate,
                        validator: AppValidator.validateDropdown,
                      ),
                      SizedBox(height: 16),
                    ],
                    if (selectedRecursion != null) ...{dateTimeContainer()}
                  ],
                ),
              ),
            ),
            CustomButton(
                onPressed: () {
                  print("selectedDatTime = $selectedDatTime");
                  if (selectedDatTime != null) {
                    EventModel eventModel = EventModel(
                        mainCateTitle: selectedCate ?? "",
                        subCateTitle: selectedSubCate ?? "",
                        isRecursive: selectedRecursion == recursion,
                        recursionPeriod: selectedSubRecursionCate ?? "",
                        scheduleEvent: selectedDatTime ?? DateTime.now(),
                        description: "",
                        image: "");
                    Get.offAndToNamed(CreateEventView2.route, arguments: {
                      "eventModel": eventModel,
                    });
                  }
                },
                title: "next"),
          ],
        ),
      ),
    );
  }

  Widget dateTimeContainer() {
    return GestureDetector(
      onTap: () => showDatePicker(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: R.appColors.white,
            border: Border.all(
              color: R.appColors.borderColor,
              width: 1,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDatTime != null
                  ? formattedDate(dateTime: selectedDatTime!)
                  : "select_date_time".L(),
              style: R.textStyles.urbanist(fontSize: 15.sp),
            ),
            Image.asset(
              R.appImages.calenderImg,
              color: R.appColors.middleGreyColor,
              scale: 4,
            )
          ],
        ),
      ),
    );
  }

  String formattedDate({required DateTime dateTime}) {
    return DateFormat("MMM dd, yyyy - hh:mm:a").format(dateTime);
  }

  void showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: R.decoration.bottomSheetDecor(
            borderRadius: 12, backGroundColor: R.appColors.white),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      "Cancel",
                      style: R.textStyles.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: R.appColors.hintColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedDatTime = tempDateTime;
                      setState(() {});
                      Get.back();
                    },
                    child: Text(
                      "Done",
                      style: R.textStyles.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: R.appColors.primaryColor),
                    ),
                  ),
                ],
              ),
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryContrastingColor: R.appColors.black,
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: R.textStyles.urbanist(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: R.appColors.hintColor,
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: selectedDatTime,
                    itemExtent: 30,
                    dateOrder: DatePickerDateOrder.dmy,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempDateTime = newDateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
