import 'package:breaking_bad/Business_Logic/Cubit/quotes_cubit.dart';
import 'package:breaking_bad/Presentation/Screens/character_details_screen.dart';

import 'Business_Logic/Bloc/bloc_observer.dart';
import 'Business_Logic/Cubit/characteries_cubit.dart';
import 'Data/Web_Repository/characters_repository.dart';
import 'Data/Web_Services/characteries_web_server.dart';
import 'Presentation/Screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          CharacterCubit(CharactersRepository(CharacteriesWebServer())),
      child: CharacteriesScreen(),
    ),
    BlocProvider(
      create: (context) =>
          QuotesCubit(CharactersRepository(CharacteriesWebServer())),
      child: CharacterDetailsScreen(),
    ),
  ], child: BreakingBadApp()));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CharacteriesScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          elevation: 0,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
