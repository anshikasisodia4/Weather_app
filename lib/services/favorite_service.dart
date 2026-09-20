import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavorite(String city) async {
    final query = await favorites
        .where('city', isEqualTo: city)
        .get();

    if (query.docs.isEmpty) {
      await favorites.add({
        'city': city,
      });
    }
  }

  Stream<List<String>> getFavorites() {
    return favorites.snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => doc['city'].toString())
            .toList();
      },
    );
  }

  Future<void> deleteFavorite(String city) async {
    final query = await favorites
        .where('city', isEqualTo: city)
        .get();

    for (final doc in query.docs) {
      await doc.reference.delete();
    }
  }
}