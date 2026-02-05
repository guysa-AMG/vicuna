import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/states/authenticationState.dart';
import 'package:vicuna/services/repository/authentication.dart';
import 'package:vicuna/services/repository/localpref.dart';

class Authcontroller extends Cubit<Authenticationstate> {
  AuthRepo authRepo;
  LocalInstance prevState;
  Authcontroller({required this.prevState, required this.authRepo})
    : super(InitialAuthenticationState()) {
    if (authRepo.auth.currentUser != null) {
      emit(
        SuccessFullAuthenticationState(userCred: authRepo.auth.currentUser!),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoadingAuthenticationState());
    try {
      UserCredential usercred = await authRepo.googleSignIn();

      emit(SuccessFullAuthenticationState(userCred: usercred.user!));
    } catch (e) {
      emit(ErrorAuthenticationState(message: e.toString()));
    }
  }

  Future<void> logOut() async {
    bool ret = await authRepo.logOut();
    if (ret) {
      emit(InitialAuthenticationState());
    }
  }

  Future<void> signInWithFacebook() async {
    emit(LoadingAuthenticationState());
    try {
      UserCredential? usercred = await authRepo.facebookSignIn();
      if (usercred == null) {
        emit(ErrorAuthenticationState(message: "null occured somewhere"));
        return;
      } else {
        emit(SuccessFullAuthenticationState(userCred: usercred.user!));
      }
    } catch (e) {
      emit(ErrorAuthenticationState(message:e.toString()));
    }
  }
}
