class CustomException implements Exception {
  final String _message;

  CustomException(this._message);

  String toString() {
    return _message;
  }
}
