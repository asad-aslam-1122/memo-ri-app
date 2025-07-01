import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import 'image_picker_option.dart';

class ImageWidget extends StatefulWidget {
  final String? url;
  final String? assetImagePath;
  final bool? isFile;
  final ValueChanged<File?>? uploadImage;
  final double height;
  final double width;
  final bool isProfile;
  final bool showCameraIcon;
  final bool? enableGesture;
  final double? borderRadius;

  const ImageWidget({
    super.key,
    this.url,
    this.isFile,
    this.assetImagePath,
    this.borderRadius,
    this.showCameraIcon = false,
    this.uploadImage,
    this.isProfile = false,
    required this.height,
    required this.width,
    this.enableGesture,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? pickedFile;
  @override
  Widget build(BuildContext context) {
    return widget.isFile == true
        ? GestureDetector(
            onTap: () {
              if (widget.enableGesture ?? false)
                Get.bottomSheet(
                  ImagePickerOption(
                    uploadImage: (value) {
                      if (value != null) {
                        pickedFile = value;
                        widget.uploadImage!(pickedFile!);
                        setState(() {});
                      }
                    },
                    isOptionEnable: false,
                  ),
                  isScrollControlled: true,
                );
            },
            child: pickedFile != null
                ? Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius: widget.isProfile
                          ? null
                          : BorderRadius.circular(widget.borderRadius ?? 8),
                      shape: widget.isProfile
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: widget.isProfile
                          ? R.appColors.white
                          : R.appColors.transparent,
                      border: widget.isProfile
                          ? Border.all(color: R.appColors.borderColor, width: 2)
                          : Border.fromBorderSide(BorderSide.none),
                      image: DecorationImage(
                        image: FileImage(pickedFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: widget.showCameraIcon
                        ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 3,
                                left: 0,
                                right: 0,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: R.appColors.white,
                                  size: 17,
                                ),
                              )
                            ],
                          )
                        : null,
                  )
                : Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius: widget.isProfile
                          ? null
                          : BorderRadius.circular(widget.borderRadius ?? 8),
                      shape: widget.isProfile
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: widget.isProfile
                          ? R.appColors.white
                          : R.appColors.transparent,
                      border: widget.isProfile
                          ? Border.all(color: R.appColors.borderColor, width: 2)
                          : Border.fromBorderSide(BorderSide.none),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: widget.assetImagePath != null
                        ? Image.asset(
                            widget.assetImagePath!,
                            fit: BoxFit.fitWidth,
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                R.appImages.userProfileIcon,
                                fit: BoxFit.cover,
                                scale: 4,
                              ),
                              if (widget.showCameraIcon)
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 22,
                                    width: widget.width,
                                    color: R.appColors.hintColor,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: R.appColors.white,
                                      size: 17,
                                    ),
                                  ),
                                ),
                            ],
                          )))
        : GestureDetector(
            onTap: () {
              if (widget.enableGesture ?? false)
                Get.bottomSheet(
                  ImagePickerOption(
                    uploadImage: (value) {
                      if (value != null) {
                        pickedFile = value;
                        widget.uploadImage!(pickedFile!);
                        setState(() {});
                      }
                    },
                    isOptionEnable: false,
                  ),
                  isScrollControlled: true,
                );
            },
            child: CachedNetworkImage(
              imageUrl: widget.url ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: widget.height,
                width: widget.width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: R.appColors.white,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  shape:
                      widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: widget.isProfile
                      ? null
                      : BorderRadius.circular(widget.borderRadius ?? 8),
                  border: widget.isProfile
                      ? Border.all(width: 2, color: R.appColors.borderColor)
                      : Border.fromBorderSide(BorderSide.none),
                ),
                child: widget.showCameraIcon
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.camera_alt,
                            size: 17,
                            color: R.appColors.white,
                          ),
                        ),
                      )
                    : null,
              ),
              placeholder: (context, url) => Container(
                height: widget.height,
                width: widget.width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape:
                      widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: widget.isProfile
                      ? null
                      : BorderRadius.circular(widget.borderRadius ?? 8),
                  border: Border.all(
                      width: 2,
                      color: widget.isProfile
                          ? R.appColors.borderColor
                          : R.appColors.transparent),
                ),
                child: SpinKitPulse(color: R.appColors.middleGreyColor),
              ),
              errorWidget: (context, url, error) => Container(
                clipBehavior: Clip.hardEdge,
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  shape:
                      widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: widget.isProfile
                      ? null
                      : BorderRadius.circular(widget.borderRadius ?? 8),
                  border: Border.all(
                      width: 2,
                      color: widget.isProfile
                          ? R.appColors.borderColor
                          : R.appColors.transparent),
                ),
                child: widget.showCameraIcon
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Image.asset(
                                R.appImages.userProfileIcon,
                                scale: 4,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 22,
                              width: widget.width,
                              color: R.appColors.hintColor,
                              child: Icon(
                                Icons.camera_alt,
                                color: R.appColors.white,
                                size: 17,
                              ),
                            ),
                          )
                        ],
                      )
                    : null,
              ),
            ),
          );
  }
}
