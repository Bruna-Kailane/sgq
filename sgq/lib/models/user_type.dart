class UserType {
  final String id;
  final String name;
  final String description;

  UserType({required this.id, required this.name, required this.description});

  UserType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  UserType opyWith({
    String? id,
    String? name,
    String? description,
  }) =>
      UserType(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description);
}
