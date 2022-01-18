class Reserve {
  final String id;
  final String date;
  final String begin;
  final String finish;
  final String description;
  final String authorUserId;
  final String keeperUserId;
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
    String? id,
    String? date,
    String? begin,
    String? finish,
    String? description,
    String? authorUserId,
    String? keeperUserId,
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
