import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models.dart';
import '../../../../core/data/dummy_data.dart';

class KelasController extends AsyncNotifier<List<ClassModel>> {
  @override
  FutureOr<List<ClassModel>> build() {
    // Return dummy data for now
    return DummyData.classes;
  }

  Future<void> refreshClasses() async {
    state = const AsyncValue.loading();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncValue.data(DummyData.classes);
  }
}

final kelasControllerProvider = AsyncNotifierProvider<KelasController, List<ClassModel>>(() {
  return KelasController();
});
