import 'package:data_repository/data_repository.dart';

///
/// API Service
///
abstract class APIService {
  ///
  /// Will fetch and return a list of [PokemonModel]
  /// FIXME implement lazy loading
  ///
  Future<List<PokemonModel>> listPokemons() async => [];
}
