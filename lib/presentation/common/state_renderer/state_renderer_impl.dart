import 'package:app_with_clean_architecture/app/constants.dart';
import 'package:app_with_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// loading state (popup, full screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// loading state (popup, full screen)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state

class EmptySate extends FlowState {
  String message;

  EmptySate(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class SuccessfulState extends FlowState {
  String message;

  SuccessfulState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessfulState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          // show popup loading
          showPopup(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // full screen loading state
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      case SuccessfulState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupSuccessfulState) {
          // show popup loading
          showPopup(context, getStateRendererType(), getMessage(),
              title: AppStrings.success);
          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // full screen loading state
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      case EmptySate:
        return StateRenderer(
          retryActionFunction: () {},
          stateRendererType: getStateRendererType(),
          message: getMessage(),
        );
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = AppStrings.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          retryActionFunction: () {},
          message: message,
          title: title,
        ),
      ),
    );
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
