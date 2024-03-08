import 'dart:convert';

class TimerModel {
  final String title;
  final String description;
  int timerInSec;
  
  TimerModel({
    required this.title,
    required this.description,
    required this.timerInSec,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'timerInSec': timerInSec,
    };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
    return TimerModel(
      title: map['title'] as String,
      description: map['description'] as String,
      timerInSec: map['timerInSec'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimerModel.fromJson(String source) => TimerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
