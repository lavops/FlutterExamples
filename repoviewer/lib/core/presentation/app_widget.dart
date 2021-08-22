import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/application/auth_notifier.dart';
import 'package:repoviewer/auth/shared/providers.dart';
import 'package:repoviewer/core/presentation/routes/app_router.gr.dart';

final initializationProvider = FutureProvider<Unit>((ref) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  await authNotifier.checkAndUpdateAuthStatus();
  return unit;
});

class AppWidget extends StatelessWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: initializationProvider,
      onChange: (context, value) {},
      child: ProviderListener<AuthSate>(
        provider: authNotifierProvider,
        onChange: (context, state) {
          state.maybeMap(
            orElse: () {},
            authenticated: (_) {
              appRouter.pushAndPopUntil(
                const StarredReposRoute(),
                predicate: (route) => false,
              );
            },
            unauthenticated: (_) {
              appRouter.pushAndPopUntil(
                const SignInRoute(),
                predicate: (route) => false,
              );
            },
          );
        },
        child: MaterialApp.router(
          title: 'Repo Viewer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
        ),
      ),
    );
  }
}
