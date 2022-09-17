import 'package:flutter/material.dart';

abstract class Middleware {
  /// If false is returned, the redirect() method will be called
  Future<bool> handle();

  void redirect(BuildContext context);
}