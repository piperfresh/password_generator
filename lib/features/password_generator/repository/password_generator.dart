import 'dart:math';

class PasswordGenerator {
  static const String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static const String lowercase = "abcdefghijklmnopqrstuvwxyz";
  static const String numbers = "0123456789";
  static const String symbols = "!@#\$%^&*()_+{}[]|\\<>?";

  static String generatePassword({
    required int length,
    required bool includeUppercase,
    required bool includeLowercase,
    required bool includeNumber,
    required bool includeSymbol,
  }) {
    if (length <= 0) return '';

    String characterPool = '';
    if (includeUppercase) characterPool += uppercase;
    if (includeLowercase) characterPool += lowercase;
    if (includeNumber) characterPool += numbers;
    if (includeSymbol) characterPool += symbols;

    final random = Random.secure();

    /// Generate password
    final password = List.generate(
      length,
      (index) {
        return characterPool[random.nextInt(characterPool.length)];
      },
    ).join();

    // Ensure at least one character from each selected type is included
    if (!_validatePassword(
      password: password,
      includeUppercase: includeUppercase,
      includeLowercase: includeLowercase,
      includeNumbers: includeNumber,
      includeSymbols: includeSymbol,
    )) {
      // If validation fails, generate a new password recursively
      return generatePassword(
        length: length,
        includeUppercase: includeUppercase,
        includeLowercase: includeLowercase,
        includeNumber: includeNumber,
        includeSymbol: includeSymbol,
      );
    }

    return password;
  }

  static bool _validatePassword({
    required String password,
    required bool includeUppercase,
    required bool includeLowercase,
    required bool includeNumbers,
    required bool includeSymbols,
  }) {
    if (includeUppercase && !password.contains(RegExp(r'[A-Z]'))) return false;
    if (includeLowercase && !password.contains(RegExp(r'[a-z]'))) return false;
    if (includeNumbers && !password.contains(RegExp(r'[0-9]'))) return false;
    if (includeSymbols &&
        !password.contains(RegExp(r'[!@#\$%^&*()_+\-=\[\]{}|;:,.<>?]'))) {
      return false;
    }
    return true;
  }

  static double calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;

    double strength = 0;

    /// Length contribution (up to 40 points)
    strength += min(password.length * 4, 40);

    // Character variety contribution (up to 60 points)
    if (password.contains(RegExp(r'[A-Z]'))) strength += 15;
    if (password.contains(RegExp(r'[a-z]'))) strength += 15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 15;
    if (password.contains(RegExp(r'[!@#\$%^&*()_+\-=\[\]{}|;:,.<>?]'))) {
      strength += 15;
    }

    return min(strength, 100);
  }
}
