import 'package:data_repository/src/api/api_service.dart';
import 'package:data_repository/src/models/pokemon_model.dart';
import 'package:dio/dio.dart';

part 'api_const.dart';

///
/// API Service implementation
///
class APIServiceImpl implements APIService {
  APIServiceImpl() {}

  final Dio _dio = Dio();

  @override
  Future<List<PokemonModel>> listPokemons() async {
    List<dynamic> pokemons = await _fetchListOfPokemons();
    List<PokemonModel> result = [];

    for (var pokemon in pokemons) {
      var url = pokemon["url"];
      var details = await _fetchPokemonDetails(url);
      if (details == null) continue;
      var stats = details["stats"] as List<dynamic>;
      var model = PokemonModel(
          name: pokemon["name"],
          avatar: details["sprites"]["other"]["dream_world"]["front_default"],
          stats: stats.map((stat) => PokemonModelStat(name: stat["stat"]["name"], value: stat["base_stat"])).toList());
      result.add(model);
    }
    return result;
  }

  Future<List<dynamic>> _fetchListOfPokemons() async {
    try {
      var result = await _dio.get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      if (result.statusCode == 200) {
        return result.data["results"] as List<dynamic>;
      }
    } catch (ex) {}
    return [];
  }

  Future<dynamic> _fetchPokemonDetails(String url) async {
    try {
      var result = await _dio.get(url);
      if (result.statusCode == 200) {
        return result.data;
      }
    } catch (ex) {}
    return [];
  }
}
