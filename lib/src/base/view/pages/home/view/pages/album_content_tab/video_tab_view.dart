import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/album_content_tab/video_player_view.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view_model/home_vm.dart';
import 'package:memo_ri_app/src/core/empty_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../utlits/share_save_delete_sheet.dart';
import '../../../../../../../../utlits/simple_sheet.dart';
import '../../../model/category_model.dart';

class VideoTabView extends StatefulWidget {
  final CategoryModel? categoryModel;
  final int? index;

  VideoTabView({super.key, required this.categoryModel, required this.index});

  @override
  State<VideoTabView> createState() => _VideoTabViewState();
}

class _VideoTabViewState extends State<VideoTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(
      builder: (context, homeVm, child) {
        return widget.categoryModel?.albumList?[widget.index ?? 0]
                    .videoControllers.isEmpty ??
                false
            ? EmptyView(
                title: "no_videos".L(),
                subTitle: "upload_videos_to_relive_the_best_times".L(),
                imagePath: R.appImages.videoIcon,
                buttonTitle: "upload",
                onPressed: () => pickMultipleVideos(homeVm: homeVm),
              )
            : GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 13,
                    mainAxisExtent: 100),
                itemBuilder: (context, index) => videoItems(index: index),
                itemCount: widget.categoryModel?.albumList?[widget.index ?? 0]
                    .videoControllers.length,
                shrinkWrap: true,
              );
      },
    );
  }

  Widget videoItems({required int index}) {
    List<VideoPlayerController> videoList =
        widget.categoryModel?.albumList?[widget.index ?? 0].videoControllers ??
            [];

    return GestureDetector(
      onTap: () => Get.toNamed(VideoPlayerView.route,
          arguments: {"videoPlayerController": videoList[index]}),
      onLongPress: () => Get.bottomSheet(
        ShareSaveDeleteSheet(
          onDeletePressed: () {
            Get.back();
            Get.bottomSheet(SimpleSheet(
                onRightPressed: () {
                  videoList.removeAt(index);
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
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: R.appColors.imageShadowColor.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 2)
            ],
            color: R.appColors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: VideoPlayer(videoList[index]),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: R.appColors.black.withValues(alpha: .3)),
                child: Text(
                  formatDuration(Duration(
                      seconds: videoList[index].value.duration.inSeconds)),
                  style: R.textStyles.poppins(
                      fontSize: 13.sp,
                      color: R.appColors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickMultipleVideos({required HomeVm homeVm}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      for (var controller in widget
          .categoryModel!.albumList![widget.index ?? 0].videoControllers) {
        controller.dispose();
      }

      homeVm.videosList = result.paths.map((path) => File(path!)).toList();
      widget.categoryModel!.albumList![widget.index ?? 0].videoControllers =
          homeVm.videosList
              .map((file) => VideoPlayerController.file(file)
                ..initialize().then((_) {
                  setState(() {});
                }))
              .toList();

      Get.forceAppUpdate();

      setState(() {});
    }
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }
}
