import 'package:flutter/material.dart';
import 'package:rick_and_morty/DI/DI.dart';
import 'package:rick_and_morty/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependencyInjection();

  runApp(const RickAndMortyApp());
}
