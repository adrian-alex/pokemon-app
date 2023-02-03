import 'package:data_repository/src/data_repository.dart';
import 'package:data_repository/src/models/pokemon_model.dart';

import 'api/api.dart';

class PokemonDataRepositoryImpl implements PokemonDataRepository {
  final APIService _apiService = APIServiceImpl();

  @override
  Future<List<PokemonModel>> listPokemons() => _apiService.listPokemons();
}
