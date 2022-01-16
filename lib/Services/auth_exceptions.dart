class CustomAuthExceptions {
  Future handleAuthExceptions(code) async {
    print("Auth Exceptions handle Method is Called");
    String? errorMessage;
//The email address is badly formatted
    switch (code) {
      case "email-already-in-use":
        errorMessage = "Email Account Already Exists";
        break;
      case "invalid-email":
        errorMessage = "Please use a valid Email";
        break;
      case "weak-password":
        errorMessage = "Pasword is too weak";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    if (errorMessage.isNotEmpty) {
      print(errorMessage);
    }
  }
}
