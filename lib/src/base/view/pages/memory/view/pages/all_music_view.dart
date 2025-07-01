import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memo_ri_app/resources/bot_toast/zbot_toast.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/model/music_model.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/memory_dashboard_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/widget/resolution_widget.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view_mode/memory_vm.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view/subscription_view.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view_model/subscription_vm.dart';
import 'package:memo_ri_app/utlits/custom_bottom.dart';
import 'package:memo_ri_app/utlits/global_widgets/global_widgets.dart';
import 'package:memo_ri_app/utlits/safe_area_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';

class AllMusicView extends StatefulWidget {
  static final String route = "/AllMusicView";
  const AllMusicView({super.key});

  @override
  State<AllMusicView> createState() => _AllMusicViewState();
}

class _AllMusicViewState extends State<AllMusicView> {
  final AudioPlayer backgroundMusic = AudioPlayer();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    backgroundMusic.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        backgroundMusic.playerStateStream.listen((playerState) {
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      top: true,
      backgroundColor: R.appColors.primaryColor,
      child: Consumer<MemoryVm>(builder: (context, memoryVm, child) {
        return Scaffold(
          backgroundColor: R.appColors.lightGreyColor,
          appBar: GlobalWidgets.simpleAppBar(
              title: "select_music_and_resolution".L()),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setResolutionWidget(memoryVm: memoryVm),
                SizedBox(
                  height: 20,
                ),
                musicListWidget(
                    musicModelList: memoryVm.tempMusicList, memoryVm: memoryVm)
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: CustomButton(
                onPressed: () {
                  if (memoryVm.selectedMusic != null) {
                    backgroundMusic.stop();
                    Get.offAndToNamed(MemoryDashboardView.route);
                  } else {
                    ZBotToast.showToastError(
                        message: "Select Music",
                        subTitle: "Please select any one music file.");
                  }
                },
                title: "generate_video"),
          ),
        );
      }),
    );
  }

  Widget setResolutionWidget({required MemoryVm memoryVm}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: R.decoration.shadowDecor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "set_resolution".L(),
            style: R.textStyles
                .urbanist(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          GlobalWidgets.resolutionWidget(
              title: memoryVm.tempSelectedResolution,
              onTab: () => resolutionAlert()),
        ],
      ),
    );
  }

  Widget musicListWidget(
      {required List<MusicModel> musicModelList, required MemoryVm memoryVm}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: R.decoration.shadowDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_music".L(),
            style: R.textStyles
                .urbanist(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return musicItem(
                musicModel: musicModelList[index],
                memoryVm: memoryVm,
                index: index,
              );
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: musicModelList.length,
          )
        ],
      ),
    );
  }

  Widget musicItem(
      {required MusicModel musicModel,
      required int index,
      required MemoryVm memoryVm}) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      onTap: () => playMusicHandler(
          index: index, musicModel: musicModel, memoryVm: memoryVm),
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
        onTap: () => playMusicHandler(
            index: index, musicModel: musicModel, memoryVm: memoryVm),
        child: Container(
          height: 35,
          width: 35,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: AssetImage(musicModel.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: R.appColors.lightGreyColor.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                    (memoryVm.selectedMusic == index &&
                            backgroundMusic.playerState.playing)
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 16,
                    color: R.appColors.primaryColor)),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (musicModel.isPro ?? false)
            Container(
              width: 25,
              decoration: R.decoration.generalDecoration(
                  radius: 3, backgroundColor: R.appColors.primaryColor),
              child: Center(
                child: Text(
                  "pro".L(),
                  style: R.textStyles.urbanist(
                      fontSize: 13.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w700,
                      color: R.appColors.white),
                ),
              ),
            ),
          Text(
            musicModel.title,
            style: R.textStyles
                .urbanist(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      trailing: Icon(
        memoryVm.selectedMusic == index
            ? Icons.check_box
            : Icons.add_box_rounded,
        color: R.appColors.primaryColor,
      ),
    );
  }

  void setMusic({required String musicPath}) async {
    await backgroundMusic.setAudioSource(AudioSource.uri(Uri.parse(musicPath)));
    await backgroundMusic.setLoopMode(LoopMode.one);
    backgroundMusic.play();

    setState(() {});
  }

  void playMusicHandler(
      {required MusicModel musicModel,
      required int index,
      required MemoryVm memoryVm}) async {
    final subscriptionVm = context.read<SubscriptionVm>();
    if (memoryVm.selectedMusic == index) {
      if (backgroundMusic.playerState.playing) {
        backgroundMusic.pause();
      } else {
        backgroundMusic.play();
      }

      memoryVm.selectedMusic = index;

      setState(() {});
    } else if (musicModel.isPro ?? false) {
      if (!subscriptionVm.hasSubscribed) {
        memoryVm.selectedMusic = null;
        memoryVm.selectedMusic = index;
        memoryVm.update();
        Get.toNamed(SubscriptionView.route, arguments: {"isFromSetting": true});
      }
    } else {
      memoryVm.selectedMusic = index;
      memoryVm.update();
      setMusic(musicPath: musicModel.musicPath);
    }
  }

  void resolutionAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return ResolutionWidget();
      },
    );
  }
}
