/// A utility class that provides common validation methods for user input.
///
/// The [Validators] class includes static methods for validating email addresses,
/// passwords, and age input. These methods are designed to handle null inputs
/// gracefully and return `false` if the input is invalid.
class Validators {
  /// A regular expression for validating email addresses.
  ///
  /// This regular expression follows the general format of an email address and
  /// checks for a valid combination of characters before and after the '@' symbol,
  /// as well as a valid domain format.
  static final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  /// Validates if the [input] is a properly formatted email address.
  ///
  /// The method checks if the [input] matches the [emailRegExp] pattern.
  /// If the input is `null` or does not match the pattern, it returns `false`.
  ///
  /// [input]: The email address to validate.
  ///
  /// Returns: `true` if the [input] is a valid email address; otherwise `false`.
  static bool email(String? input) {
    if (input == null) return false;
    return emailRegExp.hasMatch(input);
  }

  /// Validates if the [input] is a password within the valid length range.
  ///
  /// The method checks if the [input] is between 6 and 12 characters long.
  /// If the input is `null` or does not meet the length requirements, it returns `false`.
  ///
  /// [input]: The password to validate.
  ///
  /// Returns: `true` if the [input] is a valid password; otherwise `false`.
  static bool password(String? input) {
    if (input == null) return false;
    return input.length >= 6 && input.length <= 12;
  }

  /// Validates if the [input] is a valid age within the allowed range (18 to 99).
  ///
  /// The method attempts to parse the [input] as an integer and checks if the
  /// parsed value falls within the range of 18 to 99, inclusive.
  /// If the input is `null` or cannot be parsed into a valid integer, it returns `false`.
  ///
  /// [input]: The age to validate, as a string.
  ///
  /// Returns: `true` if the [input] is a valid age; otherwise `false`.
  static bool age(String? input) {
    if (input == null) return false;
    final parsedInput = int.tryParse(input);
    if (parsedInput == null) return false;
    return parsedInput >= 18 && parsedInput <= 99;
  }
}
