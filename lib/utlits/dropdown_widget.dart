import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class DropdownWidget extends StatefulWidget {
  final String? selectedValue;
  final String hintText;
  final bool isDisable;
  final bool? notLocalized;
  final List<String> list;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownWidget(
      {super.key,
      this.notLocalized,
      required this.selectedValue,
      required this.hintText,
      required this.onChanged,
      required this.list,
      this.isDisable = false,
      required this.validator});

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedValue = widget.selectedValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            openMenuIcon: Icon(Icons.keyboard_arrow_up)),
        dropdownStyleData: DropdownStyleData(
          elevation: 1,
          offset: const Offset(-1, 0),
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        hint: Text(
          widget.hintText.L(),
          style: R.textStyles.urbanist(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: R.appColors.hintColor),
        ),
        validator: widget.validator,
        items: widget.list.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;

          return DropdownMenuItem<String>(
            value: item,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (widget.notLocalized ?? false) ? item : item.L(),
                  textAlign: TextAlign.start,
                  style: R.textStyles.urbanist(
                    fontSize: 16.sp,
                    color: R.appColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // if (index != widget.list.length - 1)
                //   Divider(
                //     color: R.appColors.borderColor,
                //   ),
              ],
            ),
          );
        }).toList(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: selectedValue,
        onChanged: widget.isDisable == true ? null : widget.onChanged,
        menuItemStyleData: const MenuItemStyleData(height: 40),
        isDense: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            filled: true,
            fillColor: R.appColors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: R.appColors.borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: R.appColors.borderColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: R.appColors.borderColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: R.appColors.borderColor))),
      ),
    );
  }
}
