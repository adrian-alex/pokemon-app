part of 'home_page_bloc.dart';

abstract class HomePageBlocEvent {
  const HomePageBlocEvent();
}

/// New data available
class HomePageBlocEventOnData extends HomePageBlocEvent {
  List<PokemonModel> pokemons;
  HomePageBlocEventOnData(this.pokemons);
}

/// When the pokemon has been selected
class HomePageBlocEventPokemonSelected extends HomePageBlocEvent {
  final int index;
  HomePageBlocEventPokemonSelected(this.index);
}
