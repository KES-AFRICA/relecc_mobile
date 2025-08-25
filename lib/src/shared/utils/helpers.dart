class Helpers{
  /// Extrait tous les chiffres d'une chaîne de caractères et les retourne sous forme d'entier
  /// Si aucun chiffre n'est trouvé, retourne null
  int? extractNumberFromString(String input) {
    // Expression régulière pour trouver tous les chiffres dans la chaîne
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(input);

    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return null;
  }

  /// Version alternative qui retourne tous les chiffres sous forme de String
  String extractAllDigits(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Version qui retourne une liste de tous les nombres trouvés
  List<int> extractAllNumbers(String input) {
    final regex = RegExp(r'\d+');
    return regex
        .allMatches(input)
        .map((match) => int.parse(match.group(0)!))
        .toList();
  }
}