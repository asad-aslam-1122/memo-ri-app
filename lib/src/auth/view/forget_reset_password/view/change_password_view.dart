import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/congratulation_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../utlits/safe_area_widget.dart';

class ChangePasswordView extends StatefulWidget {
  static final String route = "/ChangePasswordView";

  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPassTC = TextEditingController();
  TextEditingController newPassTC = TextEditingController();
  TextEditingController confirmPassTC = TextEditingController();

  FocusNode oldPassFN = FocusNode();
  FocusNode newPassFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();

  bool showOldPass = false;
  bool showNewPass = false;
  bool showConfirmPass = false;

  bool? isFromSetting;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFromSetting = Get.arguments["isFromSetting"];
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPassTC.dispose();
    newPassTC.dispose();
    confirmPassTC.dispose();
    oldPassFN.dispose();
    confirmPassFN.dispose();
    newPassFN.dispose();
  }

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
                      "change_your_password".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 21.sp, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      child: Text(
                        "change_pass_disc".L(),
                        textAlign: TextAlign.center,
                        style: R.textStyles.urbanist(fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (isFromSetting ?? false) ...[
                      GlobalWidgets.labelText(labelText: "old_password".L()),
                      TextFormField(
                        controller: oldPassTC,
                        focusNode: oldPassFN,
                        textInputAction: TextInputAction.next,
                        canRequestFocus: true,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(newPassFN);
                        },
                        style: R.textStyles.urbanist(fontSize: 16.sp),
                        decoration: R.decoration.inputDecorationWithHint(
                            hintText: "enter_old_password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  showOldPass = !showOldPass;
                                  setState(() {});
                                },
                                icon: Icon(
                                  showOldPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: R.appColors.middleGreyColor
                                      .withValues(alpha: 0.5),
                                ))),
                        obscureText: !showOldPass,
                        obscuringCharacter: "*",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: AppValidator.validateLoginPassword,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                    GlobalWidgets.labelText(labelText: "new_password".L()),
                    TextFormField(
                      controller: newPassTC,
                      focusNode: newPassFN,
                      canRequestFocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(confirmPassFN);
                      },
                      style: R.textStyles.urbanist(fontSize: 16.sp),
                      decoration: R.decoration.inputDecorationWithHint(
                          hintText: "enter_new_password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                showNewPass = !showNewPass;
                                setState(() {});
                              },
                              icon: Icon(
                                showNewPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: R.appColors.middleGreyColor
                                    .withValues(alpha: 0.5),
                              ))),
                      obscureText: !showNewPass,
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
                      canRequestFocus: true,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles.urbanist(fontSize: 16.sp),
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
                      obscuringCharacter: "*",
                      obscureText: !showConfirmPass,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => AppValidator.validatePasswordMatch(
                          value, newPassTC.text),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isFromSetting ?? false) {
                      ZBotToast.showToastSuccess(
                          message: "password_updated".L(),
                          subTitle:
                              "password_has_been_updated_successfully".L());
                      Get.back();
                    } else {
                      Get.offAllNamed(CongratulationView.route);
                    }
                  }
                },
                title: "proceed"),
          ],
        ),
      ),
    );
  }
}
