import 'package:video_player/video_player.dart';

class CategoryModel {
  String cateTitle;
  String cateImage;
  String emptySubTitle;
  List<AlbumModel>? albumList;

  CategoryModel(
      {required this.cateTitle,
      required this.cateImage,
      required this.emptySubTitle,
      this.albumList});
}

class AlbumModel {
  String title;
  String albumImage;
  List<String> imagesList;
  List<VideoPlayerController> videoControllers;

  AlbumModel(
      {required this.title,
      required this.albumImage,
      required this.imagesList,
      required this.videoControllers});
}
