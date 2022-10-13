import 'package:flutter_demo/application_business_rules/cloud_gateway.dart';
import 'package:flutter_demo/main.dart';

class CloudGatewayImpl implements CloudGateway {
  @override
  Captcha loadCaptcha() {
    return Captcha('123213');
  }
}
