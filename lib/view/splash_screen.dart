// import 'dart:async';

// import 'package:baithuzakath_app/view/dash_board_screen.dart';
// import 'package:baithuzakath_app/view/mobile_verification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), _goNext);
//   }

//   void _goNext() {
//     final auth = Provider.of<AuthProvider>(context, listen: false);
//     if (auth.user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const DashboardScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const MobileVerificationScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Image.asset('assets/images/bz.png')));
//   }
// }

import 'dart:async';

import 'package:baithuzakath_app/providers/auth_provider.dart';
import 'package:baithuzakath_app/view/bottom_navigation_bar.dart';
import 'package:baithuzakath_app/view/mobile_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), _goNext);
//   }

//   void _goNext() async {
//     final otpProvider = Provider.of<OtpProvider>(context, listen: false);

//     // Check if user is logged in by checking stored token
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('user_token');

//     if (mounted) {
//       if (token != null && token.isNotEmpty) {
//         // User is logged in, navigate to dashboard
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const DashboardScreen()),
//         );
//       } else {
//         // User is not logged in, navigate to login
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const MobileVerificationScreen()),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('assets/images/bz.png'),
//       ),
//     );
//   }
// }

// Alternative approach using OtpProvider directly:
//
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _goNext);
  }

  void _goNext() {
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);

    if (otpProvider.userData != null && otpProvider.userToken != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavigationBarPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MobileVerificationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/images/bz.png')));
  }
}
