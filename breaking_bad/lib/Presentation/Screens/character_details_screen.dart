import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/Business_Logic/Cubit/quotes_cubit.dart';
import 'package:breaking_bad/Business_Logic/Cubit/quotes_states.dart';
import 'package:breaking_bad/Data/Web_Repository/characters_repository.dart';
import 'package:breaking_bad/Data/Web_Services/characteries_web_server.dart';

import '../../Business_Logic/Cubit/characteries_cubit.dart';
import '../../Business_Logic/Cubit/characteries_states.dart';
import '../../Data/Model/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharactersModel character;
  CharacterDetailsScreen({this.character}) : super();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuotesCubit>(context).fetchQuotesFromRepo(character.name);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: CustomScrollView(
          slivers: [
            buildSliverAppBar(context),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo(
                            'Job : ', character.occupation.join(' / ')),
                        sperator(),
                        characterInfo(
                            'Appeared in : ', character.categoryForTwoSeries),
                        sperator(),
                        characterInfo(
                            'Seasons : ', character.appearance.join(' / ')),
                        sperator(),
                        characterInfo('Status : ', character.status),
                        sperator(),
                        character.betterCallSaulAppearance.isEmpty
                            ? Container()
                            : characterInfo('Better Call Saul Seasons : ',
                                character.betterCallSaulAppearance.join(" / ")),
                        character.betterCallSaulAppearance.isEmpty
                            ? Container()
                            : sperator(),
                        characterInfo('Actor/Actress : ', character.name),
                        sperator(),
                        BlocBuilder<QuotesCubit, QuotesStates>(
                          builder: (context, state) {
                            return checkQuoteLoadedOrNot(state);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fav',
          ),
        ),
        background: Hero(
          tag: character.charID,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget sperator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      child: Container(
        color: Colors.yellow,
        height: 1,
        width: double.infinity,
      ),
    );
  }

  Widget characterInfo(String title, String descirption) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontFamily: 'Fav',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: descirption,
            style: TextStyle(
              fontFamily: 'Fav',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkQuoteLoadedOrNot(QuotesStates state) {
    if (state is QuotesLoadedState) {
      return buildQuoteItemOrNot(state);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget buildQuoteItemOrNot(state) {
    var quotes = state.quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Fav',
            color: Colors.amber,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
