class ForIdModel {
  final String id;
  final String empNo;
  final String empName;
  final String empDept;
  final String ecName;
  final String ecAdd;
  final String ecPhone;
  final String signature;
  final String position;
  final String status;

  const ForIdModel({
    required this.id,
    required this.empNo,
    required this.empName,
    required this.empDept,
    required this.ecName,
    required this.position,
    required this.ecAdd,
    required this.ecPhone,
    required this.signature,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'empNo': empNo,
      'id': id,
      'empName': empName,
      'empDept': empDept,
      'ecName': ecName,
      'ecAdd': ecAdd,
      'ecPhone': ecPhone,
      'signature': signature,
      'position': position,
      'status': status,

      // 'profilePictureUrl': profilePictureUrl,
      // 'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  factory ForIdModel.fromMap(Map<String, dynamic> map) {
    return ForIdModel(
      empNo: map['empNo'] as String,
      id: map['id'] as String,
      empName: map['empName'] as String,
      position: map['position'] as String,
      empDept: map['empDept'] as String,
      ecName: map['ecName'] as String,
      ecAdd: map['ecAdd'] as String,
      ecPhone: map['ecPhone'] as String,
      signature: map['signature'] as String,
      status: map['status'] as String,

      // emailVerified: map['emailVerified'] as bool? ?? false,
      // profilePictureUrl: map['profilePictureUrl'] as String?,
      // dateOfBirth: map['dateOfBirth'] != null ? DateTime.parse(map['dateOfBirth']) : null,
    );
  }

  ForIdModel copyWith({
    String? empNo,
    String? id,
    String? empName,
    String? empDept,
    String? ecName,
    String? ecAdd,
    String? ecPhone,
    String? signature,
    String? status,
    String? position,
    String? docId,
  }) {
    return ForIdModel(
      id: id ?? this.id,
      empNo: empNo ?? this.empNo,
      empName: empName ?? this.empName,
      empDept: empDept ?? this.empDept,
      ecName: ecName ?? this.ecName,
      ecAdd: ecAdd ?? this.ecAdd,
      ecPhone: ecPhone ?? this.ecPhone,
      signature: signature ?? this.signature,
      status: status ?? this.status,
      position: position ?? this.position,
    );
  }
}
