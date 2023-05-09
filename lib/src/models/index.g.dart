// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Picture$ _$$Picture$FromJson(Map<String, dynamic> json) => _$Picture$(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      width: json['width'] as int,
      height: json['height'] as int,
      color: json['color'] as String,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      likes: json['likes'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Picture$ToJson(_$Picture$ instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'urls': instance.urls,
      'likes': instance.likes,
      'user': instance.user,
    };

_$Urls$ _$$Urls$FromJson(Map<String, dynamic> json) => _$Urls$(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
    );

Map<String, dynamic> _$$Urls$ToJson(_$Urls$ instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
    };

_$User$ _$$User$FromJson(Map<String, dynamic> json) => _$User$(
      id: json['id'] as String,
      updatedAt: json['updated_at'] as String?,
      username: json['username'] as String,
      name: json['name'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      twitterUsername: json['twitter_username'] as String?,
      portfolioUrl: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      profileImage:
          ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$User$ToJson(_$User$ instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'twitter_username': instance.twitterUsername,
      'portfolio_url': instance.portfolioUrl,
      'bio': instance.bio,
      'location': instance.location,
      'profile_image': instance.profileImage,
    };

_$ProfileImage$ _$$ProfileImage$FromJson(Map<String, dynamic> json) =>
    _$ProfileImage$(
      small: json['small'] as String,
      medium: json['medium'] as String,
      large: json['large'] as String,
    );

Map<String, dynamic> _$$ProfileImage$ToJson(_$ProfileImage$ instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

_$AppState$ _$$AppState$FromJson(Map<String, dynamic> json) => _$AppState$(
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Picture>[],
      page: json['page'] as int? ?? 1,
      isLoading: json['isLoading'] as bool? ?? false,
      hasMore: json['hasMore'] as bool? ?? true,
      searchText: json['searchText'] as String? ?? 'water',
      selectedPictureId: json['selectedPictureId'] as String?,
    );

Map<String, dynamic> _$$AppState$ToJson(_$AppState$ instance) =>
    <String, dynamic>{
      'images': instance.images,
      'page': instance.page,
      'isLoading': instance.isLoading,
      'hasMore': instance.hasMore,
      'searchText': instance.searchText,
      'selectedPictureId': instance.selectedPictureId,
    };
