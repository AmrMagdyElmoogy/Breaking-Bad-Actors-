import '../Model/character_quotes.dart';
import '../Model/characters_model.dart';
import '../Web_Services/characteries_web_server.dart';
import 'package:flutter/material.dart';

class CharactersRepository {
  final CharacteriesWebServer characteriesWebServer;

  CharactersRepository(this.characteriesWebServer);

  Future<List<CharactersModel>> fetchDataFromWebServer() async {
    final characters = await characteriesWebServer.getCharacters();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }

  Future<List<Quotes>> fetchQuotesFromWebServer(String characterName) async {
    final quotes = await characteriesWebServer.getQuotes(characterName);
    return quotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}
