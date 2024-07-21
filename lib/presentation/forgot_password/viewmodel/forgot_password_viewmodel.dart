import 'dart:async';

import 'package:app_with_clean_architecture/domain/usecase/login_usecase.dart';
import 'package:app_with_clean_architecture/presentation/base/base_view_model.dart';
import 'package:app_with_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/functions.dart';
import '../../../domain/usecase/forgot_password_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  get outputIsEmailValid => null;

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(SuccessfulState(supportMessage));
    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  bool _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);

  forgotPassword();

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
