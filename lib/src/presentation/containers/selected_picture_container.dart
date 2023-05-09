part of 'index.dart';

class SelectedPictureContainer extends StatelessWidget {
  const SelectedPictureContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<Picture> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Picture>(
        builder: builder,
        converter: (Store<AppState> store) {
          return store.state.images.firstWhere((element) => element.id == store.state.selectedPictureId);
        }
    );
  }
}
