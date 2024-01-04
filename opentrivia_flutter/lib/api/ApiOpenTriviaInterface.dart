import 'dart:async';
import 'package:http/http.dart' as http;

class OpenTriviaResponse {
  // Definisci le proprietà della classe OpenTriviaResponse qui
}

class ApiOpenTriviaInterface {
  final String baseUrl;

  ApiOpenTriviaInterface(this.baseUrl);

  Future<http.Response<OpenTriviaResponse>> getTriviaQuestion({
    required int amount,
    required int category,
    required String difficulty,
    required String type,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api.php?amount=$amount&category=$category&difficulty=$difficulty&type=$type'),
    );

    // Puoi gestire diversi codici di stato qui e analizzare la risposta di conseguenza
    if (response.statusCode == 200) {
      // Se il server restituisce una risposta 200 OK, analizza la risposta
      final openTriviaResponse = OpenTriviaResponse(); // Sostituisci con la tua logica di analisi effettiva
      return http.Response(response.body, response.statusCode) as http.Response<OpenTriviaResponse>;
    } else {
      // Se il server non restituisce una risposta 200 OK,
      // genera un'eccezione.
      throw Exception('Impossibile caricare la domanda di trivia');
    }
  }
}
