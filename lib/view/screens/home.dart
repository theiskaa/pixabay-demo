import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixabay_demo/core/state/pixabay/pixabay_cubit.dart';
import 'package:pixabay_demo/core/state/pixabay/pixabay_state.dart';
import 'package:pixabay_demo/core/state/user/user_cubit.dart';
import 'package:pixabay_demo/view/widgets/cards/langauge_switcher.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';
import 'package:pixabay_demo/view/widgets/buttons/opacity_button.dart';
import 'package:pixabay_demo/view/widgets/cards/pixabay_image_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final pixabayCubit = context.read<PixabayCubit>();
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      pixabayCubit.fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pixabay'),
        actions: [
          const LanguageSwitcher(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OpacityButton(
              onTap: () async => context.read<UserCubit>().logout(),
              child: const Icon(
                FontAwesomeIcons.rightFromBracket,
                size: 20,
                color: AppColors.baseBlue,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PixabayCubit, PixabayState>(
        builder: (context, state) {
          final isLoading = state.loading[PixabayStateEvent.fetch] == true;

          // Initial Loading
          if (state.images.isEmpty && isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error Handling
          final error = state.error[PixabayStateEvent.fetch];
          if (error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.circleExclamation,
                    color: Colors.red.withOpacity(.5),
                  ),
                  const SizedBox(height: 5),
                  Text(error),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: state.images.length,
                  itemBuilder: (context, index) {
                    return PixabayImageCard(photo: state.images[index]);
                  },
                ),
              ),
              if (state.loading[PixabayStateEvent.fetchMore] == true) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CircularProgressIndicator(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
