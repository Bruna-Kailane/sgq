class UserType {
  final int id;
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
}
