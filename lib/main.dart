import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/services/api_service.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiService()),
        ],
        child: const App(),
      ),
    ),
  );
}

