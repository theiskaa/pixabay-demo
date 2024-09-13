import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/state/app/app_cubit.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:pixabay_demo/core/utils/utils.dart';
import 'package:pixabay_demo/view/widgets/buttons/base_button.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';
import 'package:pixabay_demo/view/widgets/fields/primary_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const fractionalWidth = .85;

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = ScrollController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailForm = GlobalKey<FormState>(), passForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _LoginBody(
        controller: controller,
        emailController: emailController,
        passwordController: passwordController,
        emailForm: emailForm,
        passForm: passForm,
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  final ScrollController controller;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> emailForm;
  final GlobalKey<FormState> passForm;

  const _LoginBody({
    required this.controller,
    required this.emailController,
    required this.passwordController,
    required this.emailForm,
    required this.passForm,
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
              widthFactor: Login.fractionalWidth,
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
              widthFactor: Login.fractionalWidth,
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
              widthFactor: Login.fractionalWidth,
              controller: passwordController,
              label: context.fmt('auth.field.password'),
              hint: context.fmt('auth.field.password.hint'),
              validate: (v) {
                if (Validators.password(v)) return null;
                return context.fmt('error.field.invalid-password');
              },
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: .84,
              child: BlocBuilder<AppCubit, AppCubitState>(builder: (context, state) {
                return BaseButtonBloced<UserCubit, UserState>(
                  title: Text(
                    context.fmt('auth.button.signin'),
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

                    if (!isEmailValid || !isPassValid) return;
                    await context.read<UserCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
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
                onPressed: () {
                  // TODO: AppRouter.router.goNamed(Register.route);
                },
                child: RichText(
                  text: TextSpan(
                    text: context.fmt(
                      'auth.ask.do-not-have-account',
                    ),
                    children: [
                      TextSpan(
                        text: ' ${context.fmt('auth.button.register')}',
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
