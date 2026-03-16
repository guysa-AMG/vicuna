import 'package:firebase_auth/firebase_auth.dart';

abstract class Authenticationstate {}

class InitialAuthenticationState extends Authenticationstate {}

class LoadingAuthenticationState extends Authenticationstate {}

class SuccessFullAuthenticationState extends Authenticationstate {
  User userCred;
  SuccessFullAuthenticationState({required this.userCred});
}

class ErrorAuthenticationState extends Authenticationstate {
  String message;
  ErrorAuthenticationState({required this.message});
}
