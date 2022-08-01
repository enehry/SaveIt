import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/src/pages/challenges/create_challenge.dart';
import 'package:save_it/src/pages/challenges/challenge_history.dart';
import 'package:save_it/src/pages/challenges/edit_challenge.dart';
import 'package:save_it/src/pages/challenges/view_challenge.dart';
import 'package:save_it/src/pages/error/error_page.dart';
import 'package:save_it/src/pages/wrapper.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const Wrapper(),
    ),
    GoRoute(
      name: 'create-challenge',
      path: '/challenge/create',
      builder: (BuildContext context, GoRouterState state) =>
          const CreateChallenge(),
    ),
    GoRoute(
      name: 'view-challenge',
      path: '/challenge/view',
      builder: (BuildContext context, GoRouterState state) =>
          const ViewChallenge(),
    ),
    GoRoute(
      name: 'challenge-history',
      path: '/challenge/history',
      builder: (BuildContext context, GoRouterState state) =>
          const ChallengeHistory(),
    ),
    GoRoute(
      name: 'edit-challenge',
      path: '/challenge/edit',
      builder: (BuildContext context, GoRouterState state) =>
          const EditChallenge(),
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) {
    return ErrorPage(
      error: state.error,
    );
  },
);
