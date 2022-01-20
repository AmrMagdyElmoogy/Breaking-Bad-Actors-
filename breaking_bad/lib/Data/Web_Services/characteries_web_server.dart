import '../../Constants/strings.dart';
import '../Model/characters_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CharacteriesWebServer {
  Dio dio;
  CharacteriesWebServer() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getCharacters() async {
    Response response = await dio.get('characters');
    return response.data;
  }

  Future<List<dynamic>> getQuotes(String characterName) async {
    Response response =
        await dio.get('quote', queryParameters: {'author': characterName});
    return response.data;
  }
}
