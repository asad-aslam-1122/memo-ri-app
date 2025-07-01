import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/app_validator.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/model/category_model.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view_model/home_vm.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';
import 'custom_bottom.dart';
import 'global_widgets/global_widgets.dart';

class CreateEditCateAlbum extends StatefulWidget {
  final String title;
  final String hintText;
  final int? cateIndex;
  final bool isFromAlbum;
  final bool? isRecommended;
  final int? albumIndex;
  final bool isEdit;

  const CreateEditCateAlbum({
    super.key,
    required this.title,
    required this.hintText,
    required this.isFromAlbum,
    required this.isEdit,
    this.cateIndex,
    this.albumIndex,
    this.isRecommended,
  });

  @override
  State<CreateEditCateAlbum> createState() => _CreateEditCateAlbumState();
}

class _CreateEditCateAlbumState extends State<CreateEditCateAlbum> {
  String eventImage = "";
  CategoryModel? categoryModel;
  TextEditingController nameTC = TextEditingController();
  FocusNode nameFN = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool validateImg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final HomeVm homeVm = context.read<HomeVm>();

    if (widget.isEdit) {
      if (widget.isFromAlbum) {
        if (widget.isRecommended ?? false) {
          nameTC.text = homeVm.recommendedCateList[widget.cateIndex ?? 0]
                  .albumList?[widget.albumIndex ?? 0].title ??
              "";
          eventImage = homeVm.recommendedCateList[widget.cateIndex ?? 0]
                  .albumList?[widget.albumIndex ?? 0].albumImage ??
              "";
        } else {
          nameTC.text = homeVm.userCateModelList[widget.cateIndex ?? 0]
                  .albumList?[widget.albumIndex ?? 0].title ??
              "";
          eventImage = homeVm.userCateModelList[widget.cateIndex ?? 0]
                  .albumList?[widget.albumIndex ?? 0].albumImage ??
              "";
        }
      } else {
        nameTC.text = homeVm.userCateModelList[widget.cateIndex ?? 0].cateTitle;
        eventImage = homeVm.userCateModelList[widget.cateIndex ?? 0].cateImage;
      }
    }

    // if (homeVm.userCateModelList.isNotEmpty) {
    //   if (widget.isFromAlbum &&
    //       homeVm.userCateModelList[widget.cateIndex ?? 0].albumList != null) {
    //     nameTC.text = homeVm.userCateModelList[widget.cateIndex ?? 0]
    //         .albumList![widget.albumIndex ?? 0].title;
    //     eventImage = homeVm.userCateModelList[widget.cateIndex ?? 0]
    //             .albumList?[widget.albumIndex ?? 0].albumImage ??
    //         "";
    //   } else if (!widget.isFromAlbum) {
    //     nameTC.text = homeVm.userCateModelList[widget.cateIndex ?? 0].cateTitle;
    //     eventImage = homeVm.userCateModelList[widget.cateIndex ?? 0].cateImage;
    //   }
    // }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, homeVm, child) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 2,
        ),
        decoration: R.decoration.bottomSheetDecor(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GlobalWidgets.bottomSheetBar(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title.L(),
                  style: R.textStyles
                      .urbanist(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        uploadImageWidget(),
                        SizedBox(
                          width: 6,
                        ),
                        if (eventImage != "") userUploadedImage()
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameTC,
                      focusNode: nameFN,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles.urbanist(fontSize: 16.sp),
                      decoration: R.decoration
                          .inputDecorationWithHint(hintText: widget.hintText),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      validator: widget.isFromAlbum
                          ? AppValidator.validateAlbumName
                          : AppValidator.validateCateName,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                          onPressed: () => Get.back(),
                          title: "cancel",
                          backgroundColor: R.appColors.white,
                          borderColor: R.appColors.borderColor,
                          textColor: R.appColors.middleGreyColor,
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: CustomButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      eventImage != "" &&
                                      validateImg) {
                                    if (widget.isFromAlbum) {
                                      if (widget.isRecommended ?? false) {
                                        addEditAlbum(
                                            categoryModelList:
                                                homeVm.recommendedCateList);
                                      } else {
                                        addEditAlbum(
                                            categoryModelList:
                                                homeVm.userCateModelList);
                                      }
                                      ZBotToast.showToastSuccess(
                                          message: widget.isEdit
                                              ? "album_updated".L()
                                              : "album_created".L(),
                                          subTitle: widget.isEdit
                                              ? "album_has_been_updated_successfully"
                                                  .L()
                                              : "album_has_been_created_successfully"
                                                  .L());
                                    } else {
                                      addEditCateFunc(
                                          cateModelList:
                                              homeVm.userCateModelList);
                                    }

                                    homeVm.update();

                                    Get.back();
                                  } else {
                                    validateImg = true;
                                    setState(() {});
                                  }
                                },
                                title: "confirm")),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget userUploadedImage() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              width: 65,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5) +
                  EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: R.appColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: R.appColors.borderColor),
                  image: DecorationImage(
                      image: FileImage(File(eventImage)), fit: BoxFit.cover)),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            eventImage = "";
            setState(() {});
          },
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: R.appColors.borderColor),
            child: Center(
                child: Icon(
              Icons.close,
              size: 10,
            )),
          ),
        )
      ],
    );
  }

  Widget uploadImageWidget() {
    return GestureDetector(
      onTap: () async {
        if (eventImage == "") {
          ImagePicker imagePicker = ImagePicker();
          final pickedFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 85,
          );

          if (pickedFile != null) {
            validateImg = true;
            eventImage = pickedFile.path;
            setState(() {});
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: R.appColors.white,
              border: DashedBorder.fromBorderSide(
                dashLength: 3,
                spaceLength: 3,
                side: BorderSide(color: R.appColors.middleGreyColor, width: 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              R.appImages.uploadImg,
              scale: 4,
              color: R.appColors.middleGreyColor,
            ),
          ),
          Text(
            "upload_picture".L(),
            style: R.textStyles.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: (eventImage != "" || validateImg == false)
                    ? null
                    : R.appColors.red),
          )
        ],
      ),
    );
  }

  void createAndEditAlbum(
      {required List<CategoryModel> categoryModelList, required bool isEdit}) {
    AlbumModel albumModel = AlbumModel(
        title: nameTC.text,
        albumImage: eventImage,
        imagesList:
            categoryModel?.albumList?[widget.albumIndex ?? 0].imagesList ?? [],
        videoControllers: categoryModel
                ?.albumList?[widget.albumIndex ?? 0].videoControllers ??
            []);

    if (isEdit) {
      categoryModelList[widget.cateIndex ?? 0]
          .albumList![widget.albumIndex ?? 0] = albumModel;
    } else {
      categoryModelList[widget.cateIndex ?? 0].albumList!.add(albumModel);

      ZBotToast.showToastSuccess(
          message: isEdit ? "album_updated".L() : "album_created".L(),
          subTitle: isEdit
              ? "album_has_been_updated_successfully".L()
              : "album_has_been_created_successfully".L());
    }
  }

  void addEditCateFunc({required List<CategoryModel> cateModelList}) {
    CategoryModel categoryModel = CategoryModel(
        cateTitle: nameTC.text,
        cateImage: eventImage,
        emptySubTitle: "currently_no_album_exists");

    if (widget.isEdit) {
      cateModelList[widget.cateIndex ?? 0] = categoryModel;
    } else {
      cateModelList.add(categoryModel);
    }

    ZBotToast.showToastSuccess(
        message:
            widget.isEdit ? "category_updated".L() : "category_created".L(),
        subTitle: widget.isEdit
            ? "category_has_been_updated_successfully".L()
            : "category_has_been_created_successfully".L());
  }

  void addEditAlbum({required List<CategoryModel> categoryModelList}) {
    AlbumModel albumModel = AlbumModel(
        title: nameTC.text,
        albumImage: eventImage,
        imagesList: categoryModelList[widget.cateIndex ?? 0]
                .albumList?[widget.albumIndex ?? 0]
                .imagesList ??
            [],
        videoControllers: categoryModelList[widget.cateIndex ?? 0]
                .albumList?[widget.albumIndex ?? 0]
                .videoControllers ??
            []);

    if (widget.isEdit) {
      categoryModelList[widget.cateIndex ?? 0]
          .albumList![widget.albumIndex ?? 0] = albumModel;
    } else {
      categoryModelList[widget.cateIndex ?? 0].albumList ??= [];
      categoryModelList[widget.cateIndex ?? 0].albumList!.add(albumModel);
    }
  }
}
