import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/login_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/app_validator.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../../utlits/safe_area_widget.dart';

class DeleteAccountView extends StatefulWidget {
  static final String route = "/DeleteAccountView";

  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passTC = TextEditingController();
  FocusNode passFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passFN.dispose();
    passTC.dispose();
  }

  bool showPass = false;

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
      height: 65.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: R.decoration.bottomSheetDecor(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text(
                      "delete_your_account".L(),
                      style: R.textStyles.urbanist(
                          fontSize: 21.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "delete_account_desc".L(),
                        textAlign: TextAlign.center,
                        style: R.textStyles.urbanist(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GlobalWidgets.labelText(labelText: "password".L()),
                    TextFormField(
                      controller: passTC,
                      focusNode: passFN,
                      textInputAction: TextInputAction.next,
                      obscuringCharacter: "*",
                      obscureText: !showPass,
                      style: R.textStyles.urbanist(fontSize: 16.sp),
                      decoration: R.decoration.inputDecorationWithHint(
                        hintText: "enter_password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              showPass = !showPass;
                              setState(() {});
                            },
                            icon: Icon(
                              showPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: R.appColors.middleGreyColor
                                  .withValues(alpha: 0.5),
                            )),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidator.validatePassword,
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
                    ZBotToast.showToastSuccess(
                        message: "delete_account".L(),
                        subTitle: "account_has_been_deleted_successfully".L());
                    Get.offAllNamed(LoginView.route);
                  }
                },
                title: "delete_account"),
          ],
        ),
      ),
    );
  }
}
