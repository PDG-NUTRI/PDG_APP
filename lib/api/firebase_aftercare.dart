import 'dart:developer';

import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

class FirebaseAftercare extends FirebaseAPI implements IAftercare {
  FirebaseAftercare(FirebaseFirestore db) : super(db, 'aftercare');

  @override
  void createAftercare(Aftercare aftercare) async {
    try {
      await collectionReference
          .withConverter(
              fromFirestore: Aftercare.fromFirestore,
              toFirestore: (Aftercare aftercare, options) =>
                  aftercare.toFirestore())
          .doc(aftercare.uid)
          .set(aftercare);
    } catch (e) {
      log("Failed to add aftercare: $e");
      throw Exception(e);
    }
  }

  @override
  Future<Aftercare> readAftercare(String aftercareId) async {
    final docRef = collectionReference.doc(aftercareId).withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final aftercare = docSnapshot.data();
    if (aftercare != null) {
      return aftercare;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  Future<List<Aftercare>> readAftercareOfClient(String clientId) async {
    final querySnapshot = await collectionReference
        .where('clientId', isEqualTo: clientId)
        .withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        )
        .get();
    List<Aftercare> dietitians =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    return dietitians;
  }

  @override
  Future<void> updateAftercare(Aftercare aftercare) async {
    try {
      await collectionReference
          .doc(aftercare.uid)
          .update(aftercare.toFirestore());
    } catch (e) {
      log("Failed to update aftercare: $e");
      throw Exception(e);
    }
  }

  @override
  void deleteAftercare(String aftercareId) {
    collectionReference.doc(aftercareId).delete();
  }
}
