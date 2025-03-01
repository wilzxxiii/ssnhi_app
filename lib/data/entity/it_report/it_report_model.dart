class ItReportModel {
  final String id;
  final String dateReported;
  final String timeReported;
  final String reporterName;
  final String reporterDept;
  final String signature;
  final String errorMsg;
  final String errorType;
  final String workPerformed;
  final String recommendation;
  final String checkedBy;
  final String notedBy;

  const ItReportModel({
    required this.id,
    required this.dateReported,
    required this.timeReported,
    required this.reporterName,
    required this.reporterDept,
    required this.signature,
    required this.errorMsg,
    required this.errorType,
    required this.workPerformed,
    required this.recommendation,
    required this.checkedBy,
    required this.notedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateReported': dateReported,
      'timeReported': timeReported,
      'reporterName': reporterName,
      'reportedDept': reporterDept,
      'signature': signature,
      'errorMsg': errorMsg,
      'errorType': errorType,
      'workPerformed': workPerformed,
      'recommendation': recommendation,
      'checkedBy': checkedBy,
      'notedBy': notedBy,

      // 'profilePictureUrl': profilePictureUrl,
      // 'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  factory ItReportModel.fromMap(Map<String, dynamic> map) {
    return ItReportModel(
      id: map['id'] as String,
      dateReported: map['dateReported'] as String,
      timeReported: map['timeReported'] as String,
      reporterName: map['reporterName'] as String,
      reporterDept: map['reporterDept'] as String,
      signature: map['signature'] as String,
      errorMsg: map['errorMsg'] as String,
      errorType: map['errorType'] as String,
      workPerformed: map['workPerformed'] as String,
      recommendation: map['recommendtation'] as String,
      checkedBy: map['checkedBy'] as String,
      notedBy: map['notedBy'] as String,
    );
  }

  ItReportModel copyWith(
      {String? id,
      String? dateReported,
      String? timeReported,
      String? reporterName,
      String? reporterDept,
      String? signature,
      String? errorMsg,
      String? errorType,
      String? workPerformed,
      String? recommendation,
      String? checkedBy,
      String? notedBy}) {
    return ItReportModel(
        id: id ?? this.id,
        dateReported: dateReported ?? this.dateReported,
        timeReported: timeReported ?? this.timeReported,
        reporterName: reporterName ?? this.reporterName,
        reporterDept: reporterDept ?? this.reporterName,
        signature: signature ?? this.signature,
        errorMsg: errorMsg ?? this.errorMsg,
        errorType: errorType ?? this.errorType,
        workPerformed: workPerformed ?? this.workPerformed,
        recommendation: recommendation ?? this.recommendation,
        checkedBy: checkedBy ?? this.checkedBy,
        notedBy: notedBy ?? this.notedBy);
  }
}
