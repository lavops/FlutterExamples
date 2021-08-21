import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repoviewer/auth/domain/auth_failure.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthSate with _$AuthSate {
  const AuthSate._();
  const factory AuthSate.initial() = _Initial;
  const factory AuthSate.unauthenticated() = _Unauthenticated;
  const factory AuthSate.authenticated() = _Authenticated;
  const factory AuthSate.failure(AuthFailure failure) = _Failure;
}
