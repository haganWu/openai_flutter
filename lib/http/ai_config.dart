/// SDK 配置工具类
class AiConfigBuilder {
  /// 注意：1、使用电脑的IP地址，不要用127.0.0.1（在Android上会被识别成Android设备的本地地址）
  /// 2、如果使用clashx需要开启Allow connect from Lan，否则会出现：Connection refused. eg: 192.168.1.150:7890
  String? _proxy;

  static final AiConfigBuilder _instance = AiConfigBuilder._();

  AiConfigBuilder._();

  static AiConfigBuilder get instance {
    return _instance;
  }

  static void init(String apiKey, String? proxy) {
    _instance._proxy = proxy;
  }

  String? get proxy => _proxy;

  void setProxy(String? proxy) {
    _proxy = proxy;
  }
}
