import 'dart:convert';

FoodJoke foodJokeFromJson(String str) => FoodJoke.fromJson(json.decode(str));

String foodJokeToJson(FoodJoke data) => json.encode(data.toJson());

class FoodJoke {
  final String text;

  FoodJoke({required this.text});

  factory FoodJoke.fromJson(Map<String, dynamic> json) => FoodJoke(
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
