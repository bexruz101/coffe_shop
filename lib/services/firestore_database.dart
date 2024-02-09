import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/brew_model.dart';
import 'package:flutter_application_1/models/user_model.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(
      {required String sugars,
      required String name,
      required int strength}) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Brew(
        name: e.get('name') ?? '',
        sugrars: e.get('sugars') ?? '0',
        strength: e.get('strength') ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: uid ?? '',
      name: snapshot.get('name') ?? '',
      sugars: snapshot.get('sugars') ?? '',
      strength: snapshot.get('strength') ?? 0,
    );
  }

  Stream<UserDataModel> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
