import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavorite(String city) async {
    final id = city.trim().toLowerCase().replaceAll(' ', '_');

    await favorites.doc(id).set({
      'city': city.trim(),
    });
  }

  Stream<List<String>> getFavorites() {
    return favorites.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc['city'].toString();
      }).toList();
    });
  }

  Future<void> deleteFavorite(String city) async {
    final id = city.trim().toLowerCase().replaceAll(' ', '_');

    await favorites.doc(id).delete();
  }
}