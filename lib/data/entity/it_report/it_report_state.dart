import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/data/entity/it_report/it_report_db_service.dart';
import 'package:ssnhi_app/data/entity/it_report/it_report_model.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';

class ItReportState extends JuneState {
  String id = '';
  String dateReported = '';
  String timeReported = '';
  String reporterName = '';
  String reporterDept = '';
  String signature = '';
  String errorMsg = '';
  String errorType = '';
  String workPerformed = '';
  String recommendation = '';
  String checkedBy = '';
  String notedBy = '';

  ItReportModel? _itReportModel;

  ItReportModel? get itReportModel => _itReportModel;

  final dbForItReportForm = ItReportDbService();
  final loading = LoadingScreen();

  // Firestore list-related state (from ForIdState)
  List<ItReportModel> itReportList = [];
  bool isLoading = true;
  String? errorMessage;

//Call me motherfucker
  ItReportState() {
    _initFirestoreListener();
  }

  // Initialize Firestore stream listener (from ForIdState)
  void _initFirestoreListener() {
    dbForItReportForm.getAllForIDsStream().listen(
      (list) {
        itReportList = list;
        isLoading = false;
        errorMessage = null;
        setState();
      },
      onError: (error) {
        isLoading = false;
        errorMessage = error.toString();
        setState();
      },
      onDone: () {
        isLoading = false;
        setState();
      },
    );
  }
}
