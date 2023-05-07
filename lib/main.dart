import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'src/actions/index.dart';
import 'src/data/unsplash_api.dart';
import 'src/epics/app_epics.dart';
import 'src/models/index.dart';
import 'src/presentation/containers/index.dart';
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
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final Store<AppState> store = StoreProvider.of(context);
    final double offset = _controller.position.pixels;
    final double maxScrollExtend = _controller.position.maxScrollExtent;
    final double scrollableHeight = MediaQuery.of(context).size.height;

    if (store.state.hasMore && !store.state.isLoading && maxScrollExtend - offset < 3 * scrollableHeight) {
      store.dispatch(GetImagesStart(store.state.page, store.state.searchText));
    }
  }

  void _changeTheme(String theme) {
    final Store<AppState> store = StoreProvider.of(context);
    _controller.position.restoreOffset(0);
    store.dispatch(GetImagesStart(1, theme));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Pictures',
            ),
          ),
        ),
        body: IsLoadingContainer(
          builder: (BuildContext context, bool isLoading) {
            return ImagesContainer(builder: (BuildContext context, List<Picture> images) {
              if (isLoading && images.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (String value) {
                      if (value.length >= 3) {
                        _changeTheme(value);
                      }
                    },
                    style: const TextStyle(fontSize: 24, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: GridView.builder(
                      controller: _controller,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Picture picture = images[index];

                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            GridTile(
                              child: Image.network(
                                picture.urls.regular,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: AlignmentDirectional.bottomStart,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                      Colors.white54,
                                      Colors.transparent,
                                    ])),
                                child: ListTile(
                                  title: Text(picture.user.username),
                                  trailing: CircleAvatar(
                                    backgroundImage: NetworkImage(picture.user.profileImage.small),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                ],
              );
            });
          },
        ));
  }
}
