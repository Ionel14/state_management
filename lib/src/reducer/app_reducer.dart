import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';

AppState reducer(AppState state, dynamic action) {
  if (kDebugMode) {
    print(action);
  }
  return _reducer(state, action);
}

Reducer<AppState> _reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetImagesStart>(_getImagesStart).call,
  TypedReducer<AppState, GetImagesSuccessful>(_getImagesSuccesful).call,
  TypedReducer<AppState, GetImagesError>(_getImagesError).call,
  TypedReducer<AppState, SetSelectedImage>(_setSelectedImage).call,
]);

AppState _getImagesStart(AppState state, GetImagesStart action) {
  return state.copyWith(
    isLoading: true,
    searchText: action.searchText,
    page: action.page,
  );
}

AppState _getImagesSuccesful(AppState state, GetImagesSuccessful action) {
  return state.copyWith(
    images: <Picture>[if (state.page != 1) ...state.images, ...action.images],
    isLoading: false,
    hasMore: action.images.isNotEmpty,
    page: state.page + 1,
  );
}

AppState _getImagesError(AppState state, GetImagesError action) {
  return state.copyWith(isLoading: false);
}

AppState _setSelectedImage(AppState state, SetSelectedImage action) {
  return state.copyWith(selectedPictureId: action.pictureId);
}
