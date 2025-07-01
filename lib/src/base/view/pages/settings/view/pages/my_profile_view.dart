import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/image_picker/image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../../utlits/safe_area_widget.dart';

class MyProfileView extends StatefulWidget {
  static final String route = "/MyProfileView";

  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameTC = TextEditingController();
  FocusNode nameFN = FocusNode();

  File? profileImage;
  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        appBar: GlobalWidgets.bottomSheetAppBar(showBackArrowBtn: true),
        backgroundColor: R.appColors.primaryColor,
        bottomSheet: bottomSheetBody(),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: R.decoration.bottomSheetDecor(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "my_profile".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 21.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ImageWidget(
                      isProfile: true,
                      isFile: true,
                      showCameraIcon: true,
                      height: 80,
                      width: 80,
                      uploadImage: (value) {
                        if (value != null) {
                          profileImage = value;
                          isValidate = true;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (profileImage != null || isValidate == false)
                          ? "upload_profile_picture".L()
                          : "please_upload_profile_image".L(),
                      style: R.textStyles.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: (profileImage != null || isValidate == false)
                              ? R.appColors.white
                              : R.appColors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GlobalWidgets.labelText(labelText: "name".L()),
                    TextFormField(
                      controller: nameTC,
                      focusNode: nameFN,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles.urbanist(fontSize: 16.sp),
                      decoration: R.decoration
                          .inputDecorationWithHint(hintText: "enter_name"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidator.validateFullName,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ZBotToast.showToastSuccess(
                        message: "profile_updated".L(),
                        subTitle: "profile_has_been_updated_successfully".L());

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
    );
  }
}
