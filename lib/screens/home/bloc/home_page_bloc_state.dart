part of 'home_page_bloc.dart';

class HomePageBlocState {}

/// Will display a blank screen (for now)
class HomePageBlocStateLoading extends HomePageBlocState {}

/// Update Ui with new content
class HomePageBlocStateContent extends HomePageBlocState {
  List<PokemonModel> pokemons;
  HomePageBlocStateContent(this.pokemons);
}

/// Update part of the UI when a pokemon is selected
class HomePageBlocStatePokemonSelected extends HomePageBlocState {
  final int index;
  HomePageBlocStatePokemonSelected(this.index);
}
