import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';
import '../../di/auth/auth_provider.dart';
import '../../util/validation.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/dialog/custom_alert_dialog.dart';
import '../../widgets/edit_text/custom_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);

   /* ref.listen(registerProvider, (previous, next) {
      if (next.isSuccess && previous?.isSuccess != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: ReusableText(
                  text: 'Registration Successful',
                  style: appStyle(12.sp, kWhite, FontWeight.w400)),
              backgroundColor: kPrimary,
              duration: const Duration(seconds: 2)),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            context.goNamed('login');
          }
        });
      }
    });*/

    ref.listen(registerProvider, (previous, next) {
      if (next.isSuccess) {
        showCustomAlertDialog(
          context,
          type: AlertType.success,
          title: 'Success',
          message: 'Registration successful!',
          primaryButtonAction: () {
            Navigator.of(context).pop();
            context.goNamed('login');
          },
        );
      } else if (next.error != null) {
        showCustomAlertDialog(
          context,
          type: AlertType.error,
          title: 'Error',
          message: next.error.toString(),
          primaryButtonText: 'Retry',
          secondaryButtonText: 'Cancel',
          primaryButtonAction: () {
            _register();
          },
          secondaryButtonAction: () => Navigator.of(context).pop()
        );
      }
    });

    return Scaffold(
      backgroundColor: kOffWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image-1.png',
                  width: 150.w,
                  height: 150.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          labelText: nameLevelText,
                          hintText: nameHintText,
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return nameEmptyText;
                            }
                            if (value.length > 100) {
                              return nameLevelText;
                            }
                            return null;
                          },
                        ),
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
                            if (!passwordRegex.hasMatch(value)) {
                              return passwordNotMatchedText;
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                            controller: _contactController,
                            labelText: contactLevelText,
                            hintText: contactHintText,
                            icon: Icons.phone,
                            keyboardType: TextInputType.number,
                            validator: (value) => validateContactNo(value)),
                        CustomTextField(
                          controller: _addressController,
                          labelText: addressLevelText,
                          hintText: addressHintText,
                          icon: Icons.location_on,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return addressEmptyText;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        if (registerState.isLoading)
                          const CircularProgressIndicator()
                        else
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _register();
                              }
                            },
                            text: 'R E G I S T E R',
                          ),
                        if (registerState.error != null)
                          ReusableText(
                              text: registerState.error.toString(),
                              style: appStyle(12.sp, kRed, FontWeight.w400)),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () => context.pushReplacementNamed('login'),
                          child: ReusableText(
                              text: 'Login',
                              style:
                                  appStyle(12.sp, kPrimary, FontWeight.w400)),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    ref.read(registerProvider.notifier).register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        contactNo: _contactController.text,
        address: _addressController.text);
  }
}
