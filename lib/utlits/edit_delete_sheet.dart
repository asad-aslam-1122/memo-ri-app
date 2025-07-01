import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';
import '../src/base/model/base_model.dart';

class EditDeleteSheet extends StatefulWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const EditDeleteSheet({
    super.key,
    required this.onDeletePressed,
    required this.onEditPressed,
  });

  @override
  State<EditDeleteSheet> createState() => _EditDeleteSheetState();
}

class _EditDeleteSheetState extends State<EditDeleteSheet> {
  List<BaseModel> optionsList = [
    BaseModel(title: "edit", iconPath: R.appImages.editIcon),
    BaseModel(title: "delete", iconPath: R.appImages.deleteIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: R.decoration.bottomSheetDecor(),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            BaseModel menuModel = optionsList[index];
            return menuItem(baseModel: menuModel, indexValue: index);
          },
          itemCount: optionsList.length,
        ));
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
          widget.onEditPressed();
        }
      case 1:
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
