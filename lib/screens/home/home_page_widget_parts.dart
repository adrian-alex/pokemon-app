part of 'home_page_widget.dart';

/// The page body widget
/// Will display a progress indicator while loading
Widget get _bodyWidget => BlocBuilder<HomePageBloc, HomePageBlocState>(
      buildWhen: (previous, current) => current is HomePageBlocStateContent,
      builder: (context, state) {
        if (state is HomePageBlocStateContent) {
          return isMobile(context)
              ? PokemonAnimatedBackground(
                  _layout(context, state.pokemons),
                )
              : WhiteCard(
                  child: PokemonAnimatedBackground(
                    _layout(context, state.pokemons),
                  ),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

/// The actual layout once is loading
Widget _layout(BuildContext context, List<PokemonModel> pokemons) => Center(
      child: SingleChildScrollView(
        child: Stack(children: [
          _statsWidgets(context: context, pokemons: pokemons),
          _carouselWidget(context: context, pokemons: pokemons),
        ]),
      ),
    );

/// The stat widgets
Widget _statsWidgets({required BuildContext context, required List<PokemonModel> pokemons}) {
  return BlocBuilder<HomePageBloc, HomePageBlocState>(
      buildWhen: (previous, current) => current is HomePageBlocStatePokemonSelected,
      builder: (context, state) {
        if (state is HomePageBlocStatePokemonSelected) {
          return StatWidget(pokemons[state.index]);
        }
        return const SizedBox.shrink();
      });
}

/// The actual carousel with images
/// Has a fix height
Widget _carouselWidget({
  required BuildContext context,
  required List<PokemonModel> pokemons,
}) =>
    SizedBox(
      height: 400,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: PageView(
          pageSnapping: true,
          onPageChanged: (index) => context.read<HomePageBloc>().add(HomePageBlocEventPokemonSelected(index)),
          controller: PageController(viewportFraction: isMobile(context) ? 0.7 : 0.5, initialPage: 0, keepPage: true),
          children: pokemons.map((e) => PokemonImage(e)).toList(),
        ),
      ),
    );
