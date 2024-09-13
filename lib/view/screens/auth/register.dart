import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/state/app/app_cubit.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:pixabay_demo/core/utils/utils.dart';
import 'package:pixabay_demo/view/widgets/buttons/base_button.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';
import 'package:pixabay_demo/view/widgets/fields/primary_field.dart';

class Register extends StatefulWidget {
  static const fractionalWidth = .85;
  static const route = 'register';
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final controller = ScrollController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();

  final emailForm = GlobalKey<FormState>(),
      passForm = GlobalKey<FormState>(),
      ageForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        final isLoading = state.loading[UserStateEvent.register] == false;
        if (isLoading && state.user != null) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _RegisterBody(
          controller: controller,
          emailController: emailController,
          passwordController: passwordController,
          ageController: ageController,
          emailForm: emailForm,
          passForm: passForm,
          ageForm: ageForm,
        ),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  final ScrollController controller;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController ageController;
  final GlobalKey<FormState> emailForm;
  final GlobalKey<FormState> passForm;
  final GlobalKey<FormState> ageForm;

  const _RegisterBody({
    required this.controller,
    required this.emailController,
    required this.passwordController,
    required this.ageController,
    required this.emailForm,
    required this.passForm,
    required this.ageForm,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: controller,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: Register.fractionalWidth,
              child: Column(
                children: [
                  Opacity(
                    opacity: .7,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        context.fmt('app.welcome-back'),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 24,
                          color: const Color(0xffAFB1CA),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      context.fmt('app.signin-to'),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            PrimaryField(
              formKey: emailForm,
              widthFactor: Register.fractionalWidth,
              controller: emailController,
              label: context.fmt('auth.field.email'),
              hint: context.fmt('auth.field.email.hint'),
              validate: (v) {
                if (Validators.email(v)) return null;
                return context.fmt('error.field.invalid-email');
              },
            ),
            const SizedBox(height: 15),
            PrimaryField(
              formKey: passForm,
              obscureText: true,
              widthFactor: Register.fractionalWidth,
              controller: passwordController,
              label: context.fmt('auth.field.password'),
              hint: context.fmt('auth.field.password.hint'),
              validate: (v) {
                if (Validators.password(v)) return null;
                return context.fmt('error.field.invalid-password');
              },
            ),
            const SizedBox(height: 15),
            PrimaryField(
              formKey: ageForm,
              widthFactor: Register.fractionalWidth,
              controller: ageController,
              label: context.fmt('auth.field.age'),
              hint: context.fmt('auth.field.age.hint'),
              validate: (v) {
                if (Validators.age(v)) return null;
                return context.fmt('error.field.invalid-age');
              },
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: .84,
              child: BlocBuilder<AppCubit, AppCubitState>(builder: (context, state) {
                return BaseButtonBloced<UserCubit, UserState>(
                  title: Text(
                    context.fmt('auth.button.register'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.baseBlue,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  border: BorderSide(color: AppColors.baseBlue.withOpacity(.8)),
                  isLoading: (s) => s.loading[UserStateEvent.login] == true,
                  onTap: () async {
                    final isEmailValid = emailForm.currentState!.validate();
                    final isPassValid = passForm.currentState!.validate();
                    final isAgeValid = ageForm.currentState!.validate();

                    if (!isEmailValid || !isPassValid || !isAgeValid) return;
                    await context.read<UserCubit>().register(
                          email: emailController.text,
                          password: passwordController.text,
                          age: int.parse(ageController.text),
                        );
                  },
                );
              }),
            ),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(),
                child: RichText(
                  text: TextSpan(
                    text: context.fmt('auth.ask.already-registered'),
                    children: [
                      TextSpan(
                        text: ' ${context.fmt('auth.button.signin')}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor.withOpacity(.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
