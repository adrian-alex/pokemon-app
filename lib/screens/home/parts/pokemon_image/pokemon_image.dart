import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_app/style/style.dart';

///
/// The pokemon image widget.
/// Will fetch an SVG from an URL and render it
///
class PokemonImage extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonImage(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile(context) ? 20 : 35),
      child: _logoWidget,
    );
  }

  Widget get _logoWidget => SvgPicture.network(
        pokemon.avatar,
        semanticsLabel: 'Pokemon',
      );
}
