import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/model/category_model.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/album_content_tab/main_album_tab_view.dart';
import 'package:memo_ri_app/utlits/create_edit_cate_album.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/edit_delete_sheet.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';
import '../../../../../../../utlits/simple_sheet.dart';
import '../../../../../../core/empty_view.dart';

class AlbumsView extends StatefulWidget {
  static final String route = "/AlbumsView";

  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  CategoryModel? categoryModel;
  bool? isRecommended;
  int indexValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryModel = Get.arguments["categoryModel"];
    isRecommended = Get.arguments["isRecommended"];
    indexValue = Get.arguments["index"];

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Scaffold(
        backgroundColor: R.appColors.lightGreyColor,
        appBar:
            GlobalWidgets.simpleAppBar(title: categoryModel?.cateTitle ?? ""),
        body: (categoryModel?.albumList?.isEmpty ?? false) ||
                categoryModel?.albumList == null
            ? EmptyView(
                title:
                    "${"no".L()} ${categoryModel?.cateTitle ?? ""} ${"photos".L()}",
                subTitle: categoryModel?.emptySubTitle.L() ?? "",
                imagePath: R.appImages.celebrationIcon,
                buttonTitle: "create",
                onPressed: () async {
                  await Get.bottomSheet(CreateEditCateAlbum(
                    title: "create_album",
                    hintText: "album_name",
                    isFromAlbum: true,
                    cateIndex: indexValue,
                    isRecommended: isRecommended,
                    isEdit: false,
                  ));
                  setState(() {});
                },
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 0,
                    mainAxisExtent: 110),
                itemBuilder: (context, albumIndex) {
                  AlbumModel? albumModel =
                      categoryModel?.albumList?[albumIndex];

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(MainAlbumTabView.route, arguments: {
                        "title": albumModel?.title ?? "",
                        "categoryModel": categoryModel,
                        "albumIndex": albumIndex,
                      });
                    },
                    onLongPress: () =>
                        Get.bottomSheet(EditDeleteSheet(onDeletePressed: () {
                      Get.back();
                      Get.bottomSheet(SimpleSheet(
                          onRightPressed: () {
                            categoryModel?.albumList!.remove(albumModel);
                            Get.back();
                            setState(() {});
                          },
                          iconColor: R.appColors.red,
                          leftBtnTitle: "cancel",
                          rightBtnTitle: "delete",
                          imagePath: R.appImages.deleteIcon,
                          subTitle:
                              "${"are_you_sure_you_want_to_delete".L()} ${albumModel?.title ?? ""} album?"));
                    }, onEditPressed: () async {
                      Get.back();
                      await Get.bottomSheet(CreateEditCateAlbum(
                        title: "edit_album",
                        hintText: "album_name",
                        isEdit: true,
                        albumIndex: albumIndex,
                        isFromAlbum: true,
                        isRecommended: isRecommended,
                        cateIndex: indexValue,
                      ));
                      setState(() {});
                    })),
                    child: GlobalWidgets.cateAndAlbumItems(
                      imagePath: albumModel?.albumImage ?? "",
                      useAsset: false,
                      title: albumModel?.title ?? "",
                    ),
                  );
                },
                itemCount: categoryModel?.albumList?.length ?? 0,
                shrinkWrap: true,
              ),
        floatingActionButton: (categoryModel?.albumList?.isEmpty ?? false) ||
                categoryModel?.albumList == null
            ? null
            : Container(
                margin: EdgeInsets.only(bottom: 5.h),
                child: FloatingActionButton(
                  onPressed: () async {
                    await Get.bottomSheet(CreateEditCateAlbum(
                      title: "create_album",
                      hintText: "album_name",
                      isFromAlbum: true,
                      cateIndex: indexValue,
                      isRecommended: isRecommended,
                      isEdit: false,
                    ));
                    setState(() {});
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
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
