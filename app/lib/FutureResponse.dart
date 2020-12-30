import 'Response.dart';

class FutureResponse<T> extends Response<T> {
  final Future<T> _future;

  FutureResponse(this._future);

  FutureResponse<B> map<B>(B func(T)) {
    try {
      return FutureResponse(_future
        .then((value) => func(value))
        .catchError((error) => throw Exception(error))
      );
    } catch (e) {
      return FutureResponse(Future.error(e));
    }
  }

  Future<Response<T>> get() async {
    try {
      return Success(await _future);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
