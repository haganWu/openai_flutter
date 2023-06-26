import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openai_flutter/core/ai_completions.dart';
import 'package:openai_flutter/http/ai_config.dart';

const apiKey = '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';
const proxy = '10.1.37.84:51767';
void main() {
  test('test createChat', () async {
    AiConfigBuilder.init(apiKey: apiKey,proxy: proxy);
    var response = await AiCompletions().createChat(prompt: '基督山伯爵',maxTokens: 1000);
    var choices = response.choices?.first;
    expect(choices?.message?.content, isNotEmpty);
    debugPrint(choices?.message?.content??'');

  });
}
