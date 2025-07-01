import 'package:flutter/material.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/model/memory_item_model.dart';

import '../../../../../../resources/resources.dart';
import '../model/music_model.dart';

class MemoryVm extends ChangeNotifier {
  List<MemoryItemModel> memoryModelList = [];
  String tempSelectedResolution = "720p";
  List<String> tempSelectedImageList = [];
  List<MusicModel> tempMusicList = [
    MusicModel(
        title: "Music Demo 1",
        imagePath: R.appImages.musicDemo1,
        musicPath:
            // "https://drive.google.com/uc?export=download&id=1SEeU3zoCdHBCZuC4ccKxudwTrWoyDFZb"
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
    MusicModel(
        title: "Music Demo 2",
        imagePath: R.appImages.musicDemo2,
        musicPath:
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"
        // "https://drive.google.com/uc?export=download&id=1bucSRX_Or1BbctibucbtjHuaCT1Ob8M0"
        ),
    MusicModel(
      title: "Music Demo 3",
      imagePath: R.appImages.musicDemo1,
      musicPath:
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
      // "https://drive.google.com/uc?export=download&id=1wpo5glZuqsWwKre8VJ-m1rpi3Md1fiMH"
    ),
    MusicModel(
        title: "Music Demo 4",
        imagePath: R.appImages.musicDemo2,
        musicPath:
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3"),
    MusicModel(
        title: "Music Demo 5",
        imagePath: R.appImages.musicDemo1,
        musicPath:
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
        isPro: true),
    MusicModel(
        title: "Music Demo 6",
        imagePath: R.appImages.musicDemo2,
        musicPath:
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
        isPro: true),
  ];
  int? selectedMusic;

  void update() {
    notifyListeners();
  }
}
