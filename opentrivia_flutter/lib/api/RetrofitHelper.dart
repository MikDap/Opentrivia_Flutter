import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/dio.dart';

import 'Domanda.dart';

@RestApi(baseUrl: "https://opentdb.com/")
abstract class ApiOpenTriviaInterface {
  factory ApiOpenTriviaInterface(Dio dio, {String baseUrl}) = _ApiOpenTriviaInterface;

  @GET("/your_endpoint_here")
  Future<OpenTriviaResponse> getTriviaQuestion(
      @Query("param1") int param1,
      @Query("param2") int param2,
      @Query("param3") String param3,
      @Query("param4") String param4,
      );
}

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
