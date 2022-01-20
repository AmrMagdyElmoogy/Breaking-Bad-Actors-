
import 'package:breaking_bad/Business_Logic/Cubit/quotes_states.dart';
import 'package:breaking_bad/Data/Web_Repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesCubit extends Cubit<QuotesStates> {
  final CharactersRepository charactersRepository;
  QuotesCubit(this.charactersRepository) : super(QuotesInitialState());

  void fetchQuotesFromRepo(String characterName) {
    charactersRepository
        .fetchQuotesFromWebServer(characterName)
        .then((quote) => {
              emit(QuotesLoadedState(quote)),
              print(quote.length),
            })
        .catchError((onError) {});
  }
}
