import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/events/model/event_model.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view_model/event_vm.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/custom_bottom.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';

class CreateEventView2 extends StatefulWidget {
  static final String route = "/CreateEventView2";
  const CreateEventView2({super.key});

  @override
  State<CreateEventView2> createState() => _CreateEventView2State();
}

class _CreateEventView2State extends State<CreateEventView2> {
  EventModel? eventModel;

  final _formKey = GlobalKey<FormState>();
  bool isValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventModel = Get.arguments["eventModel"];

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  String? eventImage;
  TextEditingController descTC = TextEditingController();
  FocusNode descFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descFN.dispose();
    descTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventVm>(builder: (context, eventVm, child) {
      return Scaffold(
        backgroundColor: R.appColors.lightGreyColor,
        appBar: GlobalWidgets.simpleAppBar(title: "create_event".L()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: 20, top: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GlobalWidgets.labelText(labelText: "description".L()),
                        TextFormField(
                          controller: descTC,
                          focusNode: descFN,
                          textInputAction: TextInputAction.done,
                          minLines: 4,
                          maxLines: 6,
                          style: R.textStyles.urbanist(fontSize: 16.sp),
                          decoration: R.decoration.inputDecorationWithHint(
                              hintText: "details_about_event"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: AppValidator.validateEmpty,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            uploadImageWidget(),
                            SizedBox(
                              width: 6,
                            ),
                            if (eventImage != null && eventImage != "")
                              userUploadedImage()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          (eventImage != null || eventImage != "") &&
                          isValidate) {
                        eventModel!.description = descTC.text;
                        eventModel!.image = eventImage!;

                        eventVm.eventModelList.add(eventModel!);
                        eventVm.update();
                        await ZBotToast.showToastSuccess(
                            message: "congratulations".L(),
                            subTitle: "your_event_has_been_created".L());
                        Get.back();
                      } else {
                        setState(() {
                          isValidate = true;
                        });
                      }
                    },
                    title: "create_event"),
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
        if (eventImage == null || eventImage == "") {
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
                color: ((eventImage != null || eventImage != "") ||
                        isValidate == false)
                    ? R.appColors.black
                    : R.appColors.red),
          )
        ],
      ),
    );
  }
}
