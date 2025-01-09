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
