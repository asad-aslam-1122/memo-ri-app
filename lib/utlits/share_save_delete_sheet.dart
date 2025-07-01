import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/model/base_model.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view_model/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';
import 'global_widgets/global_widgets.dart';

class ShareSaveDeleteSheet extends StatefulWidget {
  final VoidCallback onSharePressed;
  final VoidCallback onSavePressed;
  final VoidCallback onDeletePressed;

  const ShareSaveDeleteSheet({
    super.key,
    required this.onSharePressed,
    required this.onSavePressed,
    required this.onDeletePressed,
  });

  @override
  State<ShareSaveDeleteSheet> createState() => _ShareSaveDeleteSheetState();
}

class _ShareSaveDeleteSheetState extends State<ShareSaveDeleteSheet> {
  List<BaseModel> baseModelList = [
    BaseModel(title: "share", iconPath: R.appImages.shareImg),
    BaseModel(title: "save_to_gallery", iconPath: R.appImages.downloadImg),
    BaseModel(title: "delete", iconPath: R.appImages.deleteIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, homeVm, child) {
      return Container(
        decoration: R.decoration.bottomSheetDecor(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalWidgets.bottomSheetBar(),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  BaseModel menuModel = baseModelList[index];
                  return menuItem(baseModel: menuModel, indexValue: index);
                },
                itemCount: baseModelList.length,
              )
            ],
          ),
        ),
      );
    });
  }

  Widget menuItem({required BaseModel baseModel, required int indexValue}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 6),
      onTap: () => navigationFunc(index: indexValue),
      visualDensity: VisualDensity.compact,
      leading: IconButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            CircleBorder(),
          ),
          backgroundColor: WidgetStatePropertyAll(
            R.appColors.iconBackground,
          ),
        ),
        onPressed: () {},
        icon: Image.asset(
          baseModel.iconPath,
          height: 22,
        ),
      ),
      title: Text(
        baseModel.title.L(),
        style:
            R.textStyles.urbanist(fontWeight: FontWeight.w500, fontSize: 18.sp),
      ),
    );
  }

  void navigationFunc({required int index}) {
    switch (index) {
      case 0:
        {
          widget.onSharePressed();
        }
      case 1:
        {
          widget.onSavePressed();
        }
      case 2:
        {
          widget.onDeletePressed();
        }
      default:
        {
          print("Invalid Option");
        }
    }
  }
}
