import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/viewmodels/auth/register_viewmodel.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    return Container(
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
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    SizedBox(height: 10.h,),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    SizedBox(height: 10.h,),
                    SizedBox(height: 10.h,),
                    TextFormField(
                      controller: _contactController,
                      decoration: const InputDecoration(labelText: 'Contact No'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your contact No' : null,
                    ),
                    SizedBox(height: 10.h,),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your address' : null,
                    ),
                    SizedBox(height: 30.h,),
                    if(registerState.isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              ref.read(registerProvider.notifier).register(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  contactNo: _contactController.text,
                                  address: _addressController.text
                              );
                            }
                          },
                          child: ReusableText(text: 'R E G I S T E R', style: appStyle(12.sp, kWhite, FontWeight.w600))
                      ),
                    if(registerState.error != null)
                      ReusableText(text: registerState.error.toString(), style: appStyle(12.sp, kRed, FontWeight.w400)),
                    if(registerState.isSuccess)
                      ReusableText(text: 'Registration Successful', style: appStyle(12.sp, kPrimary, FontWeight.w400)),

                    SizedBox(height:20.h),
                    GestureDetector(
                      onTap: () => context.pushReplacementNamed('login'),
                      child: ReusableText(text: 'Login', style: appStyle(12.sp, kPrimary, FontWeight.w400)),
                    )

                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
