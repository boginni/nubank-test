import 'home_store.dart';

class HomeController {
  final HomeStore store;

  const HomeController( {
    required this.store,
  });

  Future<void> load() async {
    store.state = HomeStoreState.loading();
  }
}
