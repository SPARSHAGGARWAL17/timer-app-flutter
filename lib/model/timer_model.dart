import 'dart:convert';

class TimerModel {
  int id;
  final String title;
  final String description;
  int timeInSec;

  TimerModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.timeInSec,
  });

  @override
  String toString() {
    return "TimerModel(id: $id, title: $title, timeInSec: $timeInSec)";
  }

  Map<String, dynamic> toMap([bool update = false]) {
    return <String, dynamic>{
      if (update)
      'id': id,
      'title': title,
      'description': description,
      'time_in_sec': timeInSec <=0 ? 0 : timeInSec,
    };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
    return TimerModel(
      id: map["id"],
      title: map['title'] as String,
      description: map['description'] as String,
      timeInSec: map['time_in_sec'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimerModel.fromJson(String source) =>
      TimerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
