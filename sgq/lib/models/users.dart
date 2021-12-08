class Users {
  final int id;
  final String name;
  final String password;
  final String email;
  final int userTypeId;
  final int areaId;

  Users(
      {required this.id,
      required this.name,
      required this.password,
      required this.email,
      required this.userTypeId,
      required this.areaId});
}
