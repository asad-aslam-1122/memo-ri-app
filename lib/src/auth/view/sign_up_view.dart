import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/verification_view.dart';
import 'package:memo_ri_app/src/auth/view/terms_and_privacy_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/image_picker/image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utlits/global_widgets/global_widgets.dart';
import '../../../utlits/safe_area_widget.dart';

class SignUpView extends StatefulWidget {
  static final String route = "/SignUpView";

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController passTC = TextEditingController();
  TextEditingController confirmPassTC = TextEditingController();

  FocusNode nameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTC.dispose();
    nameFN.dispose();
    emailFN.dispose();
    emailTC.dispose();
    passFN.dispose();
    passTC.dispose();
    confirmPassFN.dispose();
    confirmPassTC.dispose();
  }

  File? profileImage;
  bool isValidate = false;

  bool isAgreed = false;

  final _formKey = GlobalKey<FormState>();

  bool showPass = false;
  bool showConfirmPass = false;

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        appBar: GlobalWidgets.bottomSheetAppBar(
          showBackArrowBtn: true,
        ),
        backgroundColor: R.appColors.primaryColor,
        bottomSheet: bottomSheetBody(),
        bottomNavigationBar: Container(
          color: R.appColors.white,
          padding: EdgeInsets.symmetric(horizontal: 12) +
              EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              agreeTermsWidget(),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        profileImage != null &&
                        isValidate) {
                      if (isAgreed) {
                        Get.offAndToNamed(VerificationView.route, arguments: {
                          "title": "verify_your_account",
                          "subTitle": "verify_disc",
                          "isFromSignUp": true,
                        });
                      } else {
                        ZBotToast.showToastError(
                            message: "select_terms_and_conditions".L(),
                            subTitle: "please_select_terms_and_conditions".L());
                      }
                    } else {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  },
                  title: "signup"),
              alreadyAccountWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12) + EdgeInsets.only(top: 20),
      decoration: R.decoration.bottomSheetDecor(),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "signup".L(),
                style: R.textStyles
                    .urbanist(fontSize: 23.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              ImageWidget(
                isProfile: true,
                isFile: true,
                enableGesture: true,
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
                        ? null
                        : R.appColors.red),
              ),
              SizedBox(
                height: 8,
              ),
              GlobalWidgets.labelText(labelText: "name".L()),
              TextFormField(
                controller: nameTC,
                focusNode: nameFN,
                textInputAction: TextInputAction.next,
                canRequestFocus: true,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(emailFN);
                },
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                style: R.textStyles.urbanist(fontSize: 16.sp),
                decoration: R.decoration
                    .inputDecorationWithHint(hintText: "enter_name"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: AppValidator.validateFullName,
              ),
              SizedBox(
                height: 8,
              ),
              GlobalWidgets.labelText(labelText: "email_address".L()),
              TextFormField(
                controller: emailTC,
                focusNode: emailFN,
                textInputAction: TextInputAction.next,
                canRequestFocus: true,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(passFN);
                },
                style: R.textStyles.urbanist(fontSize: 16.sp),
                decoration: R.decoration
                    .inputDecorationWithHint(hintText: "enter_email_address"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: AppValidator.validateEmail,
              ),
              SizedBox(
                height: 8,
              ),
              GlobalWidgets.labelText(labelText: "password".L()),
              TextFormField(
                controller: passTC,
                focusNode: passFN,
                textInputAction: TextInputAction.next,
                canRequestFocus: true,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(confirmPassFN);
                },
                style: R.textStyles.urbanist(fontSize: 16.sp),
                decoration: R.decoration.inputDecorationWithHint(
                    hintText: "enter_password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          showPass = !showPass;
                          setState(() {});
                        },
                        icon: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          color: R.appColors.middleGreyColor
                              .withValues(alpha: 0.5),
                        ))),
                obscureText: !showPass,
                obscuringCharacter: "*",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: AppValidator.validateNewPassword,
              ),
              SizedBox(
                height: 8,
              ),
              GlobalWidgets.labelText(labelText: "confirm_password".L()),
              TextFormField(
                controller: confirmPassTC,
                focusNode: confirmPassFN,
                textInputAction: TextInputAction.done,
                style: R.textStyles.urbanist(fontSize: 16.sp),
                obscuringCharacter: "*",
                obscureText: !showConfirmPass,
                decoration: R.decoration.inputDecorationWithHint(
                    hintText: "enter_confirm_password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          showConfirmPass = !showConfirmPass;
                          setState(() {});
                        },
                        icon: Icon(
                          showConfirmPass
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: R.appColors.middleGreyColor
                              .withValues(alpha: 0.5),
                        ))),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    AppValidator.validatePasswordMatch(value, passTC.text),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget alreadyAccountWidget() {
    return Container(
      color: R.appColors.white,
      padding: EdgeInsets.only(top: 12),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: R.textStyles.urbanist(
                  color: R.appColors.middleGreyColor, fontSize: 15.sp),
              children: [
                TextSpan(text: "${"already_have_an_account".L()}?\t\t"),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "login".L(),
                    style: R.textStyles.urbanist(
                        fontSize: 15.sp, fontWeight: FontWeight.w700)),
              ])),
    );
  }

  Widget agreeTermsWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            isAgreed = !isAgreed;
            setState(() {});
          },
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                color: isAgreed ? R.appColors.primaryColor : R.appColors.white,
                border: Border.all(color: R.appColors.middleGreyColor),
                shape: BoxShape.circle),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        RichText(
            text: TextSpan(
                style: R.textStyles.urbanist(
                    color: R.appColors.middleGreyColor, fontSize: 15.sp),
                children: [
              TextSpan(text: "${"i_agree_with".L()} "),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(TermsAndPrivacyView.route,
                        arguments: {"title": "terms_and_conditions"}),
                  text: "terms_and_conditions".L(),
                  style: R.textStyles
                      .urbanist(fontSize: 15.sp, fontWeight: FontWeight.w700)),
            ])),
      ],
    );
  }
}
