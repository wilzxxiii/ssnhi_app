class ForIdModel {
  final String empNo;
  final String empName;
  final String empDept;
  final String ecName;
  final String ecAdd;
  final String ecPhone;
  final String signature;
  final String status;

  const ForIdModel({
    required this.empNo,
    required this.empName,
    required this.empDept,
    required this.ecName,
    required this.ecAdd,
    required this.ecPhone,
    required this.signature,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'empNo': empNo,
      'empName': empName,
      'empDept': empDept,
      'ecName': ecName,
      'ecAdd': ecAdd,
      'ecPhone': ecPhone,
      'signature': signature,
      'status': status,

      // 'profilePictureUrl': profilePictureUrl,
      // 'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  factory ForIdModel.fromMap(Map<String, dynamic> map) {
    return ForIdModel(
      empNo: map['empNo'] as String,
      // username: map['username'] as String,
      empName: map['empName'] as String,
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
    String? empName,
    String? empDept,
    String? ecName,
    String? ecAdd,
    String? ecPhone,
    String? signature,
    String? status,
  }) {
    return ForIdModel(
      empNo: empNo ?? this.empNo,
      empName: empName ?? this.empName,
      empDept: empDept ?? this.empDept,
      ecName: ecName ?? this.ecName,
      ecAdd: ecAdd ?? this.ecAdd,
      ecPhone: ecPhone ?? this.ecPhone,
      signature: signature ?? this.signature,
      status: status ?? this.status,
    );
  }
}
