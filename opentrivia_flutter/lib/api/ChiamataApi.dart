import 'package:dio/dio.dart';
import 'ApiOpenTriviaInterface.dart';
import 'Domanda.dart';

class ChiamataApi {
  String tipo;
  String categoria;
  String difficolta;

  String domanda = "";
  String rispostaCorretta = "";
  String rispostaSbagliata1 = "";
  String rispostaSbagliata2 = "";
  String rispostaSbagliata3 = "";

  ChiamataApi(this.tipo, this.categoria, this.difficolta);

  Future<void> fetchTriviaQuestion(TriviaQuestionCallback callback) async {
    try {
      final restClient = RestClient(Dio(), baseUrl: "https://opentdb.com/");

      final response = await restClient.getTriviaQuestion(
        1,
        int.parse(categoria),
        difficolta,
        tipo,
      );

      final results = response.results;

      if (results != null && results.isNotEmpty) {
        final firstQuestion = results[0];

        domanda = firstQuestion.question ?? "";
        rispostaCorretta = firstQuestion.correct_answer ?? "";
        rispostaSbagliata1 = firstQuestion.incorrect_answers?[0] ?? "";
        rispostaSbagliata2 = firstQuestion.incorrect_answers?[1] ?? "";
        rispostaSbagliata3 = firstQuestion.incorrect_answers?[2] ?? "";

        callback.onTriviaQuestionFetched(
          tipo,
          domanda,
          rispostaCorretta,
          rispostaSbagliata1,
          rispostaSbagliata2,
          rispostaSbagliata3,
        );
      }
    } catch (e) {
      // Gestisci eventuali errori
      print("Errore durante la richiesta trivia: $e");
    }
  }
}

abstract class TriviaQuestionCallback {
  void onTriviaQuestionFetched(
      String tipo,
      String domanda,
      String rispostaCorretta,
      String rispostaSbagliata1,
      String rispostaSbagliata2,
      String rispostaSbagliata3,
      );
}
