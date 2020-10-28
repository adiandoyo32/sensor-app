class Validation {
  String validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String validateLocation(String value) {
    if (value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone is required';
    }
    return null;
  }

  String validateWebsite(String value) {
    if (value.isEmpty) {
      return 'Webiste is required';
    }
    return null;
  }

  String validateCompany(String value) {
    if (value.isEmpty) {
      return 'Company is required';
    }
    return null;
  }
}
