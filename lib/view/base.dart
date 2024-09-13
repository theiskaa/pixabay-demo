import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:pixabay_demo/view/screens/auth/login.dart';
import 'package:pixabay_demo/view/screens/home.dart';

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state.user == null) {
        return const Login();
      }
      return const Home();
    });
  }
}
