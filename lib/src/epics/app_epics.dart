import 'package:redux_epics/redux_epics.dart';

import '../actions/index.dart';
import '../data/unsplash_api.dart';
import '../models/index.dart';

class AppEpics implements EpicClass<AppState> {
  AppEpics(this._api);

  final UnsplashApi _api;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetImagesStart>(_getImagesStart).call,
    ])(actions, store);
  }

  Stream<GetImages> _getImagesStart(Stream<GetImagesStart> actions, EpicStore<AppState> store) {
    // return actions
    //         .asyncMap((GetImagesStart action) => _api.getPictures(action.page, action.searchText))
    //         .map((List<Picture> images) => GetImages.successful(images))
    //     .onErrorReturnWith((Object error, StackTrace stackTrace) => GetImages.error(error, stackTrace));

    return actions.asyncMap<GetImages>((GetImagesStart action) async {
      try {
        final List<Picture> images = await _api.getPictures(action.page, action.searchText);
        return GetImages.successfull(images);
      } catch (error, stackTrace) {
        return GetImages.error(error, stackTrace);
      }
    });
  }
}
