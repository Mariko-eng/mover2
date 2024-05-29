class CustomResponse {
  final bool status;
  final String message;
  String? stackTrace;

  CustomResponse({required this.status, required this.message, this.stackTrace});
}