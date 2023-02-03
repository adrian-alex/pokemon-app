import 'package:bloc/bloc.dart';

import 'package:data_repository/data_repository.dart';
part 'home_page_bloc_event.dart';
part 'home_page_bloc_state.dart';
part 'parts/on_start.dart';

///
/// The Bloc implementation of the Home Page screen.
///
class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageBlocState> {
  HomePageBloc({
    required PokemonDataRepository dataRepository,
  }) : super(HomePageBlocStateLoading()) {
    // register events
    on<HomePageBlocEventOnData>(
      (event, emit) => emit(HomePageBlocStateContent(event.pokemons)),
    );

    on<HomePageBlocEventPokemonSelected>(
      (event, emit) => emit(HomePageBlocStatePokemonSelected(event.index)),
    );

    //
    _onStart(
      dataRepository: dataRepository,
      bloc: this,
    );
  }
}
