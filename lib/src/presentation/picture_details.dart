import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import 'containers/index.dart';

class PictureDetails extends StatelessWidget {
  const PictureDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectedPictureContainer(builder: (BuildContext context, Picture picture) {
      return Scaffold(
        appBar: AppBar(
          title: Text(picture.user.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: picture.urls.regular,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: picture.user.profileImage.medium,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Text>[
                            Text(
                              'Likes: ${picture.likes}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Bio: ${picture.user.bio}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Location: ${picture.user.location}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
