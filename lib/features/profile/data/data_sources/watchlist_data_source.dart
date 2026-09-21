import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/features/home/data/models/movie_model.dart';

class WatchlistDataSource {
  final FirebaseFirestore _firestore;

  WatchlistDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _watchlistReference(String userId) {
    return _firestore.collection('users').doc(userId).collection('watchlist');
  }

  Future<void> addToWatchlist({
    required String userId,
    required MovieModel movie,
  }) async {
    await _watchlistReference(userId).doc(movie.id.toString()).set({
      'id': movie.id,
      'title': movie.title,
      'rating': movie.rating,
      'mediumCoverImage': movie.mediumCoverImage,
      'largeCoverImage': movie.largeCoverImage,
      'genres': movie.genres,
      'year': movie.year,
    });
  }

  Future<void> removeFromWatchlist({
    required String userId,
    required int movieId,
  }) async {
    await _watchlistReference(userId).doc(movieId.toString()).delete();
  }

  Future<List<MovieModel>> getWatchlist({required String userId}) async {
    final snapshot = await _watchlistReference(userId).get();

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

  Future<bool> isInWatchlist({
    required String userId,
    required int movieId,
  }) async {
    final document = await _watchlistReference(
      userId,
    ).doc(movieId.toString()).get();

    return document.exists;
  }
}
