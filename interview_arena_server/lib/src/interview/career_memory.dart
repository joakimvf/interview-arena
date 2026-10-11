import 'package:serverpod/serverpod.dart';

import '../ai/embeddings.dart';
import '../generated/protocol.dart';

/// Similarity search over stored answer embeddings ("career memory").
/// Cosine distance = 1 - cosine similarity.
abstract final class CareerMemory {
  static Future<List<Answer>> nearestAnswers(
    Session session,
    Vector query, {
    required UuidValue authUserId,
    int limit = 10,
    double? maxDistance,
    Transaction? transaction,
  }) {
    if (query.length != embeddingDimension) {
      throw ArgumentError.value(query.length, 'query.length');
    }
    return Answer.db.find(
      session,
      where: (t) {
        // ColumnVector.equals does not accept null: raw IS NOT NULL.
        Expression where =
            Expression('${t.embedding} IS NOT NULL') &
            t.authUserId.equals(authUserId);
        if (maxDistance != null) {
          where = where & (t.embedding.distanceCosine(query) < maxDistance);
        }
        return where;
      },
      orderBy: (t) => t.embedding.distanceCosine(query),
      limit: limit,
      transaction: transaction,
    );
  }
}
