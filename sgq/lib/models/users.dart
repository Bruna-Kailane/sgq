class Users {
  final String id;
  final String name;
  final String password;
  final String email;
  final String userTypeId;
  final String areaId;

  Users(
      {required this.id,
      required this.name,
      required this.password,
      required this.email,
      required this.userTypeId,
      required this.areaId});

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        password = json['password'],
        email = json['email'],
        userTypeId = json['userTypeId'],
        areaId = json['areaId'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'userTypeId': userTypeId,
      'areaId': areaId,
    };
  }

  Users copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? userTypeId,
    String? areaId,
  }) =>
      Users(
          id: id ?? this.id,
          name: name ?? this.name,
          password: password ?? this.password,
          email: email ?? this.email,
          userTypeId: userTypeId ?? this.userTypeId,
          areaId: areaId ?? this.areaId);
}
