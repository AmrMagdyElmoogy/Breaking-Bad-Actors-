import 'package:flutter/material.dart';

import '../../Data/Model/characters_model.dart';
import '../Screens/character_details_screen.dart';

class CharacterGridView extends StatelessWidget {
  final CharactersModel characteres;
  const CharacterGridView({this.characteres}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CharacterDetailsScreen(
                        character: characteres,
                      )));
            },
            child: GridTile(
              child: Hero(
                tag: characteres.charID,
                child: Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: characteres.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              footer: Container(
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                color: Colors.black54,
                child: Text(
                  characteres.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Fav',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
