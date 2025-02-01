import 'package:june/june.dart';

class AppState extends JuneState {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    setState();
  }

  void stopLoading() {
    _isLoading = false;
    setState();
  }
}
