

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import 'containers/index.dart';

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
                      hintText: 'Search term',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (String value) {
                      if (value.isEmpty) {
                        return;
                      }
                      _changeTheme(value);
                    },
                    style: const TextStyle(fontSize: 24, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: GridView.builder(
                      controller: _controller,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Picture picture = images[index];

                        return GestureDetector(
                          onTap: (){
                            StoreProvider.of<AppState>(context).dispatch(SetSelectedImage(picture.id));
                            Navigator.pushNamed(context, '/details');
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              GridTile(
                                child: CachedNetworkImage(
                                  imageUrl: picture.urls.regular,
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
                          ),
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