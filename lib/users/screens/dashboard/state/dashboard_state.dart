import 'package:june/june.dart';

class DashboardState extends JuneState {
  bool moonDashboard = true;
  bool moonForId = false;
  bool moonForJo = false;
  bool moonForItreport = false;

  void showMoonDashboard() {
    moonDashboard = true;
    moonForId = false;
    moonForJo = false;
    moonForItreport = false;
    setState();
  }

  void showMoonForId() {
    moonForId = true;
    moonDashboard = false;
    moonForJo = false;
    moonForItreport = false;
    setState();
  }

  void showMoonForJo() {
    moonForJo = true;
    moonDashboard = false;
    moonForId = false;
    moonForItreport = false;
    setState();
  }

  void showMoonForItReport() {
    moonForItreport = true;
    moonDashboard = false;
    moonForJo = false;
    moonForId = false;
    setState();
  }
}
