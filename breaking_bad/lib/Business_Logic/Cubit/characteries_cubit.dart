import 'characteries_states.dart';
import '../../Data/Model/characters_model.dart';
import '../../Data/Web_Repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharactersStates> {
  final CharactersRepository charactersRepository;
  List<CharactersModel> characters = [];
  CharacterCubit(this.charactersRepository) : super(CharactersInitialState());
  List<CharactersModel> fetchDataFromRepo() {
    charactersRepository
        .fetchDataFromWebServer()
        .then((characters) => {
              emit(CharactersLoadedState(characters)),
              this.characters = characters,
            })
        .catchError((onError) {
      emit(CharactersErrorLoadingState());
    });
    return characters;
  }
}
