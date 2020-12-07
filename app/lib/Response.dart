class Error<T> extends Response<T> {
  final String message;
  Error(this.message);
}

class Failure<T> extends Response<T> {
  final String message;
  final FailureCategory status;
  Failure(this.message, this.status);
}

class Success<T> extends Response<T> {
  final T body;
  Success(this.body);
}

enum FailureCategory {
  Unknown
}

abstract class Response<A> {
  Response<B> map<B>(B func(A)) {
    switch (this.runtimeType) {
      case Error: return Error((this as Error).message);
      case Failure: return Failure((this as Failure).message, (this as Failure).status);
      case Success: try {
        return Success(func((this as Success).body));
      } catch (ex) {
        return Error("${(this as Success).body} -> ${B.runtimeType}:\n\n$ex");
      }
    }
    throw Exception("Unfortunately, the compiler cannot yet prove the switch is exhaustive.");
  }

  Response<B> flatMap<B>(Response<B> func(A)) {
    return map(func).flatten();
  }
}

extension Nested<T> on Response<Response<T>> {
  Response<T> flatten() {
    switch (this.runtimeType) {
      case Error: return Error((this as Error).message);
      case Failure: return Failure((this as Failure).message, (this as Failure).status);
      case Success:
        final body = (this as Success).body;
        switch (body) {
          case Error: return Error((body as Error).message);
          case Failure: return Failure((body as Failure).message, body.status);
          case Success: return Success(body.body);
        }
    }
    throw Exception("Unfortunately, the compiler cannot yet prove the switch is exhaustive.");
  }
}
