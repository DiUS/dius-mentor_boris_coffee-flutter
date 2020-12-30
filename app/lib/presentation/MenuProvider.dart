import 'package:flutter/foundation.dart';

import '../Response.dart';

class MenuUseCases extends ChangeNotifier {
  MenuUseCases() {
    fetchList();
  }

  Response<List<String>> /*?*/ _list;

  get list => _list;

  void fetchList() async {
    _list = Success(List.of(["tea", "choc"]));
    notifyListeners();
  }
}
