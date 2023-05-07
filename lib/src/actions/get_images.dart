part of 'index.dart';

@freezed
class GetImages with _$GetImages {
  const factory GetImages.start(int page, String searchText) = GetImagesStart;
  const factory GetImages.successfull(List<Picture> images) = GetImagesSuccessful;
  const factory GetImages.error(Object error, StackTrace stackTrace) = GetImagesError;
}
