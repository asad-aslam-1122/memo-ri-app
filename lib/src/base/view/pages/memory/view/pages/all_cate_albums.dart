import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/model/category_model.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view_model/home_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/album_photos_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utlits/global_widgets/global_widgets.dart';

class AllCateAlbums extends StatefulWidget {
  static final String route = "/AllCateAlbums";
  const AllCateAlbums({super.key});

  @override
  State<AllCateAlbums> createState() => _AllCateAlbumsState();
}

class _AllCateAlbumsState extends State<AllCateAlbums> {
  List<AlbumModel>? recommendedAlbums;
  List<AlbumModel>? userCateAlbums;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HomeVm homeVm = context.read<HomeVm>();

    if (homeVm.recommendedCateList.isNotEmpty) {
      recommendedAlbums = homeVm.recommendedCateList
          .where((recommendedCategory) => recommendedCategory.albumList != null)
          .expand((recommendedCategory) => recommendedCategory.albumList!)
          .toList();
    }
    if (homeVm.userCateModelList.isNotEmpty) {
      userCateAlbums = homeVm.userCateModelList
          .where((userCategory) => userCategory.albumList != null)
          .expand((userCategory) => userCategory.albumList!)
          .toList();
    }

    print("userCateAlbums ${userCateAlbums?.length}");
    print("recommendedAlbums ${recommendedAlbums?.length}");

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.lightGreyColor,
      appBar: GlobalWidgets.simpleAppBar(title: "all_cate_album".L()),
      body: ((recommendedAlbums?.isEmpty ?? false) &&
              ((userCateAlbums?.isEmpty ?? false) || userCateAlbums == null))
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "no_album_exists".L(),
                    textAlign: TextAlign.center,
                    style: R.textStyles.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "currently_no_album_is_existing".L(),
                    style: R.textStyles.urbanist(
                        fontSize: 15.sp, color: R.appColors.hintColor),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (recommendedAlbums?.isNotEmpty ?? false) ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "memo_ri_hub_albums".L(),
                          style: R.textStyles.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        AlbumModel? albumModel = recommendedAlbums?[index];
                        return GestureDetector(
                          onTap: () => Get.offAndToNamed(AlbumPhotosView.route,
                              arguments: {
                                "title": albumModel?.title ?? '',
                                "imagesList": albumModel?.imagesList ?? [],
                              }),
                          child: GlobalWidgets.cateAndAlbumItems(
                            imagePath: albumModel?.albumImage ?? '',
                            useAsset: false,
                            title: albumModel?.title ?? '',
                          ),
                        );
                      },
                      itemCount: recommendedAlbums?.length ?? 0,
                    ),
                  ],
                  if (userCateAlbums?.isNotEmpty ?? false) ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "my_categories_albums".L(),
                          style: R.textStyles.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        AlbumModel? albumModel = userCateAlbums?[index];

                        return GestureDetector(
                          onTap: () =>
                              Get.toNamed(AlbumPhotosView.route, arguments: {
                            "title": albumModel?.title ?? '',
                            "imagesList": albumModel?.imagesList ?? [],
                          }),
                          child: GlobalWidgets.cateAndAlbumItems(
                            imagePath: albumModel?.albumImage ?? '',
                            useAsset: false,
                            title: albumModel?.title ?? '',
                          ),
                        );
                      },
                      itemCount: userCateAlbums?.length ?? 0,
                    )
                  ]
                ],
              ),
            ),
    );
  }
}
