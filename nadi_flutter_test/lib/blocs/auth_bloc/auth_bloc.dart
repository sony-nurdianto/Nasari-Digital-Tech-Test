import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          await _saveLoginStatus();
          emit(AuthSuccess());
        } catch (e) {
          emit(AuthFailure(
              error: 'Gagal login. Periksa kembali username dan password.'));
        }
      },
    );
  }


  Future<void> _saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', true);
  }
}
