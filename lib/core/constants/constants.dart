import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
 * Created on 12/03/2025
 * Created by Ariful Islam
 */
const kPrimary = Color(0xFF004191);
const kPrimaryDark = Color(0xFF00306A);
const kPrimaryLight = Color(0xFF0055BF);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kTextColor = Color(0xff343A40);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

double height = 805.33.h;
double width = 384.w;

final String baseUrl = "https://api.spoonacular.com";
final String apiKey = "245be2a9286344a7a11da5277ccb70a3";
String baseUrlWeb = "";
String versionName = "";
String authorization = "";
String bearer = "Bearer";
String? ipAddress = "";
String deviceInfo = "";
String secureId = "";


String url = 'https://www.shakti.org.bd/';
final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
final passwordRegex = RegExp(
  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$',
);


//name input text
final nameLevelText = 'Name';
final nameHintText = 'Enter your name';
final nameEmptyText = 'Please enter your name';
final nameLimitText = 'Please enter your name within 100 characters';

//email input text
final emailLevelText = 'Email';
final emailHintText = 'Enter your email';
final emailEmptyText = 'Please enter your email';
final emailNotMatchedText = 'Please enter a valid email';

//password input text
final passwordLevelText = 'Password';
final passwordHintText = 'Enter your password';
final passwordEmptyText = 'Please enter your password';
final passwordNotMatchedText = 'Password must be at least 6 characters, with one uppercase, one lowercase, one digit, and one special character';

//contact input text
final contactLevelText = 'Contact No';
final contactHintText = 'Enter your contact No';
final contactEmptyText = 'Please enter your contact No';
final contactNotMatchedText = 'Please enter a valid contact No';

//address input text
final addressLevelText = 'Address';
final addressHintText = 'Enter your address';
final addressEmptyText = 'Please enter your address';