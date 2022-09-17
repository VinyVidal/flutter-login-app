import 'package:flutter/material.dart';
import 'package:login/models/user_model.dart';

class MainDrawer extends StatelessWidget {
  final void Function()? onLogout;
  final UserModel? user;

  const MainDrawer({super.key, this.onLogout, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Icon(
                    Icons.account_circle,
                    size: 96,
                    color: Colors.blueGrey.shade200,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  user?.name ?? 'Usuário',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          const Divider(thickness: 4),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
