import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

import '../../../home/pages/widgets/type_widget.dart';

class DetailListWidget extends StatelessWidget {
  const DetailListWidget(
      {Key? key,
      required this.pokemon,
      required this.list,
      required this.controller,
      required this.onChangePokemon})
      : super(key: key);
  final Pokemon pokemon;
  final List<Pokemon> list;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 89,
      left: 0,
      right: 0,
      height: 350,
      child: Column(
        children: [
          Container(
            color: pokemon.baseColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        '#${pokemon.num}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: PageView(
                      onPageChanged: (index) {
                        onChangePokemon(list[index]);
                      },
                      controller: controller,
                      children: list.map((e) {
                        bool diffName = e.name != pokemon.name;
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: diffName ? 0.4 : 1.0,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                            tween: Tween<double>(
                                end: diffName ? 150 : 300,
                                begin: diffName ? 300 : 150),
                            builder: (context, value, child) {
                              return Center(
                                child: Image.network(
                                  e.image,
                                  width: value,
                                  fit: BoxFit.contain,
                                  color: diffName
                                      ? Colors.black.withOpacity(0.5)
                                      : null,
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.black,
            child: Column(
              children: pokemon.type
                  .map((e) => TypeWidget(
                        name: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
