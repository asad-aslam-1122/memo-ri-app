class NotificationModel {
  String title;

  NotificationModel(
      {required this.title,
      required this.subTitle,
      required this.imagePath,
      required this.receiveTime,
      this.isNew});

  String subTitle;
  String imagePath;
  DateTime receiveTime;
  bool? isNew;
}
