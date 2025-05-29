import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/daily_case.dart';

part 'legal_api_service.g.dart';

@RestApi(baseUrl: 'https://your-agent-engine-endpoint.googleapis.com')
abstract class LegalApiService {
  factory LegalApiService(Dio dio, {String baseUrl}) = _LegalApiService;

  @GET('/daily')
  Future<DailyCase> getDailyCase();

  @GET('/compare')
  Future<List<NewsComparison>> getNewsComparisons();

  @POST('/gacha')
  Future<GachaResult> getGachaResult(@Body() Map<String, dynamic> query);
}
