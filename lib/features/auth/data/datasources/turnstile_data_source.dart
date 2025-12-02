abstract class TurnstileDataSource {
  /// Retrieves the CloudFlare Turnstile token.
  /// Throws a [TurnstileException] on failure.
  Future<String> getToken();
}
