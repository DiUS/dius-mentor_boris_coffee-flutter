import '../FutureResponse.dart';

typedef FutureResponse<List<String>> FetchMenu();

class MenuManager {
  final FetchMenu _fetchMenu;

  MenuManager(this._fetchMenu);

  FutureResponse<List<String>> list() => _fetchMenu();
}
