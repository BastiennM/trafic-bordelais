import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';
import 'authentication.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authentication(authType: AuthType.login);
  }
}
