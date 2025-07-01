import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/forget_password_view.dart';
import 'package:memo_ri_app/src/auth/view/sign_up_view.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view/subscription_view.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utlits/global_widgets/global_widgets.dart';
import '../../../utlits/safe_area_widget.dart';
import '../../../utlits/will_pop_widget.dart';

class LoginView extends StatefulWidget {
  static final String route = "/LoginView";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final List<String> authMethods = [
    R.appImages.faceIcon,
    R.appImages.fingerprintIcon
  ];

  TextEditingController emailTC = TextEditingController();
  TextEditingController passTC = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailTC.dispose();
    passTC.dispose();
    emailFN.dispose();
    passFN.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: PopScopeWidget.onPopInvokedWithResult,
      child: SafeAreaWidget(
        top: true,
        backgroundColor: R.appColors.primaryColor,
        child: Scaffold(
          appBar: GlobalWidgets.bottomSheetAppBar(),
          backgroundColor: R.appColors.primaryColor,
          body: bottomSheetBody(),
          bottomNavigationBar: createNewAccountWidget(),
        ),
      ),
    );
  }

  Widget createNewAccountWidget() {
    return GestureDetector(
      onTap: () => Get.toNamed(SignUpView.route),
      child: Container(
        color: R.appColors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          "create_new_account".L(),
          textAlign: TextAlign.center,
          style: R.textStyles.urbanist(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: R.appColors.primaryColor),
        ),
      ),
    );
  }

  Widget bottomSheetBody() {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.only(top: 20),
      decoration: R.decoration.bottomSheetDecor(),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 12) + EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "login".L(),
                style: R.textStyles
                    .urbanist(fontSize: 23.sp, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(
                  "login_good_to_see_you_again_enter_your_details_below_to_continue"
                      .L(),
                  textAlign: TextAlign.center,
                  style: R.textStyles.urbanist(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GlobalWidgets.labelText(labelText: "email_address".L()),
              TextFormField(
                controller: emailTC,
                focusNode: emailFN,
                canRequestFocus: true,
                textInputAction: TextInputAction.next,
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
                canRequestFocus: true,
                textInputAction: TextInputAction.done,
                style: R.textStyles.urbanist(fontSize: 16.sp),
                obscureText: !showPass,
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
                obscuringCharacter: "*",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: AppValidator.validateLoginPassword,
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(ForgetPasswordView.route);
                },
                child: GlobalWidgets.labelText(
                    labelText: "${"forgot_password".L()} ?",
                    alignment: Alignment.topRight),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed(SubscriptionView.route,
                          arguments: {"isFromSetting": false});
                    }
                  },
                  title: "login"),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  authMethods.length,
                  (index) => GestureDetector(
                      onTap: () => selectedAuthMethod(index: index),
                      child: authMethodsWidget(imagePath: authMethods[index])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget authMethodsWidget({required String imagePath}) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.15),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 1)
        ],
        shape: BoxShape.circle,
        color: R.appColors.white,
      ),
      child: Image.asset(imagePath),
    );
  }

  void selectedAuthMethod({required int index}) {
    switch (index) {
      case 0:
        {
          print("Face Detection Method");
          break;
        }
      case 1:
        {
          print("FingerPrint Method");
          break;
        }
      default:
        {
          print("Invalid Method");
          break;
        }
    }
  }
}
