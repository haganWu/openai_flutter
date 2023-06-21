import '../../model/ai_response.dart';

abstract class AiCreateInterface {
  Future<AiResponse> createChat({
    String model = 'gpt-3.5-turbo',
    dynamic prompt,
    int? maxTokens = 200,
    double? temperature,
    double? topP,
    int? n,
    String? stop,
    String? user,
  });
}
