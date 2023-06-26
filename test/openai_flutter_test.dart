import 'package:flutter_test/flutter_test.dart';
import 'package:openai_flutter/core/ai_completions.dart';
import 'package:openai_flutter/http/ai_config.dart';
import 'package:openai_flutter/utils/ai_logger.dart';

const apiKey = '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';
// const proxy = '198.18.0.1:7890';
const proxy = '10.1.37.84:7890';
void main() {
  test('test createChat', () async {
    AiConfigBuilder.init(apiKey: apiKey,proxy: proxy);
    var response = await AiCompletions().createChat(prompt: '讲个笑话',maxTokens: 1000);
    var choices = response.choices?.first;
    expect(choices?.message?.content, isNotEmpty);
    AiLogger.log(message: choices?.message?.content??'',tag: 'test createChat');

  });
}
