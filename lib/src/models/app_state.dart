part of 'index.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Picture>[]) List<Picture> images,
    @Default(1) int page,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    @Default('water') String searchText,
  }) = AppState$;

  factory AppState.fromJson(Map<dynamic, dynamic> json) => _$AppStateFromJson(Map<String, dynamic>.from(json));
}
