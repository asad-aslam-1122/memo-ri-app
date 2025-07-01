import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../utlits/global_widgets/global_widgets.dart';

class PhotosView extends StatefulWidget {
  static final String route = "/PhotosView";
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  String? imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePath = Get.arguments["imagePath"];

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.black,
      appBar: GlobalWidgets.simpleAppBar(title: "photos".L()),
      body: Center(
        child: Hero(
            tag: imagePath ?? "",
            child: Image.file(
              File(imagePath ?? ""),
              fit: BoxFit.fill,
              width: 100.w,
            )),
      ),
    );
  }
}
