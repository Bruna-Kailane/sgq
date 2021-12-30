import 'dart:convert';

class Usuario {
  final String id;
  final String email;
  final String senha;
  final String token;
  final DateTime expiraEm;

  Usuario({
    required this.id,
    required this.email,
    required this.senha,
    required this.token,
    required this.expiraEm,
  });

  Usuario copyWith({
    String? id,
    String? email,
    String? senha,
    String? token,
    DateTime? expiraEm,
  }) {
    return Usuario(
      id: id ?? this.id,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      token: token ?? this.token,
      expiraEm: expiraEm ?? this.expiraEm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'senha': senha,
      'token': token,
      'expiraEm': expiraEm.millisecondsSinceEpoch,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      senha: map['senha'] ?? '',
      token: map['token'] ?? '',
      expiraEm: DateTime.fromMillisecondsSinceEpoch(map['expiraEm']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(id: $id, email: $email, senha: $senha, token: $token, expiraEm: $expiraEm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.email == email &&
        other.senha == senha &&
        other.token == token &&
        other.expiraEm == expiraEm;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        senha.hashCode ^
        token.hashCode ^
        expiraEm.hashCode;
  }
}
