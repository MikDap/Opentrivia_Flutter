import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

class ChiamataApi {
  String tipo;
  String categoria;
  String difficolta;

  String domanda = "";
  String risposta_corretta = "";
  String risposta_sbagliata_1 = "";
  String risposta_sbagliata_2 = "";
  String risposta_sbagliata_3 = "";

  TriviaQuestionCallback? callback;

  ChiamataApi(this.tipo, this.categoria, this.difficolta);

  Future<void> fetchTriviaQuestion(TriviaQuestionCallback callback) async {
    this.callback = callback;

    final questionsApi = ApiOpenTriviaInterface(Dio());

    try {
      final result = await questionsApi.getTriviaQuestion(
        1,
        int.parse(categoria),
        difficolta,
        tipo,
      );

      if (result != null) {
        if (tipo == "multiple") {
          domanda = result.results![0].question.toString();
          print("api,domanda $domanda");
          risposta_corretta = result.results![0].correctAnswer.toString();
          print("api,risposta_corr $risposta_corretta");
          risposta_sbagliata_1 = result.results![0].incorrectAnswers![0].toString();
          risposta_sbagliata_2 = result.results![0].incorrectAnswers![1].toString();
          risposta_sbagliata_3 = result.results![0].incorrectAnswers![2].toString();
          callback.onTriviaQuestionFetched(
            tipo,
            domanda,
            risposta_corretta,
            risposta_sbagliata_1,
            risposta_sbagliata_2,
            risposta_sbagliata_3,
          );
        }

        /*if (tipo == "boolean") {
          domanda = result.results![0].question.toString();
          risposta_corretta = result.results![0].correctAnswer.toString();
          risposta_sbagliata_1 = result.results![0].incorrectAnswers![0].toString();
          callback.onTriviaQuestionFetched(
            tipo,
            domanda,
            risposta_corretta,
            risposta_sbagliata_1,
            "",
            "",
          );
        }*/
      }
    } catch (e) {
      print("Error: $e");
    }
    print("fetch si");
  }
}

@RestApi(baseUrl: "https://opentdb.com/api_config.php")
abstract class ApiOpenTriviaInterface {
  factory ApiOpenTriviaInterface(Dio dio, {String baseUrl}) 

  @GET("/api.php")
  Future<TriviaQuestionResponse> getTriviaQuestion(
      @Query("param1") int param1,
      @Query("param2") int param2,
      @Query("param3") String param3,
      @Query("param4") String param4,
      );
}

class TriviaQuestionResponse {
  List<TriviaQuestionResult>? results;

  TriviaQuestionResponse({this.results});
}

class TriviaQuestionResult {
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  TriviaQuestionResult({this.question, this.correctAnswer, this.incorrectAnswers});
}

abstract class TriviaQuestionCallback {
  void onTriviaQuestionFetched(
      String tipo,
      String domanda,
      String risposta_corretta,
      String risposta_sbagliata_1,
      String risposta_sbagliata_2,
      String risposta_sbagliata_3,
      );
}
