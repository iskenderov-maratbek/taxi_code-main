class ProviderCodes {
  final Set<String> codes = {'55', '75', '99', '50', '70', '77', '22'};

  bool checkCode(code) {
    return codes.contains(code);
  }
}
