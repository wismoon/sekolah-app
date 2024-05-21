import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_users_controller.dart';

class AuthUsersView extends GetView<AuthUsersController> {
  const AuthUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthUsersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AuthUsersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
