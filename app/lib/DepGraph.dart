import 'FutureResponse.dart';
import 'domain/MenuManager.dart';

class DepGraph {
  static final MenuManager _menuManager =
      MenuManager(() => FutureResponse(Future.value(["bonox", "gravox"])));

  static final UseCases useCases = UseCases(_menuManager);
}

class UseCases {
  final MenuManager _menuManager;

  UseCases(this._menuManager);

  FetchMenu get fetchMenu => () => _menuManager.list();
}
