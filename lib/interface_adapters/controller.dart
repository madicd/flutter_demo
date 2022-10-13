import 'package:flutter_demo/application_business_rules/use_case.dart';

class Controller {
  UseCase _useCase;

  Controller(this._useCase);

  void handle() {
    _useCase.execute();
  }
}