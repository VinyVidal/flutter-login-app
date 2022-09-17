import 'package:flutter/material.dart';
import 'package:login/exceptions/api_exception.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/services/user_service.dart';
import 'package:login/styles/text_styles.dart';
import 'package:login/utils/input_validator.dart';
import 'package:login/utils/show_snackbar_message.dart';
import 'package:login/widgets/submit_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenController();
}

class _RegisterScreenController extends State<RegisterScreen> {
  bool isSubmitting = false;

  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> inputs = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'password_confirmation': TextEditingController(),
  };

  void handleTapLogin() {
    Navigator.of(context).pop();
  }

  Future<void> handleSubmit() async {
    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      await UserService.instance.createUser(
        name: inputs['name']!.text,
        email: inputs['email']!.text,
        password: inputs['password']!.text,
        passwordConfirmation: inputs['password_confirmation']!.text,
      );

      await AuthService.instance.login(inputs['email']!.text, inputs['password']!.text);

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed('/');
    } on ApiException catch (e) {
      if (e.response != null && e.response!.body.containsKey('message')) {
        showSnackBarMessage(context, e.message);
      }
    } catch (e) {
      showSnackBarMessage(context, 'Ocorreu um erro ao realizar o registro.');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RegisterScreenView(this, key: const Key('login_screen_view'));
  }

  @override
  void dispose() {
    inputs.forEach((key, input) {
      input.dispose();
    });

    super.dispose();
  }
}

class _RegisterScreenView extends StatelessWidget {
  final _RegisterScreenController state;

  const _RegisterScreenView(this.state, {super.key});

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
                  'Crie a sua conta',
                  style: TextStyles.heading5,
                ),
                TextFormField(
                  controller: state.inputs['name'],
                  decoration: const InputDecoration(label: Text('Nome completo')),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.textInput(
                    value: value,
                    fieldName: 'Nome completo',
                    options: InputValidatorOptions(isRequired: true, minLength: 3),
                  ),
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
                    options: InputValidatorOptions(isRequired: true, minLength: 3),
                  ),
                ),
                TextFormField(
                  controller: state.inputs['password_confirmation'],
                  decoration: const InputDecoration(label: Text('Confirmar Senha')),
                  obscureText: true,
                  validator: (value) => InputValidator.confirmation(
                    originalValue: state.inputs['password']?.text,
                    confirmationValue: value,
                    fieldName: 'Senhas',
                  ),
                ),
                const SizedBox(height: 16),
                SubmitButton(
                  onPressed: state.handleSubmit,
                  isLoading: state.isSubmitting,
                  label: 'Cadastrar',
                ),
                TextButton(
                  onPressed: state.handleTapLogin,
                  child: const Text(
                    'Já possui uma conta? Entrar',
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
