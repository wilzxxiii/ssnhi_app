import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  static MyUserEntity fromJson(Map<String, dynamic> doc) {
    return MyUserEntity(
        id: doc['id'] as String,
        email: doc['email'] as String,
        name: doc['name'] as String);
  }

  @override
  List<Object?> get props => [id, email, name];

  @override
  String toString() {
    return '''UserEntity:{
    id: $id,
    name: $name,
    email: $email,
  }''';
  }
}
