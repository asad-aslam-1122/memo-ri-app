import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_music_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view_mode/memory_vm.dart';
import 'package:provider/provider.dart';

import '../../../../../../../resources/bot_toast/zbot_toast.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/custom_bottom.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';

class AlbumPhotosView extends StatefulWidget {
  static final String route = "/AlbumPhotosView";

  const AlbumPhotosView({super.key});

  @override
  State<AlbumPhotosView> createState() => _AlbumPhotosViewState();
}

class _AlbumPhotosViewState extends State<AlbumPhotosView> {
  String? title;
  List<String>? imagesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Get.arguments != null) {
      title = Get.arguments["title"];
      imagesList = Get.arguments["imagesList"];

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryVm>(builder: (context, memoryVm, child) {
      return Scaffold(
        appBar: GlobalWidgets.simpleAppBar(title: "${title} Photos"),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            String imagePath = imagesList?[index] ?? "";
            return photosItems(index: index, imagePath: imagePath);
          },
          itemCount: imagesList?.length ?? 0,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: CustomButton(
              onPressed: () {
                if (memoryVm.tempSelectedImageList.length >= 5) {
                  Get.offAndToNamed(AllMusicView.route);
                } else {
                  ZBotToast.showToastError(
                      message: "Select Images",
                      subTitle: "Minimum 5 images are required");
                }
              },
              title: "continue"),
        ),
      );
    });
  }

  Widget photosItems({required String imagePath, required int index}) {
    final MemoryVm memoryVm = context.read<MemoryVm>();

    return GestureDetector(
      onTap: () {
        if (memoryVm.tempSelectedImageList
            .any((photoPath) => photoPath == imagePath)) {
          memoryVm.tempSelectedImageList.remove(imagePath);
        } else {
          memoryVm.tempSelectedImageList.add(imagePath);
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: R.appColors.imageShadowColor.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 2)
            ],
            image: DecorationImage(
                image: FileImage(File(imagePath)), fit: BoxFit.cover),
            color: R.appColors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: memoryVm.tempSelectedImageList
                .any((photoPath) => photoPath == imagePath)
            ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.check_circle,
                    color: R.appColors.white,
                    size: 20,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
