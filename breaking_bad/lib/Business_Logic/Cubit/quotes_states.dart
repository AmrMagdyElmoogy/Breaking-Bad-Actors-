import 'package:breaking_bad/Data/Model/character_quotes.dart';

abstract class QuotesStates {}

class QuotesInitialState extends QuotesStates {}

class QuotesLoadedState extends QuotesStates {
  List<Quotes> quotes;
  QuotesLoadedState(this.quotes);
}
