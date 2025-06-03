
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/viewmodels/auth/login_viewmodel.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class LoginScreen extends ConsumerWidget{
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image-2.png', width: 150.w, height: 150.w,),
            SizedBox(height: 20.h,),
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                       value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    SizedBox(height: 10.h,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    SizedBox(height: 30.h,),
                    if(loginState.isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              ref.read(loginProvider.notifier).login(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              );
                            }

                          },
                          child: ReusableText(text: 'L O G I N', style: appStyle(12.sp, kPrimary, FontWeight.w600))
                      ),
                    if(loginState.error != null)
                      ReusableText(text: loginState.error.toString(), style: appStyle(12.sp, kRed, FontWeight.w400)),
                    if(loginState.isSuccess)
                      ReusableText(text: 'Login Successful', style: appStyle(12.sp, kPrimary, FontWeight.w400)),
                    SizedBox(height: 30.h,),
                    GestureDetector(
                      onTap: () => context.pushReplacementNamed('home'),
                      child:  ReusableText(text: 'Home', style: appStyle(12.sp, kPrimary, FontWeight.w400)),
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