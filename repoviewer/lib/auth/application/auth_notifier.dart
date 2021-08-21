import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/domain/auth_failure.dart';
import 'package:repoviewer/auth/infrastructure/github_authenticator.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthSate with _$AuthSate {
  const AuthSate._();
  const factory AuthSate.initial() = _Initial;
  const factory AuthSate.unauthenticated() = _Unauthenticated;
  const factory AuthSate.authenticated() = _Authenticated;
  const factory AuthSate.failure(AuthFailure failure) = _Failure;
}

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

class AuthNotifier extends StateNotifier<AuthSate> {
  final GithubAuthenticator _authenticator;

  AuthNotifier(this._authenticator) : super(const AuthSate.initial());

  Future<void> checkAndUpdateAuthStatus() async {
    state = (await _authenticator.isSignedIn())
        ? const AuthSate.authenticated()
        : const AuthSate.unauthenticated();
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = _authenticator.createGrant();

    final redirectUrl =
        await authorizationCallback(_authenticator.getAuthorizationUrl(grant));

    final failureOrSuccess = await _authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );

    state = failureOrSuccess.fold(
      (failure) => AuthSate.failure(failure),
      (r) => const AuthSate.authenticated(),
    );

    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();
    state = failureOrSuccess.fold(
      (l) => AuthSate.failure(l),
      (r) => const AuthSate.unauthenticated(),
    );
  }
}
