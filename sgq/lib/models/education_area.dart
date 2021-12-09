class EducationArea {
  final String id;
  final String name;

  EducationArea({required this.id, required this.name});

  EducationArea.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  EducationArea copyWith({
    String? id,
    String? name,
  }) =>
      EducationArea(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
