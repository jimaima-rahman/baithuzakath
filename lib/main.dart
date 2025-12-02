import 'package:baithuzakath_app/core/app_theme.dart';
import 'package:baithuzakath_app/providers/auth_provider.dart';
import 'package:baithuzakath_app/providers/scheme_provider.dart';
import 'package:baithuzakath_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => SchemeProvider()),
        // ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        home: SplashScreen(),
      ),
    );
  }
}
