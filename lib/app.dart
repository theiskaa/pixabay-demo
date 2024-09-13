import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/app/router.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pixaby Demo',
        routerConfig: AppRouter.router,
        locale: Locale(context.intl.locale.languageCode),
        localizationsDelegates: [
          context.intl.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: context.intl.supportedLocales,
      ),
    );
  }
}
