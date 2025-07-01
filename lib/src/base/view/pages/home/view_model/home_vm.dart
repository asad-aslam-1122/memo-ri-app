import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/src/base/view/pages/home/model/category_model.dart';

import '../../../../../../resources/resources.dart';

class HomeVm extends ChangeNotifier {
  List<CategoryModel> userCateModelList = [];

  List<File> videosList = [];

  List<CategoryModel> recommendedCateList = [
    CategoryModel(
        cateTitle: "birthday".L(),
        cateImage: R.appImages.birthdayImg,
        emptySubTitle: "start_creating_your_collection_of_cherished_moments"),
    CategoryModel(
        cateTitle: "anniversary".L(),
        cateImage: R.appImages.marriageImg,
        emptySubTitle: "add_photos_to_celebrate_your_special_milestones"),
    CategoryModel(
        cateTitle: "baby_shower".L(),
        cateImage: R.appImages.babyShowerImg,
        emptySubTitle: "save_the_precious_moments_of_this_beautiful_occasion"),
    CategoryModel(
        cateTitle: "travel".L(),
        cateImage: R.appImages.travelImg,
        emptySubTitle: "upload_pictures_to_document_your_adventures"),
    CategoryModel(
        cateTitle: "celebrations".L(),
        cateImage: R.appImages.celebrationImg,
        emptySubTitle: "add_moments_that_make_life_a_little_brighter"),
    CategoryModel(
        cateTitle: "festivals".L(),
        cateImage: R.appImages.festivalsImg,
        emptySubTitle: "add_joyful_moments_to_brighten_your_collection"),
  ];

  void update() {
    notifyListeners();
  }
}
