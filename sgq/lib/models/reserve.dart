import 'package:flutter/material.dart';

class Reserve {
  final int id;
  final DateTime date;
  final TimeOfDay begin;
  final TimeOfDay finish;
  final String description;
  final int authorUserId;
  final int keeperUserId;
  final int keeperStatus;
  final int reserveStatus;
  final int repeat;

  Reserve(
      {required this.id,
      required this.date,
      required this.begin,
      required this.finish,
      required this.description,
      required this.authorUserId,
      required this.keeperUserId,
      required this.keeperStatus,
      required this.reserveStatus,
      required this.repeat});

  Reserve.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        begin = json['begin'],
        finish = json['finish'],
        description = json['description'],
        authorUserId = json['authorUserId'],
        keeperUserId = json['keeperUserId'],
        keeperStatus = json['keeperStatus'],
        reserveStatus = json['reserveStatus'],
        repeat = json['repeat'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'begin': begin,
      'finish': finish,
      'description': description,
      'authorUserId': authorUserId,
      'keeperUserId': keeperUserId,
      'keeperStatus': keeperStatus,
      'reserveStatus': reserveStatus,
      'repeat': repeat
    };
  }

  Reserve copyWith({
    int? id,
    DateTime? date,
    TimeOfDay? begin,
    TimeOfDay? finish,
    String? description,
    int? authorUserId,
    int? keeperUserId,
    int? keeperStatus,
    int? reserveStatus,
    int? repeat,
  }) =>
      Reserve(
          id: id ?? this.id,
          date: date ?? this.date,
          begin: begin ?? this.begin,
          finish: finish ?? this.finish,
          description: description ?? this.description,
          authorUserId: authorUserId ?? this.authorUserId,
          keeperUserId: keeperUserId ?? this.keeperUserId,
          keeperStatus: keeperStatus ?? this.keeperStatus,
          reserveStatus: reserveStatus ?? this.reserveStatus,
          repeat: repeat ?? this.repeat);
}
