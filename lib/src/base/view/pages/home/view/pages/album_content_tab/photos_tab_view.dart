import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/model/category_model.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/album_content_tab/photos_view.dart';
import 'package:memo_ri_app/src/core/empty_view.dart';
import 'package:memo_ri_app/utlits/share_save_delete_sheet.dart';
import 'package:memo_ri_app/utlits/simple_sheet.dart';

import '../../../../../../../../resources/resources.dart';

class PhotosTabView extends StatefulWidget {
  final CategoryModel? categoryModel;
  final int? index;

  PhotosTabView({super.key, required this.categoryModel, required this.index});

  @override
  State<PhotosTabView> createState() => _PhotosTabViewState();
}

class _PhotosTabViewState extends State<PhotosTabView> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return widget.categoryModel?.albumList?[widget.index ?? 0].imagesList
                .isEmpty ??
            false
        ? EmptyView(
            title: "no_photos".L(),
            subTitle: "start_adding_your_favorite_moments_to_see_them_here".L(),
            imagePath: R.appImages.imageIcon,
            buttonTitle: "upload",
            onPressed: () => pickMultiImages(),
          )
        : GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 100),
            itemBuilder: (context, index) => photosItems(index: index),
            itemCount: widget
                .categoryModel?.albumList?[widget.index ?? 0].imagesList.length,
            shrinkWrap: true,
          );
  }

  Widget photosItems({required int index}) {
    List<String> imagesList =
        widget.categoryModel?.albumList?[widget.index ?? 0].imagesList ?? [];

    return GestureDetector(
      onTap: () {
        Get.toNamed(PhotosView.route,
            arguments: {"imagePath": imagesList[index]});
      },
      onLongPress: () => Get.bottomSheet(
        ShareSaveDeleteSheet(
          onDeletePressed: () {
            Get.back();
            Get.bottomSheet(SimpleSheet(
                onRightPressed: () {
                  imagesList.removeAt(index);
                  Get.forceAppUpdate();
                  setState(() {});
                  Get.back();
                },
                leftBtnTitle: "cancel",
                rightBtnTitle: "delete",
                imagePath: R.appImages.deleteIcon,
                iconColor: R.appColors.red,
                subTitle: "${"are_you_sure_you_want_to_delete".L()}?"));
          },
          onSavePressed: () {
            Get.back();
          },
          onSharePressed: () {
            Get.back();
          },
        ),
      ),
      child: Hero(
        tag: imagesList[index],
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: R.appColors.imageShadowColor.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 2)
              ],
              image: DecorationImage(
                  image: FileImage(File(imagesList[index])), fit: BoxFit.cover),
              color: R.appColors.transparent,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Future<void> pickMultiImages() async {
    try {
      final List<XFile>? selectedFiles = await picker.pickMultiImage();
      if (selectedFiles != null) {
        widget.categoryModel?.albumList?[widget.index ?? 0].imagesList =
            selectedFiles.map((file) => file.path).toList();

        Get.forceAppUpdate();

        setState(() {});
      }
    } catch (e) {
      print("Error picking media: $e");
    }
  }
}
