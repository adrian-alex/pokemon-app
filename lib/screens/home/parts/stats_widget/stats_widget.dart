import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/style/style.dart';

///
/// The 'Stat' card widget
///
class StatWidget extends StatelessWidget {
  const StatWidget(this.pokemon, {super.key});

  final PokemonModel pokemon;
  static const double _top = 260;
  static const double _maxWidth = 430;
  static const double _layoutStartsAt = 100;

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context: context);
  }

  ///
  /// The widget body
  ///
  Widget _bodyWidget({required BuildContext context}) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: _top),
        constraints: const BoxConstraints(maxWidth: _maxWidth),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(70)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: _layoutStartsAt,
            ),
            titleStrong(
              pokemon.name.capitalize(),
            ),
            const SizedBox(
              height: 32,
            ),
            _hpProgressWidget(pokemon),
            const SizedBox(
              height: 18,
            ),
            paragraphStrong("${pokemon.stats.firstWhere((element) => element.name == "hp").value} HP"),
            const SizedBox(
              height: 10,
            ),
            _statsDetails(pokemon.stats.sublist(1)),
          ],
        ),
      ),
    );
  }

  /// The HP progress bar
  Widget _hpProgressWidget(PokemonModel pokemon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: LinearProgressIndicator(
        minHeight: 18,
        value: pokemon.stats.firstWhere((element) => element.name == "hp").value / 100,
      ),
    );
  }

  /// The stat details, with numbers
  Widget _statsDetails(List<PokemonModelStat> stats) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
      ),
      children: stats.map((e) => _singleStat(e)).toList(),
    );
  }

  /// The actual single stat, with the numbers
  Widget _singleStat(PokemonModelStat stat) => Column(
        children: [
          Text(
            stat.value.toString(),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          Text(
            formatStatName(stat.name),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
