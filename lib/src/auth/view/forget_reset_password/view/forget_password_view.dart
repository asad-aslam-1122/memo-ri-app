import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/verification_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../utlits/safe_area_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  static final String route = "/ForgetPasswordView";

  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTC = TextEditingController();

  FocusNode emailFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailTC.dispose();
    emailFN.dispose();
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
                      "forgot_password".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 21.sp, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: Text(
                        "forget_pass_disc".L(),
                        textAlign: TextAlign.center,
                        style: R.textStyles.urbanist(fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GlobalWidgets.labelText(labelText: "email_address".L()),
                    TextFormField(
                      controller: emailTC,
                      focusNode: emailFN,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles.urbanist(fontSize: 16.sp),
                      decoration: R.decoration.inputDecorationWithHint(
                          hintText: "enter_email_address"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidator.validateEmail,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(VerificationView.route, arguments: {
                      "title": "reset_your_password",
                      "subTitle": "reset_pass_disc",
                      "isFromSignUp": false,
                    });
                  }
                },
                title: "proceed"),
          ],
        ),
      ),
    );
  }
}
