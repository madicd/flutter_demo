import 'package:flutter/material.dart';
import 'package:flutter_demo/application_business_rules/cloud_gateway.dart';
import 'package:flutter_demo/application_business_rules/use_case.dart';
import 'package:flutter_demo/frameworks_and_drivers/cloud_gateway_impl.dart';
import 'package:flutter_demo/interface_adapters/controller.dart';
import 'package:flutter_demo/interface_adapters/presenter.dart';
import 'package:flutter_demo/interface_adapters/view_model_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class Model {
  String? firstName;
  Captcha? captcha;

  Model(this.firstName, this.captcha);

  Model copyWith(String firstName) {
    return Model(firstName, captcha);
  }
}

class Captcha {
  String? id;

  Captcha(this.id);
}

class ViewModel extends StateNotifier<Model> implements ViewModelNotifier {
  ViewModel(Captcha captcha) : super(Model('pera', captcha));

  @override
  update(String value) {
    state = state.copyWith(value);
  }
}

final cloudGatewayProvider = Provider<CloudGateway>((ref) => CloudGatewayImpl());

final viewModelProvider =
    StateNotifierProvider<ViewModel, Model>((ref) {
      print('viewModelProvider called');
     CloudGateway cloudGateway = ref.read(cloudGatewayProvider);
     var captcha = cloudGateway.loadCaptcha();
     return ViewModel(captcha);
    });

final presenterProvider = Provider<Presenter>((ref) {
  ViewModel viewModel = ref.read(viewModelProvider.notifier);
  return Presenter(viewModel);
});

final useCaseProvider = Provider<UseCase>((ref) {
  Presenter presenter = ref.read(presenterProvider);
  return UseCase(presenter);
});

final controllerProvider = Provider<Controller>((ref) {
  UseCase useCase = ref.read(useCaseProvider);
  return Controller(useCase);
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Controller controller = ref.read(controllerProvider);
    Model model = ref.watch(viewModelProvider);

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Column(children: [
          TextFormField(),
          Text('${model.firstName}'),
          Text('Captcha ID ${model.captcha!.id}'),
          TextButton(
            onPressed: () {
              return controller.handle();
            },
            child: Text('Foo'),
          )
        ]),
      ),
    );
  }
}
