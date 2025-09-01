import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/rick_and_morty_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const RickAndMortyApp());
}
