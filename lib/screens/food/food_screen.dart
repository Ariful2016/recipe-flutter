import 'package:flutter/cupertino.dart';
import 'package:recipe_flutter/core/constants/constants.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLight,
    );
  }
}
