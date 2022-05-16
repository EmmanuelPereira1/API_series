class Result<T, E> {
  T? data;
  E? error;

  Result({this.data, this.error});


  bool get hasError => error != null;

}
