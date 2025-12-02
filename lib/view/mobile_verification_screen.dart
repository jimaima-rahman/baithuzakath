import 'package:baithuzakath_app/core/app_theme.dart';
import 'package:baithuzakath_app/core/utils/responsive.dart';
import 'package:baithuzakath_app/view/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({super.key});

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Baithuzakath",
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(color: AppTheme.goldYellow),
                    ),
                    SizedBox(height: R.sh(10, context)),
                    Text(
                      'Enter your mobile number',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: R.sh(20, context)),

                    TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.length != 10) {
                          return "Enter valid 10-digit number";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: R.sh(20, context)),

                    ElevatedButton(
                      onPressed: otpProvider.isSendingOtp
                          ? null
                          : () async {
                              final success = await otpProvider.sendOtp(
                                _phoneCtrl.text,
                              );
                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OtpScreen(phone: _phoneCtrl.text),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      otpProvider.sendOtpError ?? 'Error',
                                    ),
                                  ),
                                );
                              }
                            },
                      child: otpProvider.isSendingOtp
                          ? CircularProgressIndicator()
                          : Text('Send OTP'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
