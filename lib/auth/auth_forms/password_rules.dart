Map<String, bool Function(String)> rules = {
  'Пароль должен содержать не менее 8 и не более 20 символов': (value) =>
      value.length >= 8 && value.length <= 20,
  'Только латицинские буквы, цифры и точку': (value) =>
      value.isNotEmpty && value.replaceAll(RegExp('[a-zA-Z0-9.]'), '') == '',
  'Хотя бы одну большую букву и цифру': (value) =>
      value.contains(RegExp('[a-z]')) && value.contains(RegExp('[0-9]')),
};
