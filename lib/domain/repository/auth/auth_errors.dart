String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email or password invalid';

    case 'Invalid session token':
      return 'Invalid token';

    case 'INVALID_FULLNAME':
      return 'Error to signup user: Fullname requested';

    case 'INVALID_PHONE':
      return 'Error to signup user: Invalid Phone';

    case 'INVALID_CPF':
      return 'Error to signup user: Invalid CPF';

    default:
      return 'Something went wrong';
  }
}
