import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view/subscription_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_validator.dart';
import '../../../../../resources/resources.dart';
import '../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../utlits/safe_area_widget.dart';
import 'change_password_view.dart';

class VerificationView extends StatefulWidget {
  static final String route = "/VerificationView";

  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  int timeout = 59;

  String? title, subTitle;
  bool? isFromSignUp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = Get.arguments["title"];
    subTitle = Get.arguments["subTitle"];
    isFromSignUp = Get.arguments["isFromSignUp"];
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (timeout != 0) {
          timeout = timeout - 1;
        } else {
          _timer?.cancel();
        }

        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            setState(() {});
          },
        );
      },
    );
  }

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController otpTC = TextEditingController();
  FocusNode otpFN = FocusNode();

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
                    if (title != null)
                      Text(
                        title!.L(),
                        style: R.textStyles.urbanist(
                            fontSize: 21.sp, fontWeight: FontWeight.w600),
                      ),
                    if (subTitle != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 8),
                        child: Text(
                          subTitle!.L(),
                          textAlign: TextAlign.center,
                          style: R.textStyles.urbanist(fontSize: 15.sp),
                        ),
                      ),
                    SizedBox(
                      height: 25,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      controller: otpTC,
                      focusNode: otpFN,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidator.validateOTP,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      length: 6,
                      animationType: AnimationType.fade,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(6),
                        fieldHeight: 45,
                        fieldWidth: 45,
                        borderWidth: 1,
                        activeFillColor: R.appColors.white,
                        inactiveFillColor: R.appColors.white,
                        activeBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        selectedFillColor: R.appColors.white,
                        activeColor: R.appColors.primaryColor,
                        inactiveColor: R.appColors.borderColor,
                        selectedColor: R.appColors.primaryColor,
                        errorBorderColor: R.appColors.red,
                      ),
                      textStyle: R.textStyles.urbanist(
                          fontSize: 18.sp,
                          color: R.appColors.black,
                          fontWeight: FontWeight.w500),
                      onCompleted: (value) {},
                      onTap: () {
                        setState(() {});
                      },
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 22.w,
                          child: Text(
                            formatTimer(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: R.textStyles.urbanist(fontSize: 16.sp),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (timeout == 0) {
                              timeout = 59;
                              startTimer();
                            }
                          },
                          child: Text(
                            "resend_code".L(),
                            textAlign: TextAlign.start,
                            style: R.textStyles.urbanist(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: timeout != 0
                                    ? R.appColors.hintColor
                                    : null),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    navigationMethod();
                  }
                },
                title: "proceed"),
          ],
        ),
      ),
    );
  }

  void navigationMethod() async {
    if (isFromSignUp ?? false) {
      await ZBotToast.showToastSuccess(
          message: "congratulations".L(),
          subTitle: "signed_up_successfully".L());
      Get.offAndToNamed(SubscriptionView.route,
          arguments: {"isFromSetting": false});
    } else {
      Get.toNamed(ChangePasswordView.route,
          arguments: {"isFromSetting": false});
    }
  }

  String formatTimer() {
    if (timeout > 9) {
      return "00:$timeout sec";
    } else {
      return "00:0$timeout sec";
    }
  }
}
