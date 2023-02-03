import 'models/models.dart';

abstract class PokemonDataRepository {
  ///
  /// Will return a list of [PokemonModel]
  ///
  Future<List<PokemonModel>> listPokemons() async => [];
}
