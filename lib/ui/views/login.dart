import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'authentication.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authentication(authType: AuthType.login);
  }
}
