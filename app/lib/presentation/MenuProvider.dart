import 'package:flutter/foundation.dart';

import '../Response.dart';
import '../domain/MenuManager.dart';

class MenuUseCases extends ChangeNotifier {
  final FetchMenu _fetchMenu;

  MenuUseCases(this._fetchMenu) {
    fetchList();
  }

  Response<List<String>> /*?*/ _list;

  get list => _list;

  void fetchList() async {
    _list = await _fetchMenu().get();
    notifyListeners();
  }
}
