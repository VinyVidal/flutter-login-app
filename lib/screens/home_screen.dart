import 'package:flutter/material.dart';
import 'package:login/core/static_data.dart';
import 'package:login/exceptions/api_exception.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/utils/show_snackbar_message.dart';
import 'package:login/widgets/loading_widget.dart';
import 'package:login/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenController();
}

class _HomeScreenController extends State<HomeScreen> {
  bool isLoading = true;
  UserModel? user;

  Future<void> handleTapLogout() async {
    try {
      await AuthService.instance.logout();

      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } on ApiException catch (e) {
      showSnackBarMessage(context, e.message);
    } catch (e) {
      showSnackBarMessage(context, 'Ocorreu um erro desconhecido.');
    }
  }

  userListener() {
    setState(() {
      user = StaticData.instance.user.value;
    });
  }

  @override
  void initState() {
    super.initState();

    userListener();
    StaticData.instance.user.addListener(userListener);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    StaticData.instance.user.removeListener(userListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomeScreenView(this, key: const Key('home_screen_view'));
  }
}

class _HomeScreenView extends StatelessWidget {
  final _HomeScreenController state;

  const _HomeScreenView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return state.isLoading
        ? const Scaffold(
            body: LoadingWidget(),
          )
        : Scaffold(
            body: const Center(
              child: Text("Home"),
            ),
            appBar: AppBar(),
            drawer: MainDrawer(
              onLogout: state.handleTapLogout,
              user: state.user,
            ),
          );
  }
}
