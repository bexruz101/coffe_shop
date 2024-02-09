import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brew_model.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/png/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugrars} sugar(s)'),
        ),
      ),
    );
  }
}
