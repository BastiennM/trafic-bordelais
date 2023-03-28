import 'package:flutter/material.dart';
import 'package:trafic_bordeaux/core/constants/enums.dart';

import 'authentication.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authentication(authType: AuthType.register);
  }
}
