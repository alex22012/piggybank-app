class Controller {
  static bool validateData(String name, String email, String cpf) {
    if (name != "" && name.length >= 3) {
      if (email != "" && email.length >= 13) {
        if (cpf != "" && cpf.length >= 11) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static bool validatePassword(String password) {
    String simbol = "";
    if (password.length < 8) {
      return false;
    }
    for (int i = 0; i < password.length; i++) {
      simbol = password[i];
      if (i != (password.length - 1)) {
        if (password[i + 1] == simbol) {
          return false;
        }
      }
    }
    return true;
  }

  static bool validateTransferData(
      String agency, String account, double amount) {
    if (agency.length >= 5 && account.length >= 6 && amount > 0) {
      return true;
    } else {
      return false;
    }
  }
}
