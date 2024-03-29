import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/brew_model.dart';
import 'package:flutter_application_1/ui/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];
    return ListView.builder(
        itemCount: brews.length ,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
