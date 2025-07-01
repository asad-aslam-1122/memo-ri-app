import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/events/model/event_model.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/app_validator.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/custom_bottom.dart';
import '../../view_model/event_vm.dart';

class EditEventView extends StatefulWidget {
  static final String route = "/EditEventView";
  const EditEventView({super.key});

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  TextEditingController titleTC = TextEditingController();
  TextEditingController dateTC = TextEditingController();
  TextEditingController timeTC = TextEditingController();
  TextEditingController descTC = TextEditingController();

  FocusNode titleFN = FocusNode();
  FocusNode dateFN = FocusNode();
  FocusNode timeFN = FocusNode();
  FocusNode descFN = FocusNode();
  final _formKey = GlobalKey<FormState>();

  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  String? eventImage;
  bool isValidate = false;

  EventModel? eventModel;

  DateTime? updatedDateTime;

  int? indexValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventModel = Get.arguments["eventModel"];
    indexValue = Get.arguments["indexValue"];

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (eventModel != null) {
          titleTC.text = eventModel?.subCateTitle ?? "";
          descTC.text = eventModel?.description ?? "";
          dateTC.text = DateFormat("dd-MM-yyyy")
              .format(eventModel?.scheduleEvent ?? DateTime.now());
          timeTC.text = DateFormat("hh:mm a")
              .format(eventModel?.scheduleEvent ?? DateTime.now());
          eventImage = eventModel?.image;

          if (eventImage != null) {
            isValidate = true;
          }
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTC.dispose();
    dateTC.dispose();
    timeTC.dispose();
    descTC.dispose();
    titleFN.dispose();
    dateFN.dispose();
    timeFN.dispose();
    descFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventVm>(builder: (context, eventVm, child) {
      return Scaffold(
        appBar: GlobalWidgets.simpleAppBar(title: "edit_event".L()),
        backgroundColor: R.appColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GlobalWidgets.labelText(labelText: "title".L()),
                      TextFormField(
                        controller: titleTC,
                        focusNode: titleFN,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(descFN);
                        },
                        textInputAction: TextInputAction.next,
                        canRequestFocus: true,
                        inputFormatters: [LengthLimitingTextInputFormatter(80)],
                        style: R.textStyles.urbanist(fontSize: 16.sp),
                        decoration: R.decoration
                            .inputDecorationWithHint(hintText: "enter_title"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: AppValidator.validateTitleName,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GlobalWidgets.labelText(labelText: "description".L()),
                      TextFormField(
                        controller: descTC,
                        focusNode: descFN,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(dateFN);
                        },
                        minLines: 4,
                        maxLines: 6,
                        style: R.textStyles.urbanist(fontSize: 16.sp),
                        decoration: R.decoration.inputDecorationWithHint(
                            hintText: "details_about_event"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: AppValidator.validateEmpty,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GlobalWidgets.labelText(labelText: "date".L()),
                      TextFormField(
                        onTap: () {
                          selectDate(
                              context: context,
                              initialDate:
                                  eventModel?.scheduleEvent ?? DateTime.now());
                          eventVm.update();
                        },
                        controller: dateTC,
                        focusNode: dateFN,
                        readOnly: true,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(timeFN);
                        },
                        textInputAction: TextInputAction.next,
                        canRequestFocus: true,
                        style: R.textStyles.urbanist(fontSize: 16.sp),
                        decoration: R.decoration
                            .inputDecorationWithHint(hintText: "select_date"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: AppValidator.validateEmpty,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GlobalWidgets.labelText(labelText: "time".L()),
                      TextFormField(
                        onTap: () {
                          selectTime();
                          eventVm.update();
                        },
                        controller: timeTC,
                        focusNode: timeFN,
                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        canRequestFocus: true,
                        style: R.textStyles.urbanist(fontSize: 16.sp),
                        decoration: R.decoration
                            .inputDecorationWithHint(hintText: "select_time"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: AppValidator.validateEmpty,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          uploadImageWidget(),
                          SizedBox(
                            width: 6,
                          ),
                          if (eventImage != null) userUploadedImage()
                        ],
                      )
                    ],
                  ),
                )),
                CustomButton(
                    onPressed: () {
                      print("eventImage = $eventImage");

                      if (_formKey.currentState!.validate() &&
                          (eventImage != null) &&
                          isValidate) {
                        EventModel editEventModel = EventModel(
                            mainCateTitle: eventModel!.mainCateTitle,
                            subCateTitle: titleTC.text,
                            isRecursive: eventModel!.isRecursive,
                            recursionPeriod: eventModel!.recursionPeriod,
                            scheduleEvent: updatedDateTime ?? DateTime.now(),
                            description: descTC.text,
                            image: eventImage!);

                        eventVm.eventModelList[indexValue ?? 0] =
                            editEventModel;
                        eventVm.update();

                        Get.back();
                      } else {
                        setState(() {
                          isValidate = true;
                        });
                      }
                    },
                    title: "update"),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget userUploadedImage() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              width: 65,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5) +
                  EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: R.appColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: R.appColors.borderColor),
                  image: DecorationImage(
                      image: FileImage(File(eventImage ?? "")),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            eventImage = null;
            setState(() {});
          },
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: R.appColors.borderColor),
            child: Center(
                child: Icon(
              Icons.close,
              size: 10,
            )),
          ),
        )
      ],
    );
  }

  Widget uploadImageWidget() {
    return GestureDetector(
      onTap: () async {
        if (eventImage == null) {
          ImagePicker imagePicker = ImagePicker();
          final pickedFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 85,
          );

          if (pickedFile != null) {
            eventImage = pickedFile.path;
            isValidate = true;
            setState(() {});
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: R.appColors.transparent,
              border: DashedBorder.fromBorderSide(
                dashLength: 3,
                spaceLength: 3,
                side: BorderSide(color: R.appColors.middleGreyColor, width: 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              R.appImages.uploadImg,
              scale: 4,
              color: R.appColors.middleGreyColor,
            ),
          ),
          Text(
            "upload_picture".L(),
            style: R.textStyles.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: (eventImage != null || isValidate == false)
                    ? R.appColors.black
                    : R.appColors.red),
          )
        ],
      ),
    );
  }

  void selectTime() async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      updatedDateTime = updateTime(
          dateTime: selectedDate ?? DateTime.now(),
          hour: selectedTime?.hour ?? 0,
          minute: selectedTime?.minute ?? 0);

      timeTC.text = timeFormatter();

      setState(() {});
    }
  }

  void selectDate(
      {required BuildContext context, required DateTime initialDate}) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2080),
      confirmText: "Set date",
      cancelText: "Cancel",
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: R.appColors.primaryColor,
            colorScheme: ColorScheme.light(
                primary: R.appColors.primaryColor,
                onPrimary: R.appColors.white,
                onSurface: R.appColors.black),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      updatedDateTime = updateTime(
          dateTime: selectedDate!,
          hour: selectedTime?.hour ?? 0,
          minute: selectedTime?.minute ?? 0);

      dateTC.text = dateFormatter();

      setState(() {});
    }
  }

  DateTime updateTime(
      {required DateTime dateTime, required int hour, required int minute}) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hour,
      minute,
      0,
    );
  }

  String dateFormatter() {
    return DateFormat("dd-MM-yyyy").format(updatedDateTime ?? DateTime.now());
  }

  String timeFormatter() {
    return DateFormat("hh:mm a").format(updatedDateTime ?? DateTime.now());
  }
}
