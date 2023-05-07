import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../view_models/otp_auth_view_model.dart';
import 'otp_code_screen.dart';

class OtpPhoneNumberView extends StatefulWidget {
  const OtpPhoneNumberView({Key? key}) : super(key: key);

  @override
  State<OtpPhoneNumberView> createState() => _OtpPhoneNumberViewState();
}

class _OtpPhoneNumberViewState extends State<OtpPhoneNumberView> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String countryCode = '+91';
  String verificationId = '';

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            // Stack(
            //   children: [
            //     Align(
            //       alignment: Alignment.centerLeft,
            //       child: Image.asset('assets/images/phone_left.png'),
            //     ),
            //     Align(
            //       alignment: Alignment.centerRight,
            //       child: Image.asset('assets/images/phone_right.png'),
            //     )
            //   ],
            // ),
            const Text(
              "Enter your Phone Number",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: IntlPhoneField(
                controller: _phoneNumberController,
                onCountryChanged: (country) {
                  setState(() {
                    countryCode = '+${country.dialCode}';
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
                initialCountryCode: 'IN',
                initialValue: countryCode,
                onChanged: (phone) {
                  debugPrint(phone.completeNumber);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<OtpAuthViewModel>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 10),
            child: FloatingActionButton(
              onPressed: () async {
                verificationId = (await value.verifyPhoneNumber(
                    countryCode + _phoneNumberController.text))!;
                log(countryCode + _phoneNumberController.text);
                if (value.isLoading == false) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OtpCodeScreen(
                        countryCode: countryCode,
                        phoneNumber: _phoneNumberController.text,
                      ),
                    ),
                  );
                }
              },
              backgroundColor: Colors.orange,
              child: value.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
