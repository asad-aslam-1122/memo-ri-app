import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import 'image_picker_services.dart';

class ImagePickerOption extends StatefulWidget {
  final ValueChanged<File?>? uploadImage;
  final bool? isOptionEnable;
  const ImagePickerOption({
    this.uploadImage,
    super.key,
    this.isOptionEnable = false,
  });

  @override
  ImagePickerOptionState createState() => ImagePickerOptionState();
}

class ImagePickerOptionState extends State<ImagePickerOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: R.appColors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                // margin: EdgeInsets.only(
                //     bottom: Get.height * .05,
                //     left: Get.width * .08,
                //     right: Get.width * .08),
                padding: EdgeInsets.only(
                    bottom: Get.height * .02,
                    top: Get.height * .02,
                    left: Get.width * .08,
                    right: Get.width * .08),
                width: Get.width,
                decoration: BoxDecoration(
                    color: R.appColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Media",
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: R.appColors.black)),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              ImagePickerServices.getProfileImage(
                                      isSizeOptional: widget.isOptionEnable,
                                      isCamera: false,
                                      context: context)
                                  .then((value) async {
                                if (ImagePickerServices.profileImage != null) {
                                  bool check =
                                      await ImagePickerServices.checkFileSize(
                                          ImagePickerServices
                                              .profileImage!.path);

                                  if (check) {
                                    widget.uploadImage!(
                                        ImagePickerServices.profileImage);
                                    ImagePickerServices.profileImage = null;
                                  }
                                }
                              });

                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: R.appColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      R.appImages.galleryIcon,
                                      color: Colors.white,
                                      scale: 4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Gallery",
                                    style: R.textStyles.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp,
                                        color: R.appColors.black)),
                              ],
                            )),
                        SizedBox(
                          width: 60,
                        ),
                        GestureDetector(
                          onTap: () {
                            ImagePickerServices.getProfileImage(
                                    isSizeOptional: widget.isOptionEnable,
                                    isCamera: true,
                                    context: context)
                                .then((value) async {
                              if (ImagePickerServices.profileImage != null) {
                                bool check =
                                    await ImagePickerServices.checkFileSize(
                                        ImagePickerServices.profileImage!.path);
                                if (check) {
                                  widget.uploadImage!(
                                      ImagePickerServices.profileImage);
                                  ImagePickerServices.profileImage = null;
                                }
                              }
                            });

                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: R.appColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    R.appImages.cameraIcon,
                                    color: Colors.white,
                                    scale: 4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Camera",
                                  style: R.textStyles.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                      color: R.appColors.black)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
