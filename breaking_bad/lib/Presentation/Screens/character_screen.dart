import 'package:flutter_offline/flutter_offline.dart';

import '../../Business_Logic/Cubit/characteries_cubit.dart';
import '../../Business_Logic/Cubit/characteries_states.dart';
import '../../Data/Model/characters_model.dart';
import '../../Data/Web_Repository/characters_repository.dart';
import '../../Data/Web_Services/characteries_web_server.dart';
import '../Widgets/characters_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacteriesScreen extends StatefulWidget {
  @override
  _CharacteriesScreenState createState() => _CharacteriesScreenState();
}

class _CharacteriesScreenState extends State<CharacteriesScreen> {
  CharacterCubit characterCubit =
      CharacterCubit(CharactersRepository(CharacteriesWebServer()));
  List<CharactersModel> allCharacters = [];
  List<CharactersModel> searchedCharacters = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).fetchDataFromRepo();
  }

  var searchController = TextEditingController();
  Widget buildTextField() {
    return TextField(
      controller: searchController,
      cursorColor: Colors.white,
      onChanged: (searchCharacters) {
        searchingFilterdCharactersItems(searchCharacters);
      },
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Fav',
      ),
      decoration: InputDecoration(
        hintText: 'Find a Character ...',
        hintStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Fav',
          fontWeight: FontWeight.w100,
        ),
        border: InputBorder.none,
      ),
    );
  }

  bool isSearching = false;
  Widget buildActionsAppBar() {
    if (isSearching) {
      return (IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          searchingOFF();
          Navigator.of(context).pop();
        },
      ));
    } else {
      return (IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: searchingON,
      ));
    }
  }

  void searchingON() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: searchingOFF));
    setState(() {
      isSearching = true;
    });
  }

  void searchingFilterdCharactersItems(String text) {
    setState(() {
      searchedCharacters = allCharacters
          .where(
            (character) => character.name.toLowerCase().startsWith(text),
          )
          .toList();
    });
  }

  void searchingOFF() {
    searchController.clear();
    setState(() {
      isSearching = false;
    });
  }

  Widget appBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Fav',
      ),
    );
  }

  Widget noInternetWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Can\'t connect .. Please check your internet connection',
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'Fav'),
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage('assets/images/warning.png'),
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          buildActionsAppBar(),
        ],
        title: isSearching ? buildTextField() : appBarTitle(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<CharacterCubit, CharactersStates>(
              builder: (context, state) {
                if (state is CharactersLoadedState) {
                  allCharacters = (state).characters;
                  return buildCharactersItems();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return noInternetWidget();
          }
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildCharactersItems() {
    return Container(
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 1,
        ),
        itemCount: searchController.text.isEmpty
            ? allCharacters.length
            : searchedCharacters.length,
        itemBuilder: (context, index) => CharacterGridView(
          characteres: searchController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        ),
      ),
    );
  }
}
