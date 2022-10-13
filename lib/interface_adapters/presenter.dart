import 'package:flutter_demo/interface_adapters/view_model_notifier.dart';

class Presenter {
  ViewModelNotifier _viewModelNotifier;

  Presenter(this._viewModelNotifier);

  void present(String value) {
    _viewModelNotifier.update(value);
  }
}
