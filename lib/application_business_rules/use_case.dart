import 'dart:math';

import 'package:flutter_demo/interface_adapters/presenter.dart';

class UseCase {
  Presenter _presenter;

  UseCase(this._presenter);

  void execute() {
    _presenter.present(Random().nextInt(100).toString());
  }
}
