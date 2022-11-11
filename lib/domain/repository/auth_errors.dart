String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email or password invalid';

    case 'Invalid session token':
      return 'Invalid token';

    default:
      return 'Something went wrong';
  }
}
