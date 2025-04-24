bool isLoggedInUser = false;
const String baseUrlLogin = 'https://localhost:7260/api/Auth/login';
const String baseUrlRegister = 'https://localhost:7260/api/Auth/register';

class SharedPrefKeys {
  static const String userToken = 'userToken';
  //dart run build_runner build --delete-conflicting-outputs
}
