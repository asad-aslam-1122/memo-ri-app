import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_music_view.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/gallery_or_cate_sheet.dart';
import '../../view_mode/memory_vm.dart';
import '../widget/audio_player_widget.dart';
import '../widget/resolution_widget.dart';
import 'all_cate_albums.dart';

class MemoryDashboardView extends StatefulWidget {
  static final String route = "/MemoryDashboardView";

  const MemoryDashboardView({super.key});

  @override
  State<MemoryDashboardView> createState() => _MemoryDashboardViewState();
}

class _MemoryDashboardViewState extends State<MemoryDashboardView> {
  int selectedImage = 0;
  final List<Color> colors = [
    R.appColors.primaryColor,
    R.appColors.highLightColor,
    R.appColors.standardGreyColor,
    R.appColors.primaryColor,
    R.appColors.highLightColor,
  ];

  final List<int> duration = List.generate(80, (index) => 800);

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryVm>(builder: (context, memoryVm, child) {
      return Scaffold(
          backgroundColor: R.appColors.white,
          appBar: AppBar(
            backgroundColor: R.appColors.primaryColor,
            surfaceTintColor: R.appColors.primaryColor,
            actions: [
              GlobalWidgets.resolutionWidget(
                  title: memoryVm.tempSelectedResolution,
                  backgroundColor:
                      R.appColors.standardGreyColor.withValues(alpha: 0.5),
                  onTab: () => resolutionAlert()),
              SizedBox(
                width: 8,
              ),
              GlobalWidgets.smallBtn(
                  onPressed: () {
                    Get.back();
                  },
                  height: 30,
                  title: "save",
                  fontWeight: FontWeight.w700,
                  backgroundColor: R.appColors.white,
                  textColor: R.appColors.primaryColor),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(
                            memoryVm.tempSelectedImageList[selectedImage],
                          )),
                          fit: BoxFit.cover)),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            int selectedOriginal = selectedImage;

                            if (memoryVm.tempSelectedImageList.length > 5) {
                              if (selectedImage > 0) {
                                setState(() {
                                  selectedImage -= 1;
                                });
                              }
                              memoryVm.tempSelectedImageList
                                  .removeAt(selectedOriginal);
                              memoryVm.update();
                            } else {
                              ZBotToast.showToastError(
                                  message: "Video Editor",
                                  subTitle: "Minimum 5 images are required");
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: R.appColors.red,
                          )),
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () async {
                            memoryVm.tempSelectedImageList[selectedImage] =
                                await cropImage(
                                      filePath: memoryVm
                                          .tempSelectedImageList[selectedImage],
                                      isOptionsEnabled: false,
                                    ) ??
                                    memoryVm
                                        .tempSelectedImageList[selectedImage];
                            memoryVm.update();
                          },
                          icon: Icon(
                            Icons.crop_free,
                            color: R.appColors.primaryColor,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.bottomSheet(GalleryOrCateSheet(
                                onSelectCatePressed: () {
                                  Get.back();
                                  Get.toNamed(AllCateAlbums.route);
                                },
                                onSelectGalleryPressed: () {
                                  Get.back();
                                  pickMultiImages(memoryVm: memoryVm);
                                },
                              )),
                          icon: Icon(
                            Icons.add_box_rounded,
                            color: R.appColors.primaryColor,
                            size: 30,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40,
                          child: ListView.builder(
                            padding: EdgeInsets.only(right: 15),
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedImage = index;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 40,
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          selectedImage == index ? 2 : 1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: selectedImage == index
                                          ? Border.all(
                                              color: R.appColors.primaryColor,
                                              width: 2)
                                          : null,
                                      image: DecorationImage(
                                          image: FileImage(File(
                                            memoryVm
                                                .tempSelectedImageList[index],
                                          )),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            },
                            itemCount: memoryVm.tempSelectedImageList.length,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.toNamed(AllMusicView.route),
                          icon: Icon(
                            Icons.add_box_rounded,
                            color: R.appColors.primaryColor,
                            size: 30,
                          )),
                      SizedBox(width: 15),
                      if (memoryVm.selectedMusic != null)
                        Expanded(
                          child: AudioPlayerWidget(
                              url: memoryVm
                                  .tempMusicList[memoryVm.selectedMusic ?? 0]
                                  .musicPath),
                        )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ));
    });
  }

  void resolutionAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return ResolutionWidget();
      },
    );
  }

  Future<void> pickMultiImages({required MemoryVm memoryVm}) async {
    final ImagePicker picker = ImagePicker();

    try {
      final List<XFile>? selectedFiles = await picker.pickMultiImage();
      if (selectedFiles != null && selectedFiles.isNotEmpty) {
        memoryVm.tempSelectedImageList
            .addAll(selectedFiles.map((file) => file.path).toList());
        memoryVm.update();
      }
    } catch (e) {
      print("Error picking media: $e");
    }
  }

  Future<String?> cropImage(
      {required String filePath, required bool isOptionsEnabled}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          aspectRatioPresets: isOptionsEnabled
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.square,
                ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: isOptionsEnabled
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.square,
                ],
        ),
      ],
    );
    return croppedFile!.path;
  }
}
