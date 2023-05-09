part of 'index.dart';

class SelectedPictureContainer extends StatelessWidget {
  const SelectedPictureContainer({super.key, required this.builder});

  final ViewModelBuilder<Picture> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Picture>(
        builder: builder,
        converter: (Store<AppState> store) {
          return store.state.images.firstWhere((Picture element) => element.id == store.state.selectedPictureId);
        });
  }
}
