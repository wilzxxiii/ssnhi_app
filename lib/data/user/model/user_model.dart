class MyUserModel {
  final String userId;
  final String email;
  final String name;
  final bool emailVerified;

  const MyUserModel(
      {required this.userId,
      required this.email,
      required this.name,
      this.emailVerified = false});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'emailVerified': emailVerified,
      // 'profilePictureUrl': profilePictureUrl,
      // 'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  factory MyUserModel.fromMap(Map<String, dynamic> map) {
    return MyUserModel(
      userId: map['userId'] as String,
      // username: map['username'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      emailVerified: map['emailVerified'] as bool? ?? false,
      // profilePictureUrl: map['profilePictureUrl'] as String?,
      // dateOfBirth: map['dateOfBirth'] != null ? DateTime.parse(map['dateOfBirth']) : null,
    );
  }

  MyUserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return MyUserModel(
        userId: id ?? userId,
        email: email ?? this.email,
        name: name ?? this.name);
  }
}




// class MyUser {
//   final String id;
//   final String email;
//   final String name;

//   const MyUser({
//     required this.id,
//     required this.email,
//     required this.name,
//   });

//   //Unauthenticated user
//   //edit this if new user fields will be added
//   static const empty = MyUser(id: '', email: '', name: '');

// //Modify myUser parameters
//   MyUser copyWith({
//     String? id,
//     String? email,
//     String? name,
//   }) {
//     return MyUser(
//         id: id ?? this.id, email: email ?? this.email, name: name ?? this.name);
//   }

//   //getter if user is empty
//   bool get isEmpty => this == MyUser.empty;

//   //getter if user not empty
//   bool get isNotEmpty => this != MyUser.empty;

//   MyUser toEntity() {
//     return MyUser(
//       id: id,
//       email: email,
//       name: name,
//     );
//   }

//   static MyUser fromEntity(MyUser entity) {
//     return MyUser(id: entity.id, email: entity.email, name: entity.name);
//   }

//   Map<String, Object?> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'name': name,
//     };
//   }

//   static MyUser fromJson(Map<String, dynamic> doc) {
//     return MyUser(
//         id: doc['id'] as String,
//         email: doc['email'] as String,
//         name: doc['name'] as String);
//   }

//   // @override
//   // String toString() {
//   //   return '''UserEntity:{
//   //   id: $id,
//   //   name: $name,
//   //   email: $email,
//   // }''';
//   // }

//   //save user state
// }
