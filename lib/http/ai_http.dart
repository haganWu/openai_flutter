import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:openai_flutter/http/ai_config.dart';
import 'package:openai_flutter/http/ai_exception.dart';
import 'package:openai_flutter/utils/ai_logger.dart';

class AiHttp {
  static Future<T> post<T>({
    required String url,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
  }) async {
    AiLogger.log(message: 'Starting request to $url', tag: 'AiHttp');
    // 借助HttpClient发送请求
    HttpClient httpClient = HttpClient();
    // 设置代理
    var proxy = AiConfigBuilder.instance.proxy;
    if (proxy != null && proxy.trim().isNotEmpty) {
      httpClient.findProxy = (uri) {
        return "PROXY $proxy";
      };
    }
    IOClient myClient = IOClient(httpClient);
    final http.Response response = await myClient.post(Uri.parse(url), body: body != null ? jsonEncode(body) : null);
    AiLogger.log(message: 'request to $url finished with status code: ${response.statusCode}', tag: 'AiHttp');
    AiLogger.log(message: 'Starting decoding response body', tag: 'AiHttp');
    // 防止乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();
    final Map<String, dynamic> decodedBody = jsonDecode(utf8decoder.convert(response.bodyBytes)) as Map<String, dynamic>;
    AiLogger.log(message: 'response body decoded successfully', tag: 'AiHttp');
    if (decodedBody['error'] != null) {
      AiLogger.log(message: 'an error occurred, throwing exception', tag: 'AiHttp');
      final Map<String, dynamic> error = decodedBody['error'];
      throw AiRequestException(error['message'], response.statusCode);
    } else {
      AiLogger.log(message: 'request finished successfully', tag: 'AiHttp');
      return onSuccess(decodedBody);
    }
  }
}
