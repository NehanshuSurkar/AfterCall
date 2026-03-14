import 'package:after_call/navigation/nav.dart';
import 'package:after_call/sevices/audio_service.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:after_call/sevices/call_record_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CallRecordService()),
        ChangeNotifierProvider(create: (_) => AudioService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AfterCall',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.createRouter(context.read<AuthService>()),
    );
  }
}
