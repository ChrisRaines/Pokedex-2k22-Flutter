import 'package:flutter/cupertino.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/po_error.dart';
import 'package:pokedex/common/widgets/po_loading.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/detail_page.dart';
import '../../../../../common/error/failure.dart';

class DetailsArguments {
  DetailsArguments({this.index = 0, required this.pokemon});
  final Pokemon pokemon;
  final int? index;
}

class DetailContainer extends StatefulWidget {
  const DetailContainer(
      {Key? key,
      required this.repository,
      required this.arguments,
      required this.onBack})
      : super(key: key);
  final IPokemonRepository repository;
  final DetailsArguments arguments;
  final VoidCallback onBack;

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  late PageController _controller;
  late Future<List<Pokemon>> _future;
  Pokemon? _pokemon;

  @override
  void initState() {
    _controller = PageController(
      viewportFraction: 0.6,
      initialPage: widget.arguments.index!,
    );
    _future = widget.repository.getAllPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PoLoading();
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            // ignore: prefer_conditional_assignment
            if (_pokemon == null) {
              _pokemon = widget.arguments.pokemon;
            }
            return DetailPage(
              pokemon: _pokemon!,
              list: snapshot.data!,
              onBack: widget.onBack,
              controller: _controller,
              onChangePokemon: (Pokemon value) {
                setState(() {
                  _pokemon = value;
                });
              },
            );
          } else if (snapshot.hasError) {
            return PoError(
              error: (snapshot.error as Failure).message!,
            );
          } else {
            return Container();
          }
        });
  }
}
