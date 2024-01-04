import 'Domanda.dart';

class OpenTriviaResponse {
  int responseCode;
  List<Domanda> results;

  OpenTriviaResponse({
    required this.responseCode,
    required this.results,
  });

  factory OpenTriviaResponse.fromJson(Map<String, dynamic> json) {
    return OpenTriviaResponse(
      responseCode: json['response_code'] as int,
      results: (json['results'] as List)
          .map((result) => Domanda.fromJson(result as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response_code': responseCode,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}
