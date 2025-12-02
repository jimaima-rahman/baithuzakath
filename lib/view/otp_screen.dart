import 'package:baithuzakath_app/core/app_theme.dart';
import 'package:baithuzakath_app/core/utils/responsive.dart';
import 'package:baithuzakath_app/view/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({required this.phone, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.darkGreen,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(R.sw(20, context)),
            ),
            width: double.infinity,
            height: R.sh(300, context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Baithuzakath",
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(color: AppTheme.goldYellow),
                      ),
                      SizedBox(height: R.sh(20, context)),
                      Text(
                        'OTP sent to ${widget.phone}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextField(
                        controller: _otpCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'OTP'),
                      ),
                      SizedBox(height: R.sh(20, context)),
                      ElevatedButton(
                        onPressed: otpProvider.isVerifyingOtp
                            ? null
                            : () async {
                                final success = await otpProvider.verifyOtp(
                                  widget.phone,
                                  _otpCtrl.text,
                                );
                                if (success) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const NavigationBarPage(),
                                    ),
                                  );
                                  print('Token: ${otpProvider.userToken}');
                                  print('User: ${otpProvider.userData?.name}');
                                } else {
                                  // Show error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        otpProvider.verifyOtpError ?? 'Error',
                                      ),
                                    ),
                                  );
                                }
                              },
                        child: otpProvider.isVerifyingOtp
                            ? CircularProgressIndicator()
                            : Text('Verify OTP'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
