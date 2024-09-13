import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pixabay',
          style: TextStyle(),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<UserCubit>().login(email: 'theiskaa@gmail.com', password: '1234567');
          },
          child: const Text('Auth'),
        ),
      ),
    );
  }
}

