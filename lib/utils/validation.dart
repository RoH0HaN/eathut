String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (emailRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter a valid email';
  }
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  final phoneRegex = RegExp(r'^\d{10}$');
  if (phoneRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter a valid phone number';
  }
}

String? validateString(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter something';
  } else {
    return null;
  }
}

String? validatePostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a postal code';
  }
  final postalCodeRegex = RegExp(r'^[0-9]{4,9}$');
  if (postalCodeRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter a valid postal code';
  }
}

String? validateDouble(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  final doubleRegex = RegExp(r'^-?\d+(\.\d+)?$');
  if (doubleRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter a valid number';
  }
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  final numberRegex = RegExp(r'^-?\d+$');
  if (numberRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter a valid number';
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty || value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (passwordRegex.hasMatch(value)) {
    return null;
  } else {
    return 'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character';
  }
}
