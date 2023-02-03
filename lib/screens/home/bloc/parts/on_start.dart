part of '../home_page_bloc.dart';

///
/// Called when the Bloc is initialised
/// Will fetch Pokemons and update UI
///
void _onStart({required PokemonDataRepository dataRepository, required HomePageBloc bloc}) async {
  var pokemons = await dataRepository.listPokemons();

  // tell the UI new data is here
  bloc.add(HomePageBlocEventOnData(pokemons));

  // select the first pokemon
  bloc.add(HomePageBlocEventPokemonSelected(0));
}
