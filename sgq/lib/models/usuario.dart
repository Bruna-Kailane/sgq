import 'dart:convert';

class Usuario {
  final String id;
  final String email;
  final String token;
  final DateTime expiraEm;
  Usuario({
    required this.id,
    required this.email,
    required this.token,
    required this.expiraEm,
  });

  Usuario copyWith({
    String? id,
    String? email,
    String? token,
    DateTime? expiraEm,
  }) {
    return Usuario(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      expiraEm: expiraEm ?? this.expiraEm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'expiraEm': expiraEm.millisecondsSinceEpoch,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      email: map['email'],
      token: map['token'],
      expiraEm: DateTime.fromMillisecondsSinceEpoch(map['expiraEm']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(id: $id, email: $email, token: $token, expiraEm: $expiraEm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.email == email &&
        other.token == token &&
        other.expiraEm == expiraEm;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ token.hashCode ^ expiraEm.hashCode;
  }
}
