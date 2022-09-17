import 'package:flutter/material.dart';
import 'package:login/models/user_model.dart';

class StaticData {
  static StaticData instance = StaticData();

  ValueNotifier<UserModel?> user = ValueNotifier(null);
}
