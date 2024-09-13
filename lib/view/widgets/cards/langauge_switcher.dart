import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/state/app/app_cubit.dart';
import 'package:pixabay_demo/view/widgets/buttons/opacity_button.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final lang in languages)
              OpacityButton(
                child: Text(
                  lang.languageCode.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    wordSpacing: 0,
                    color: Colors.black,
                    fontWeight: state.languageCode.toLowerCase() == lang.languageCode.toLowerCase()
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                onTap: () async {
                  await context.read<AppCubit>().changeLang(lang.languageCode);
                },
              ),
          ],
        );
      },
    );
  }
}
