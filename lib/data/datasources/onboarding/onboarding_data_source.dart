import 'package:flutter/material.dart';

import '../../models/onboarding/onboarding_data_model.dart';

final data = [
  ItemData(
    title: "SEND MESSAGES",
    subtitle: "Send messages to your friends and family. ",
    image: const AssetImage("assets/image-2.png"),
    backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
    titleColor: Colors.amber,
    subtitleColor: Colors.white,

  ),
  ItemData(
    title: "CREATE GROUPS",
    subtitle: "Connent with your friends through groups.",
    image: const AssetImage("assets/image-3.png"),
    backgroundColor: Colors.white,
    titleColor: Colors.purple,
    subtitleColor: const Color.fromRGBO(0, 10, 56, 1),

  ),
  ItemData(
    title: "BE PRODUCTIVE",
    subtitle: "Get work done with your friends and be productive.",
    image: const AssetImage("assets/image-4.png"),
    backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
    titleColor: Colors.orange.shade600,
    subtitleColor: Colors.white,

  ),
  ItemData(
    title: "ADVANCE MESSAGING",
    subtitle: "Use advanced messaging features to get more out our app.",
    image: const AssetImage("assets/image-1.png"),
    backgroundColor: Colors.white,
    titleColor: Colors.red.shade400,
    subtitleColor: Colors.black,

  ),
];