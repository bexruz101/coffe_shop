import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brew_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/firestore_database.dart';
import 'package:flutter_application_1/ui/home/brew_list.dart';
import 'package:flutter_application_1/ui/home/settings_form.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: const [],
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title:const Text('Coffee Shop'),
            backgroundColor: Colors.brown[400],
            elevation: 0,
            actions: [
              TextButton.icon(
                  onPressed: () async {
                    _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('log out')),
              TextButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('settings'))
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/png/coffee_bg.png'),
                      fit: BoxFit.cover)),
              child: BrewList())),
    );
  }
}
