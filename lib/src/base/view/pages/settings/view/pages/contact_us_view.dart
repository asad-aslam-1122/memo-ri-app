import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../../utlits/safe_area_widget.dart';

class ContactUsView extends StatefulWidget {
  static final String route = "/ContactUsView";

  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _formKey = GlobalKey<FormState>();

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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "contact_us".L(),
                style: R.textStyles
                    .urbanist(fontSize: 21.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "contact_us_disc".L(),
                style: R.textStyles
                    .urbanist(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              SizedBox(
                height: 8,
              ),
              CustomButton(
                  onPressed: () {
                    openGmail();
                  },
                  backgroundColor: R.appColors.white,
                  borderColor: R.appColors.borderColor,
                  textColor: R.appColors.primaryColor,
                  textSize: 18.sp,
                  textWeight: FontWeight.w600,
                  title: "contact_email"),
            ],
          ),
        ),
      ),
    );
  }

  void openGmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@memori.com',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
