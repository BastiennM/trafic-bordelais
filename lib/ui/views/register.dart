import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';

import 'authentication.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authentication(authType: AuthType.register);
  }
}
