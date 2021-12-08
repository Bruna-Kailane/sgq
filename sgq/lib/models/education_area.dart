class EducationArea {
  final int id;
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
}
