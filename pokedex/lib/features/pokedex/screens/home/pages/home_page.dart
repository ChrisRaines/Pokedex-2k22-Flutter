import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/pokemon_item_widget.dart';
import 'widgets/drawer_menu_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.list,
    required this.onItemTap,
  }) : super(key: key);
  final List<Pokemon> list;
  final Function(String, DetailsArguments) onItemTap;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Pokédex',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: widget.list
                .map((e) => PokemonItemWidget(
                      pokemon: e,
                      onTap: widget.onItemTap,
                      index: widget.list.indexOf(e),
                    ))
                .toList()),
      ),
    );
  }
}
