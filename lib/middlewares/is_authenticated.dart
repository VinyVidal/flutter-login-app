import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login/core/middleware.dart';
import 'package:login/core/static_data.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/utils/show_snackbar_message.dart';

class IsAuthenticated implements Middleware {
  @override
  Future<bool> handle() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      UserModel user = await AuthService.instance.user();
      
      StaticData.instance.user.value = user;

      return true;
    } catch (e) {
      inspect(e);
      StaticData.instance.user.value = null;

      return false;
    }
  }

  @override
  void redirect(BuildContext context) {
    showSnackBarMessage(context, 'Erro ao conectar-se com o servidor, tente novamente mais tarde!');
    Navigator.of(context).pushReplacementNamed('/login');
  }
}

class IsAuthenticatedForwardedData {
  final UserModel user;

  IsAuthenticatedForwardedData({required this.user});
}
