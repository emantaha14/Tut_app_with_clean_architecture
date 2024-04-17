import 'dart:async';

import 'package:app_with_clean_architecture/domain/models.dart';
import 'package:app_with_clean_architecture/presentation/base/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  late final List<SliderObject> _list;
  int _currentIndex = 0;
  StreamController _streamController = StreamController<SliderViewObject>();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // view model start your job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int getNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex < 0) {
      previousIndex = _list.length;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  // onBoarding ViewModel inputs
  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  // onBoarding ViewModel outputs
  @override
  // TODO: implement outputSliderViewModel
  Stream<SliderViewObject> get outputSliderViewModel =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onBoarding private functions
  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingSubTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingSubTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingSubTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingSubTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];
}

// inputs mean that "Orders" that out view model will receive from view
mixin OnBoardingViewModelInputs {
  int getNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  // stream controller input
  Sink get inputSliderViewObject;
}

mixin OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewModel;
}
