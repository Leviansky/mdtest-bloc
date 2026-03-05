bool isValidEmail(String email) {
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
}

String replaceException(String message) {
  return message.toString().replaceAll("Exception: ", "");
}
