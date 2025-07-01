import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../../resources/resources.dart';

class VideoPlayerView extends StatefulWidget {
  static final String route = "/VideoPlayerView";

  const VideoPlayerView({super.key});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = Get.arguments["videoPlayerController"];

    if (videoPlayerController != null) {
      videoPlayerController!.initialize().then((_) {
        setState(() {});
        videoPlayerController!.play();
      }).catchError((error) {
        print("Video initialization error: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (videoPlayerController != null) {
          videoPlayerController!.seekTo(Duration.zero);
          videoPlayerController!.pause();
        }
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: R.appColors.black,
        appBar: appBarWidget(title: "videos".L()),
        body: VideoPlayer(videoPlayerController!),
      ),
    );
    ;
  }

  AppBar appBarWidget({required String title}) {
    return AppBar(
      backgroundColor: R.appColors.primaryColor,
      surfaceTintColor: R.appColors.primaryColor,
      centerTitle: true,
      title: Text(
        title,
        style: R.textStyles.urbanist(
            fontWeight: FontWeight.w500,
            fontSize: 19.sp,
            color: R.appColors.white),
      ),
      leading: IconButton(
          onPressed: () {
            if (videoPlayerController != null) {
              videoPlayerController!.seekTo(Duration(seconds: 0));
              videoPlayerController!.pause();
            }

            Get.back();
          },
          icon: Icon(Icons.arrow_back)),
    );
  }
}
