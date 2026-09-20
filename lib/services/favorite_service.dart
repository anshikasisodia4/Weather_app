import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  String _documentId(String city) {
    return city
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '_');
  }

  Future<void> addFavorite(String city) async {
    final id = _documentId(city);

    await favorites.doc(id).set({
      'city': city.trim(),
    });
  }

  Stream<List<String>> getFavorites() {
    return favorites.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return doc['city'].toString();
        }).toList();
      },
    );
  }

  Future<void> deleteFavorite(String city) async {
    final id = _documentId(city);

    await favorites.doc(id).delete();
  }
}