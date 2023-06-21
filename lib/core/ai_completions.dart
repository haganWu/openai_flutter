import 'package:openai_flutter/core/interfaces/ai_create.dart';
import 'package:openai_flutter/http/ai_config.dart';
import 'package:openai_flutter/http/ai_http.dart';
import 'package:openai_flutter/model/ai_response.dart';

/// 请求参数说明
/// model：string类型，必选
/// 是用于会话的模型的 ID。
/// 你可以使用 ·https://api.openai.com/v1/models 接口来获取可用模型的列表，或者访问 Models Overview ·https://platform.openai.com/docs/models/overview`页面。
/// messages：必选，array类型
/// 到目前为止描述对话的消息列表，如：[{"role": "user", "content": "你几岁"}]
/// role：string类型，必选
/// 消息作者的角色，从 system, user, assistant三选一。
/// content：string类型，必选
/// 消息的内容。
/// name：string类型，可选
/// 此消息作者的姓名。 可以包含 a-z、A-Z、0-9 和下划线，最大长度为 64 个字符。
/// max_tokens：integer类型，可选
/// 生成结论能够使用的最大Token数，数值越大返回的内容越长，但生成速度也就越慢。
/// temperature： number类型，可选，默认值 1
/// 用来控制生成结论的随机性，介于 0 和 2 之间。数值越高越随机（如 0.8），数值越低约不随机（如 0.2），如果你想让结论更集中和确定性可以将数值调小。
/// top_p： number类型，可选，默认值 1
/// 是与temperature采样相对应的另一种方法，称为核心采样，模型会考虑具有前 top_p 概率质量的令牌的结果。因此，0.1 表示仅考虑组成前 10% 概率质量的令牌。
/// n： integer类型，可选，默认值 1
/// 定义每个提示要生成的结论数量。
/// stop： string 或 array类型，可选，默认值 null
/// 可以理解为结束标识符，是一个包含最多 4 个序列的列表，API 将停止生成进一步的token。返回的文本将不包含停止序列。
/// user： string类型，可选
/// 一个表示你最终用户的唯一标识符，可以帮助OpenAI监控和检测滥用行为。

class AiCompletions implements AiCreateInterface {
  @override
  Future<AiResponse> createChat({
    String model = 'gpt-3.5-turbo',
    prompt,
    int? maxTokens = 200,
    double? temperature,
    double? topP,
    int? n,
    String? stop,
    String? user,
  }) async {
    // 通过断言检查参数的合法性，是封装SDK常用的工具
    assert(prompt is String, "prompt field must be a String");
    return await AiHttp.post(
      url: AiConfigBuilder.instance.chatUrl,
      onSuccess: (Map<String, dynamic> response) {
        return AiResponse.fromJson(response);
      },
      body: {
        "model": model,
        if (prompt != null)
          "messages": [
            {"role": "user", "content": prompt}
          ],
        if (maxTokens != null) "max_tokens": maxTokens,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (stop != null) "stop": stop,
        if (user != null) "user": user,
      },
    );
  }
}
