import '../../Data/Model/character_quotes.dart';
import '../../Data/Model/characters_model.dart';
import 'package:flutter/material.dart';

abstract class CharactersStates {}

class CharactersInitialState extends CharactersStates {}

class CharactersLoadedState extends CharactersStates {
  List<CharactersModel> characters;
  CharactersLoadedState(this.characters);
}

class CharactersErrorLoadingState extends CharactersStates {}

