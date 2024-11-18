import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
  });

  //Unauthenticated user
  //edit this if new user fields will be added
  static const empty = MyUser(id: '', email: '', name: '');

//Modify myUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return MyUser(
        id: id ?? this.id, email: email ?? this.email, name: name ?? this.name);
  }

  //getter if user is empty
  bool get isEmpty => this == MyUser.empty;

  //getter if user not empty
  bool get isNotEmpty => this != MyUser.empty;

  @override
  List<Object?> get props => [id, email, name];

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(id: entity.id, email: entity.email, name: entity.name);
  }
}
