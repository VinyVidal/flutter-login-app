import 'package:flutter/material.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/styles/text_styles.dart';
import 'package:login/utils/show_snackbar_message.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenController();
}

class _SplashScreenController extends State<SplashScreen> {
  final AuthService auth = AuthService.instance;

  @override
  void initState() {
    super.initState();
    auth.isAuthenticated().then((isLogged) {
      if (isLogged) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }).catchError((error) {
      showSnackBarMessage(context, 'Erro de conexão, tente novamente mais tarde');
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SplashScreenView(this, key: const Key('splash_screen_view'));
  }
}

class _SplashScreenView extends StatelessWidget {
  final _SplashScreenController state;

  const _SplashScreenView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.3),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.login_rounded, size: 64.0),
            ),
            const Text('Login App', style: TextStyles.heading4),
          ],
        ),
      ),
    );
  }
}
