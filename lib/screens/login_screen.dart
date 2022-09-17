import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login/exceptions/api_exception.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/styles/text_styles.dart';
import 'package:login/utils/input_validator.dart';
import 'package:login/utils/show_snackbar_message.dart';
import 'package:login/widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenController();
}

class _LoginScreenController extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> inputs = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };
  bool isSubmitting = false;

  void handleTapRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  Future<void> handleSubmit() async {
    if(formKey.currentState == null) {
      return;
    }

    if(!formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      await AuthService.instance.login(inputs['email']?.text ?? '', inputs['password']?.text ?? '');
     
      if(!mounted) return;

      Navigator.of(context).pushReplacementNamed('/');
    } on ApiException catch (e) {

      if(e.response != null && e.response!.body.containsKey('message')) {
        showSnackBarMessage(context, e.message);
      }

      inputs['password']?.text = '';
    } catch(e) {
      showSnackBarMessage(context, 'Ocorreu um erro ao realizar o login.');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _LoginScreenView(this, key: const Key('login_screen_view'));
  }

  @override
  void dispose() {
    inputs.forEach((key, input) {
      input.dispose();
    });

    super.dispose();
  }
}

class _LoginScreenView extends StatelessWidget {
  final _LoginScreenController state;

  const _LoginScreenView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: state.formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Entre na sua conta',
                  style: TextStyles.heading5,
                ),
                TextFormField(
                  controller: state.inputs['email'],
                  decoration: const InputDecoration(label: Text('E-mail')),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.emailAddress(
                    value: value,
                    fieldName: 'E-mail',
                    options: InputValidatorOptions(isRequired: true),
                  ),
                ),
                TextFormField(
                  controller: state.inputs['password'],
                  decoration: const InputDecoration(label: Text('Senha')),
                  obscureText: true,
                  validator: (value) => InputValidator.textInput(
                    value: value,
                    fieldName: 'Senha',
                    options: InputValidatorOptions(isRequired: true),
                  ),
                ),
                const SizedBox(height: 16),
                SubmitButton(
                  onPressed: state.handleSubmit,
                  isLoading: state.isSubmitting,
                  label: 'Entrar',
                ),
                TextButton(
                  onPressed: state.handleTapRegister,
                  child: const Text(
                    'Criar uma conta',
                    style: TextStyles.md,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
