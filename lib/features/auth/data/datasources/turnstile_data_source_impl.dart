import 'package:cloudflare_turnstile/cloudflare_turnstile.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/turnstile_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TurnstileDataSource)
class TurnstileDataSourceImpl implements TurnstileDataSource {
  final String _siteKey = '0x4AAAAAACCZye9SN8aAiYqa';

  @override
  Future<String> getToken() async {
    final turnstile = CloudflareTurnstile.invisible(siteKey: _siteKey);

    try {
      final token = await turnstile.getToken();
      if (token == null) {
        throw ServerException(message: "No cloudflare token");
      }
      return token;
    } on TurnstileException catch (e) {
      // Convert the package-specific exception to our app's domain exception
      throw TurnstileException(e.message);
    } finally {
      // Ensure the Turnstile instance is properly disposed of
      turnstile.dispose();
    }
  }
}
