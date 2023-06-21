import 'package:openai_flutter/http/ai_exception.dart';

/// SDK 配置工具类
class AiConfigBuilder {
  /// 开发者API Key，从https://platform.openai.com/account/api-keys上获取
  String? _apiKey;

  /// 注意：1、使用电脑的IP地址，不要用127.0.0.1（在Android上会被识别成Android设备的本地地址）
  /// 2、如果使用clashx需要开启Allow connect from Lan，否则会出现：Connection refused. eg: 192.168.1.150:7890
  String? _proxy;

  /// 开发者组织(可空)
  String? _organization;

  ///用于会话的接口地址，从https://platform.openai.com/docs/api-reference/chat 上获取
  late String _chatUrl;

  static final AiConfigBuilder _instance = AiConfigBuilder._();

  AiConfigBuilder._();

  static AiConfigBuilder get instance {
    if (_instance._apiKey == null || _instance._apiKey!.isEmpty) {
      throw AiException('Please call AiHeadersBuilder.init() first');
    }
    return _instance;
  }

  static void init({
    required String apiKey,
    String? organization,
    String? proxy,
    String chatUrl = 'https://api.openai.com/v1/chat/completions',
  }) {
    _instance._apiKey = apiKey;
    _instance._organization = organization;
    _instance._proxy = proxy;
    _instance._chatUrl = chatUrl;
  }

  Map<String, String> headers() {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    assert(_apiKey != null, "需要设置Api Key 才能发送请求");
    if(_organization != null) {
      headers['OpenAI-Organization'] = _organization!;
    }
    if(_apiKey?.startsWith('Bearer ')??false) {
      headers['Authorization:'] = _apiKey!;
    } else {
      headers['Authorization:'] = 'Bearer $_apiKey';
    }
    return headers;
  }


  String get chatUrl => _chatUrl;

  String? get proxy => _proxy;

  void setProxy(String? proxy) {
    _proxy = proxy;
  }
}
