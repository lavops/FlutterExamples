import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/application/auth_notifier.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/github_authenticator.dart';

final FlutterSecureStorageProvider =
    Provider((ref) => const FlutterSecureStorage());

final dioForAuthProvider = Provider((ref) => Dio());

final credentialsStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(ref.watch(FlutterSecureStorageProvider)),
);

final GithubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialsStorageProvider),
    ref.watch(dioForAuthProvider),
  ),
);

final AuthNotifierProvider = StateNotifierProvider<AuthNotifier, AuthSate>(
  (ref) => AuthNotifier(ref.watch(GithubAuthenticatorProvider)),
);
