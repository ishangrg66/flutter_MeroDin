class ScheduleModel {
  final int id;
  final String title;
  final String endTime;
  final String scheduleDate;
  final String scheduleTime;
  final String guest;
  final int priority;
  final int visibility;
  final String description;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.endTime,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.guest,
    required this.priority,
    required this.visibility,
    required this.description,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      endTime: json['endTime'] ?? '',
      scheduleDate: json['scheduleDate'],
      scheduleTime: json['scheduleTime'] ?? '',
      guest: json['guest'] ?? '',
      priority: json['priority'] ?? 0,
      visibility: json['visibility'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "endTime": endTime,
      "scheduleDate": scheduleDate,
      "scheduleTime": scheduleTime,
      "guest": guest,
      "priority": priority,
      "visibility": visibility,
      "description": description,
    };
  }
}
