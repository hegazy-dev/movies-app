import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class HistoryDataSource {
  final FirebaseFirestore _firestore;

  HistoryDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _historyReference(String userId) {
    return _firestore.collection('users').doc(userId).collection('history');
  }

  Future<void> addToHistory({
    required String userId,
    required MovieModel movie,
  }) async {
    await _historyReference(userId).doc(movie.id.toString()).set({
      'id': movie.id,
      'title': movie.title,
      'rating': movie.rating,
      'mediumCoverImage': movie.mediumCoverImage,
      'largeCoverImage': movie.largeCoverImage,
      'genres': movie.genres,
      'year': movie.year,
      'visitedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<MovieModel>> getHistory({required String userId}) async {
    final snapshot = await _historyReference(
      userId,
    ).orderBy('visitedAt', descending: true).get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return MovieModel(
        id: data['id'] as int,
        title: data['title'] as String,
        rating: (data['rating'] as num).toDouble(),
        mediumCoverImage: data['mediumCoverImage'] as String,
        largeCoverImage: data['largeCoverImage'] as String,
        genres: List<String>.from(data['genres'] as List),
        year: data['year'] as int,
      );
    }).toList();
  }

  Future<void> removeFromHistory({
    required String userId,
    required int movieId,
  }) async {
    await _historyReference(userId).doc(movieId.toString()).delete();
  }

  Future<void> clearHistory({required String userId}) async {
    final snapshot = await _historyReference(userId).get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
