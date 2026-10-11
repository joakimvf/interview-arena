import 'package:serverpod/serverpod.dart';

import '../ai/embeddings.dart';
import '../generated/protocol.dart';

/// Accessor: futureCalls...answerEmbedding.embed(answerId). Idempotent.
class AnswerEmbeddingFutureCall extends FutureCall {
  Future<void> embed(Session session, int answerId) async {
    final client = embeddingClientFactory(session);
    if (client == null) return; // no voyageApiKey: skip (embedding stays null)
    final answer = await Answer.db.findById(session, answerId);
    if (answer == null || answer.embeddingModel != null) return;
    final question = await Question.db.findById(session, answer.questionId);
    final vectors = await client.embed([
      'Question: ${question?.prompt ?? ''}\nAnswer: ${answer.transcript}',
    ], isQuery: false);
    await Answer.db.updateRow(
      session,
      answer.copyWith(
        embedding: Vector(vectors.single),
        embeddingModel: client.modelId,
      ),
      columns: (t) => [t.embedding, t.embeddingModel],
    );
  }
}
