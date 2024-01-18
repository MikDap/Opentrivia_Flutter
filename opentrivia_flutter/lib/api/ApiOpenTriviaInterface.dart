import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'Domanda.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ApiOpenTriviaInterface.g.dart';

@RestApi(baseUrl: "https://opentdb.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) =_RestClient;

  @GET("/api.php")
  Future<OpenTriviaResponse> getTriviaQuestion(
      @Query("amount") int amount,
      @Query("category") int category,
      @Query("difficulty") String difficulty,
      @Query("type") String type
      );
}

@JsonSerializable()
class OpenTriviaResponse {
  const OpenTriviaResponse({this.response_code, this.results});

  factory OpenTriviaResponse.fromJson(Map<String, dynamic> json) => _$OpenTriviaResponseFromJson(json);

  final int? response_code;
  final List<Domanda>? results;

  Map<String, dynamic> toJson() => _$OpenTriviaResponseToJson(this);
}

