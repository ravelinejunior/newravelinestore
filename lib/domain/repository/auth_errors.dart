String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email or password invalid';

    default:
      return 'Something went wrong';
  }
}
