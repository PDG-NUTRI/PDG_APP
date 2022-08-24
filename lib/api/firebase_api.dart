import 'dart:developer';

import 'package:pdg_app/model/aftercare.dart';

import 'api.dart';
import '../model/client.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../firebase_options.dart';

class FirebaseApi implements Api {
  CollectionReference aftercares =
      FirebaseFirestore.instance.collection('aftercare');
  CollectionReference clients = FirebaseFirestore.instance.collection('client');
  CollectionReference documents =
      FirebaseFirestore.instance.collection('document');
  CollectionReference meals = FirebaseFirestore.instance.collection('meal');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');
  CollectionReference dieticians =
      FirebaseFirestore.instance.collection('dietician');

  @override
  void createAftercare(Aftercare aftercare) {
    aftercares
        .add(aftercare.toJson())
        .then((value) => log("Aftercare Added"))
        .catchError((error) {
      log("Failed to add aftercare: $error");
      throw Exception(error);
    });
  }

  @override
  void createClient(Client client) {
    clients
        .add(client.toJson())
        .then((value) => log("User Added"))
        .catchError((error) {
      log("Failed to add user: $error");
      throw Exception(error);
    });
  }

  @override
  void createDocument() {
    // TODO: implement createDocument
    throw UnimplementedError();
  }

  @override
  void createMeal() {
    // TODO: implement createMeal
    throw UnimplementedError();
  }

  @override
  void createMessage() {
    // TODO: implement createMessage
    throw UnimplementedError();
  }

  @override
  void createDietician() {
    // TODO: implement createDietician
    throw UnimplementedError();
  }

  @override
  void deleteAftercare(String aftercareId) {
    aftercares.doc(aftercareId).delete();
  }

  @override
  void deleteClient(String clientId) {
    clients.doc(clientId).delete();
  }

  @override
  void deleteDocument(String documentId) {
    documents.doc(documentId).delete();
  }

  @override
  void deleteMeal(String mealId) {
    meals.doc(mealId).delete();
  }

  @override
  void deleteMessage(String messageId) {
    messages.doc(messageId).delete();
  }

  @override
  void deleteDietician(String dieticianId) {
    dieticians.doc(dieticianId).delete();
  }

  @override
  Future<Aftercare> readAftercare(String aftercareId) async {
    final docRef = clients.doc(aftercareId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Aftercare.fromJson(data);
  }

  @override
  Future<Client> readClient(String clientId) async {
    final docRef = clients.doc(clientId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Client.fromJson(data);
  }

  @override
  readDocument() {
    // TODO: implement readDocument
    throw UnimplementedError();
  }

  @override
  readMeal() {
    // TODO: implement readMeal
    throw UnimplementedError();
  }

  @override
  readMessage() {
    // TODO: implement readMessage
    throw UnimplementedError();
  }

  @override
  readDietician() {
    // TODO: implement readDietician
    throw UnimplementedError();
  }

  @override
  signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  updateAftercare(Aftercare aftercare) {
    aftercares
        .doc('FS3RqfWpeuVXcdZrTQJdBPfFbwV2')
        .update({'company': 'Stokes and Sons'})
        .then((value) => log("User Updated"))
        .catchError((error) {
          log("Failed to update user: $error");
          throw Exception(error);
        });
  }

  @override
  void updateClient(Client client) {
    clients
        .doc('FS3RqfWpeuVXcdZrTQJdBPfFbwV2')
        .update({'company': 'Stokes and Sons'})
        .then((value) => log("User Updated"))
        .catchError((error) {
          log("Failed to update user: $error");
          throw Exception(error);
        });
  }

  @override
  updateDocument() {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  @override
  updateMeal() {
    // TODO: implement updateMeal
    throw UnimplementedError();
  }

  @override
  updateMessage() {
    // TODO: implement updateMessage
    throw UnimplementedError();
  }

  @override
  updateDietician() {
    // TODO: implement updateDietician
    throw UnimplementedError();
  }
}