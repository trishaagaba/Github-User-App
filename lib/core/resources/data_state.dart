//we are abt to communicate w network calls--using this wrapper class
// in order to det the state of the request being sent to the server and its response
// this wrapper class in important to wrap our network calls which is important when we have too many requests of logic

abstract class DataState<T>{
  final T ? data;
  final Exception ? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception error) : super(error: error);
}