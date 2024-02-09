import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/firestore_database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFirebase?>(context);

    return StreamBuilder<UserDataModel>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataModel userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (v) =>
                        v!.isEmpty ? 'Please enter the name' : null,
                    onChanged: (v) => setState(() => _currentName = v),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugar ?? userData.sugars,
                    items: sugars.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e sugars'),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => _currentSugar = v ?? ''),
                  ),
                  Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (v) =>
                          setState(() => _currentStrength = v.round())),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: userData.uid)
                              .updateUserData(
                                  sugars: _currentSugar ?? userData.sugars,
                                  name: _currentName ?? userData.name,
                                  strength:
                                      _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Update')),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
