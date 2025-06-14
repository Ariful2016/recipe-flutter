import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/edit_text/custom_text_field.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

import '../../di/auth/auth_provider.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/dialog/custom_alert_dialog.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: ReusableText(
                text: 'Login Successful',
                style: appStyle(12.sp, kWhite, FontWeight.w400)),
            backgroundColor: kPrimary,
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            context.goNamed('home');
          }
        });
      }else if(next.error != null){
        showCustomAlertDialog(
          context,
          type: AlertType.error,
          title: 'Error',
          message: next.error.toString(),
          primaryButtonText: 'Retry',
          secondaryButtonText: 'Cancel',
          primaryButtonAction: ()  {
            _login();
          },
          secondaryButtonAction: ()=> Navigator.of(context).pop()
        );
      }
    });

    return Scaffold(
      backgroundColor: kOffWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image-2.png',
                  width: 150.w,
                  height: 150.w,
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        labelText: emailLevelText,
                        hintText: emailHintText,
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return emailEmptyText;
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return emailNotMatchedText;
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: passwordLevelText,
                        hintText: passwordHintText,
                        icon: Icons.lock,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return passwordEmptyText;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      if (loginState.isLoading)
                        const CircularProgressIndicator()
                      else
                        CustomButton(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          text: 'L O G I N',
                        ),
                      if (loginState.error != null)
                        ReusableText(
                          text: loginState.error.toString(),
                          style: appStyle(12.sp, kRed, FontWeight.w400),
                        ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: () => context.pushReplacementNamed('register'),
                        child: ReusableText(
                          text: 'Register',
                          style: appStyle(12.sp, kPrimary, FontWeight.w400),
                        ),
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

  void _login() {
    ref.read(loginProvider.notifier).login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

}