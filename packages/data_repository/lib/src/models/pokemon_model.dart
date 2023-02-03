import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PokemonModel {
  final String name;
  final String avatar;
  final List<PokemonModelStat> stats;

  PokemonModel({required this.name, required this.avatar, required this.stats});
}

@JsonSerializable(explicitToJson: true)
class PokemonModelStat {
  final String name;
  final int value;
  PokemonModelStat({required this.name, required this.value});
}
