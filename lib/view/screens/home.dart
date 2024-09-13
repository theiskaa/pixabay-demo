import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:pixabay_demo/view/widgets/buttons/base_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BaseButton(
          title: const Text('logout'),
          onTap: () {
            context.read<UserCubit>().logout();
          },
        ),
      ),
    );
  }
}
