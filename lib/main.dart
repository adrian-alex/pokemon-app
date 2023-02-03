import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var app = MultiRepositoryProvider(
    providers: [
      RepositoryProvider<PokemonDataRepository>(
        create: (context) => PokemonDataRepositoryImpl(),
        lazy: false,
      ),
    ],
    child: PokemonApp(),
  );

  runApp(app);
}
