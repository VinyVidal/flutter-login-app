import 'package:flutter/material.dart';
import 'package:login/core/middleware.dart';
import 'package:login/widgets/loading_widget.dart';

class ProtectedRoute extends StatefulWidget {
  final Widget screen;
  final List<Middleware> middlewares;

  const ProtectedRoute({super.key, required this.screen, required this.middlewares});

  @override
  State<ProtectedRoute> createState() => _ProtectedRouteController();
}

class _ProtectedRouteController extends State<ProtectedRoute> {
  bool isVerifying = true;

  _ProtectedRouteController();

  Future<bool> resolveMiddlewares() async {
    for (Middleware middleware in widget.middlewares) {
      bool passed = await middleware.handle();
      if (!passed) {
        if (mounted) {
          middleware.redirect(context);
        }
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    resolveMiddlewares().then((passed) {
      if (passed) {
        setState(() => isVerifying = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) => _ProtectedRouteView(
        this,
        key: const Key('protected_route_view'),
      );
}

class _ProtectedRouteView extends StatelessWidget {
  final _ProtectedRouteController state;
  const _ProtectedRouteView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: state.isVerifying ? const LoadingWidget() : state.widget.screen,
    );
  }
}
