import '../../../../core/network/api_client.dart';
import '../../../../core/config/api_endpoints.dart';
import '../models/prompt_model.dart';

class SpeechRemoteDs {
  final ApiClient api;
  SpeechRemoteDs(this.api);

  Future<List<PromptModel>> fetchPrompts({String lang = "en"}) async {
    final data = await api.get(ApiEndpoints.prompts, query: {"lang": lang});
    return (data as List).map((e) => PromptModel.fromJson(e)).toList();
  }

  Future<void> submitAttempt(Map<String, dynamic> payload) async {
    await api.post(ApiEndpoints.submitAttempt, data: payload);
  }
}
