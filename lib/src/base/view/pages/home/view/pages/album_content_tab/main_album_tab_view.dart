import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/album_content_tab/photos_tab_view.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/album_content_tab/video_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../model/category_model.dart';
import '../../../view_model/home_vm.dart';

class MainAlbumTabView extends StatefulWidget {
  static final String route = "/MainAlbumTabView";
  const MainAlbumTabView({super.key});

  @override
  State<MainAlbumTabView> createState() => _MainAlbumTabViewState();
}

class _MainAlbumTabViewState extends State<MainAlbumTabView>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  String? title;
  CategoryModel? categoryModel;
  int? albumIndex;
  List<File>? videoList;

  @override
  void initState() {
    super.initState();
    title = Get.arguments["title"];
    categoryModel = Get.arguments["categoryModel"];
    albumIndex = Get.arguments["albumIndex"];
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Consumer<HomeVm>(builder: (context, homeVm, child) {
        return Scaffold(
          backgroundColor: R.appColors.lightGreyColor,
          appBar: GlobalWidgets.simpleAppBar(title: title ?? ""),
          body: Column(
            children: [
              Container(
                  height: 39,
                  padding: const EdgeInsets.all(3),
                  margin: EdgeInsets.symmetric(horizontal: 20) +
                      EdgeInsets.only(top: 15),
                  decoration: R.decoration.generalDecoration(
                      radius: 20, backgroundColor: R.appColors.highLightColor),
                  child: TabBar(
                    onTap: (value) {
                      setState(() {});
                    },
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: R.appColors.transparent,
                    indicatorColor: R.appColors.primaryColor,
                    unselectedLabelColor: R.appColors.white,
                    indicator: R.decoration.generalDecoration(
                        radius: 20, backgroundColor: R.appColors.primaryColor),
                    labelColor: R.appColors.white,
                    labelStyle: R.textStyles.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                    tabs: [
                      Tab(
                        icon: Text(
                          "photos".L(),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          "videos".L(),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                    PhotosTabView(
                      index: albumIndex ?? 0,
                      categoryModel: categoryModel,
                    ),
                    VideoTabView(
                      index: albumIndex ?? 0,
                      categoryModel: categoryModel,
                    )
                  ])),
            ],
          ),
          floatingActionButton: ((categoryModel!
                          .albumList![albumIndex ?? 0].imagesList.isNotEmpty &&
                      tabController.index == 0) ||
                  (categoryModel!.albumList![albumIndex ?? 0].videoControllers
                          .isNotEmpty &&
                      tabController.index == 1))
              ? Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (tabController.index == 0) {
                        pickMultiImages();
                      } else {
                        pickMultipleVideos(homeVm: homeVm);
                      }
                    },
                    mini: true,
                    shape: CircleBorder(),
                    backgroundColor: R.appColors.primaryColor,
                    child: Icon(
                      Icons.add,
                      color: R.appColors.white,
                      size: 30,
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      }),
    );
  }

  Future<void> pickMultiImages() async {
    try {
      final List<XFile>? selectedFiles = await _picker.pickMultiImage();
      if (selectedFiles != null) {
        setState(() {
          categoryModel?.albumList?[albumIndex ?? 0].imagesList
              .addAll(selectedFiles.map((file) => file.path).toList());
        });
      }
    } catch (e) {
      print("Error picking media: $e");
    }
  }

  Future<void> pickMultipleVideos({required HomeVm homeVm}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      for (var controller
          in categoryModel!.albumList![albumIndex ?? 0].videoControllers) {
        controller.dispose();
      }

      homeVm.videosList ??= [];

      print("Before adding, video list length: ${homeVm.videosList.length}");

      homeVm.videosList.addAll(result.paths.map((path) => File(path!)));

      print("After adding, video list length: ${homeVm.videosList.length}");

      homeVm.update();

      categoryModel!.albumList![albumIndex ?? 0].videoControllers =
          homeVm.videosList
              .map((file) => VideoPlayerController.file(file)
                ..initialize().then((_) {
                  setState(() {});
                }))
              .toList();

      print(
          "Total Video Controllers: ${categoryModel!.albumList![albumIndex ?? 0].videoControllers.length}");

      Get.forceAppUpdate();
      setState(() {});
    }
  }
}
