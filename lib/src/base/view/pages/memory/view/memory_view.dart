import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_cate_albums.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_music_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view_mode/memory_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utlits/gallery_or_cate_sheet.dart';
import '../../../../../core/empty_view.dart';

class MemoryView extends StatefulWidget {
  const MemoryView({super.key});

  @override
  State<MemoryView> createState() => _MemoryViewState();
}

class _MemoryViewState extends State<MemoryView> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryVm>(builder: (context, memoryVm, child) {
      return Scaffold(
        backgroundColor: R.appColors.lightGreyColor,
        appBar: AppBar(
          backgroundColor: R.appColors.primaryColor,
          surfaceTintColor: R.appColors.primaryColor,
          centerTitle: true,
          title: Text(
            "my_memories".L(),
            style: R.textStyles.urbanist(
                fontWeight: FontWeight.w500,
                fontSize: 19.sp,
                color: R.appColors.white),
          ),
        ),
        body: memoryVm.memoryModelList.isEmpty
            ? EmptyView(
                title: "no_memories".L(),
                subTitle:
                    "begin_capturing_and_preserving_your_special_moments".L(),
                imagePath: R.appImages.memoryIcon,
                buttonTitle: "create_memory",
                onPressed: () {
                  memoryVm.tempSelectedImageList.clear();
                  Get.bottomSheet(GalleryOrCateSheet(
                    onSelectCatePressed: () {
                      Get.back();
                      Get.toNamed(AllCateAlbums.route);
                    },
                    onSelectGalleryPressed: () {
                      pickMultiImages(memoryVm: memoryVm);
                    },
                  ));
                },
              )
            : SizedBox(),
      );
    });
  }

  Future<void> pickMultiImages({required MemoryVm memoryVm}) async {
    try {
      Get.back();
      final List<XFile>? selectedFiles = await picker.pickMultiImage();
      if (selectedFiles != null) {
        memoryVm.tempSelectedImageList =
            selectedFiles.map((file) => file.path).toList();
        if (memoryVm.tempSelectedImageList.length >= 5) {
          Get.toNamed(AllMusicView.route);
        } else {
          ZBotToast.showToastError(
              message: "Select Images",
              subTitle: "Minimum 5 images are required");
        }
      }
    } catch (e) {
      print("Error picking media: $e");
    }
  }
}
