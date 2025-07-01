class EventModel {
  String mainCateTitle;
  String subCateTitle;
  bool isRecursive;
  String recursionPeriod;
  DateTime scheduleEvent;
  String description;
  String image;

  EventModel(
      {required this.mainCateTitle,
      required this.subCateTitle,
      required this.isRecursive,
      required this.recursionPeriod,
      required this.scheduleEvent,
      required this.description,
      required this.image});
}
