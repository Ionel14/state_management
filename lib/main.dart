import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'src/actions/index.dart';
import 'src/data/unsplash_api.dart';
import 'src/epics/app_epics.dart';
import 'src/models/index.dart';
import 'src/presentation/home_page.dart';
import 'src/presentation/picture_details.dart';
import 'src/reducer/app_reducer.dart';

void main() {
  const String apiKey = 'TWH9m2FHZ67eO3jM8JiBEpDwjMRARj5UkpYr6EzVziM';
  final UnsplashApi api = UnsplashApi(apiKey);
  final AppEpics epic = AppEpics(api);
  final Store<AppState> store = Store<AppState>(reducer,
      initialState: const AppState(), middleware: <Middleware<AppState>>[EpicMiddleware<AppState>(epic.call).call]);

  store.dispatch(GetImages.start(store.state.page, store.state.searchText));

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        routes: <String, WidgetBuilder>{
          '/' : (BuildContext context) => const MyHomePage(),
          '/details' : (BuildContext context) => const PictureDetails(),
        },
      ),
    );
  }
}
