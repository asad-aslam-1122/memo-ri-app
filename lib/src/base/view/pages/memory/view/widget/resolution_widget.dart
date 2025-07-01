import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view_mode/memory_vm.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../../../resources/resources.dart';

class ResolutionWidget extends StatefulWidget {
  const ResolutionWidget({super.key});

  @override
  State<ResolutionWidget> createState() => _ResolutionWidgetState();
}

class _ResolutionWidgetState extends State<ResolutionWidget> {
  double resolutionValue = 0;

  List<String> resolutionMenus = [
    "720p",
    "1080p",
    "2k",
    "4k",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialResolution();
  }

  void initialResolution() {
    MemoryVm memoryVm = context.read<MemoryVm>();

    if (memoryVm.tempSelectedResolution == resolutionMenus[0]) {
      resolutionValue = 0;
    } else if (memoryVm.tempSelectedResolution == resolutionMenus[1]) {
      resolutionValue = 1;
    } else if (memoryVm.tempSelectedResolution == resolutionMenus[2]) {
      resolutionValue = 2;
    } else {
      resolutionValue = 3;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      backgroundColor: R.appColors.transparent,
      top: true,
      child: Material(
        color: R.appColors.transparent,
        child: Consumer<MemoryVm>(builder: (context, memoryVm, child) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: R.appColors.middleGreyColor.withValues(alpha: 0.01),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.only(bottom: 16),
                    decoration: R.decoration.generalDecoration(
                        radius: 0, backgroundColor: R.appColors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25) +
                              EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "set_resolution".L(),
                                style: R.textStyles.urbanist(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () {
                                  memoryVm.update();

                                  Get.back();
                                },
                                child: Text(
                                  "save".L(),
                                  style: R.textStyles.urbanist(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: R.appColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SfSlider(
                          min: 0,
                          max: 3,
                          value: resolutionValue,
                          showDividers: true,
                          stepDuration: SliderStepDuration(seconds: 1),
                          stepSize: 1,
                          thumbIcon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: R.appColors.white,
                                border: Border.all(
                                    color: R.appColors.highLightColor,
                                    width: 2)),
                          ),
                          activeColor: R.appColors.primaryColor,
                          inactiveColor: R.appColors.middleGreyColor,
                          onChanged: (newValue) {
                            setState(() {
                              resolutionValue = newValue;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              resolutionMenus.length,
                              (index) {
                                return Text(
                                  index == 1 || index == 2
                                      ? "${resolutionMenus[index]} \t\t\t\t "
                                      : resolutionMenus[index],
                                  style: R.textStyles.urbanist(
                                      fontSize: 14.sp,
                                      color: currentResolution(
                                          index: index, memoryVm: memoryVm)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Color currentResolution({required int index, required MemoryVm memoryVm}) {
    if (index == resolutionValue) {
      memoryVm.tempSelectedResolution = resolutionMenus[index];
      return R.appColors.black;
    } else {
      return R.appColors.middleGreyColor;
    }
  }
}
