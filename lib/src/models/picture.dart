part of 'index.dart';

@freezed
class Picture with _$Picture {
  const factory Picture({
    required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required int width,
    required int height,
    required String color,
    required Urls urls,
    required int likes,
    required User user,
  }) = Picture$;

  factory Picture.fromJson(Map<dynamic, dynamic> json) => _$PictureFromJson(Map<String, dynamic>.from(json));
}

@freezed
class Urls with _$Urls {
  const factory Urls({
    required String raw,
    required String full,
    required String regular,
    required String small,
  }) = Urls$;

  factory Urls.fromJson(Map<dynamic, dynamic> json) => _$UrlsFromJson(Map<String, dynamic>.from(json));
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    @JsonKey(name: 'updated_at') String? updatedAt,
    required String username,
    required String name,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'twitter_username') String? twitterUsername,
    @JsonKey(name: 'portfolio_url') String? portfolioUrl,
    String? bio,
    String? location,
    @JsonKey(name: 'profile_image') required ProfileImage profileImage,
  }) = User$;

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(Map<String, dynamic>.from(json));
}

@freezed
class ProfileImage with _$ProfileImage {
  const factory ProfileImage({
    required String small,
    required String medium,
    required String large,
  }) = ProfileImage$;

  factory ProfileImage.fromJson(Map<dynamic, dynamic> json) => _$ProfileImageFromJson(Map<String, dynamic>.from(json));
}
