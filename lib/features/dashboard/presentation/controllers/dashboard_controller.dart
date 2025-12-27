import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardController extends Notifier<int> {
  @override
  int build() {
    return 0; // Initial index
  }

  void setIndex(int index) {
    state = index;
  }
}

final dashboardControllerProvider = NotifierProvider<DashboardController, int>(() {
  return DashboardController();
});
