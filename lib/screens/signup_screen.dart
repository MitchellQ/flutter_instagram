import 'package:flutter/material.dart';
import 'package:flutter_instagram/forms/signup_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //Svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 24),

              const SignUpForm(),

              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
