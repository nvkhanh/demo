import 'package:demo_bloc_marketplace/modules/login/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/HttpException.dart';

abstract class LoginEvent {}

class RequestLoginEvent extends LoginEvent {
  RequestLoginEvent(this.username, this.password);

  final String username;
  final String password;
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<RequestLoginEvent>((event, emit) => onRequestLoginEvent(event, emit));
  }

  onRequestLoginEvent(RequestLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await repository.login(event.username, event.password);
      emit(LoginSuccess(response.token));
    } on HttpException catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
