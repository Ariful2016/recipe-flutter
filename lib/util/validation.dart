

import 'package:recipe_flutter/core/constants/constants.dart';

String? validateContactNo(String? value) {
  if (value == null || value.isEmpty) {
    return contactHintText;
  }

  // Check for exactly 11 digits
  if (!RegExp(r'^\d{11}$').hasMatch(value)) {
    return contactNotMatchedText;
  }

  // Check for valid prefixes
  if (!RegExp(r'^(013|015|016|017|018|019)\d{8}$').hasMatch(value)) {
    return contactNotMatchedText;
  }

  return null;
}