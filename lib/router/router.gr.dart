// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i15;

import '../model/meal.dart' as _i19;
import '../model/user.dart' as _i20;
import '../screens/add_meal.dart' as _i13;
import '../screens/chat.dart' as _i6;
import '../screens/client_list.dart' as _i9;
import '../screens/client_record.dart' as _i10;
import '../screens/diary.dart' as _i12;
import '../screens/discussion_list.dart' as _i7;
import '../screens/document_list.dart' as _i8;
import '../screens/home.dart' as _i1;
import '../screens/login.dart' as _i2;
import '../screens/profile.dart' as _i5;
import '../screens/register.dart' as _i3;
import '../screens/update_client_record.dart' as _i11;
import 'auth_gard.dart' as _i16;
import 'chat_guard.dart' as _i17;
import 'home_guard.dart' as _i18;

class AppRouter extends _i14.RootStackRouter {
  AppRouter(
      {_i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.chatGuard,
      required this.homeGuard})
      : super(navigatorKey);

  final _i16.AuthGuard authGuard;

  final _i17.ChatGuard chatGuard;

  final _i18.HomeGuard homeGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreen());
    },
    ChatRouterPage.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    MainRouterPage.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ProfileScreen());
    },
    ChatScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatScreen());
    },
    DiscussionListScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.DiscussionListScreen());
    },
    DocumentListScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DocumentListScreen());
    },
    ClientListRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    DiaryRouterPage.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ClientListScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ClientListScreen());
    },
    ClientRecordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ClientRecordScreenRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.ClientRecordScreen(user: args.user, key: args.key));
    },
    UpdateClientRecordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateClientRecordScreenRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.UpdateClientRecordScreen(user: args.user, key: args.key));
    },
    DiaryScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.DiaryScreen());
    },
    AddMealScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddMealScreenRouteArgs>();
      return _i14.MaterialPageX<_i19.Meal?>(
          routeData: routeData,
          child: _i13.AddMealScreen(day: args.day, key: args.key));
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i14.RouteConfig(HomeScreenRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i14.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'diary',
              fullMatch: true),
          _i14.RouteConfig(ChatRouterPage.name,
              path: 'chat',
              parent: HomeScreenRoute.name,
              children: [
                _i14.RouteConfig('#redirect',
                    path: '',
                    parent: ChatRouterPage.name,
                    redirectTo: 'chats',
                    fullMatch: true),
                _i14.RouteConfig(ChatScreenRoute.name,
                    path: 'onechat', parent: ChatRouterPage.name),
                _i14.RouteConfig(DiscussionListScreenRoute.name,
                    path: 'chats',
                    parent: ChatRouterPage.name,
                    guards: [chatGuard]),
                _i14.RouteConfig(DocumentListScreenRoute.name,
                    path: 'documents', parent: ChatRouterPage.name)
              ]),
          _i14.RouteConfig(MainRouterPage.name,
              path: 'main',
              parent: HomeScreenRoute.name,
              children: [
                _i14.RouteConfig('#redirect',
                    path: '',
                    parent: MainRouterPage.name,
                    redirectTo: 'clients',
                    fullMatch: true),
                _i14.RouteConfig(ClientListRouter.name,
                    path: 'clients',
                    parent: MainRouterPage.name,
                    guards: [
                      homeGuard
                    ],
                    children: [
                      _i14.RouteConfig(ClientListScreenRoute.name,
                          path: '', parent: ClientListRouter.name),
                      _i14.RouteConfig(ClientRecordScreenRoute.name,
                          path: 'record', parent: ClientListRouter.name),
                      _i14.RouteConfig(UpdateClientRecordScreenRoute.name,
                          path: 'update', parent: ClientListRouter.name)
                    ]),
                _i14.RouteConfig(DiaryRouterPage.name,
                    path: 'diary',
                    parent: MainRouterPage.name,
                    children: [
                      _i14.RouteConfig(DiaryScreenRoute.name,
                          path: '', parent: DiaryRouterPage.name),
                      _i14.RouteConfig(AddMealScreenRoute.name,
                          path: 'add', parent: DiaryRouterPage.name)
                    ])
              ]),
          _i14.RouteConfig(ProfileScreenRoute.name,
              path: 'my', parent: HomeScreenRoute.name)
        ]),
        _i14.RouteConfig(LoginScreenRoute.name, path: '/login'),
        _i14.RouteConfig(RegisterScreenRoute.name, path: '/register'),
        _i14.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home/diary', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i14.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i14.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i14.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: '/login');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterScreenRoute extends _i14.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(RegisterScreenRoute.name, path: '/register');

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ChatRouterPage extends _i14.PageRouteInfo<void> {
  const ChatRouterPage({List<_i14.PageRouteInfo>? children})
      : super(ChatRouterPage.name, path: 'chat', initialChildren: children);

  static const String name = 'ChatRouterPage';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class MainRouterPage extends _i14.PageRouteInfo<void> {
  const MainRouterPage({List<_i14.PageRouteInfo>? children})
      : super(MainRouterPage.name, path: 'main', initialChildren: children);

  static const String name = 'MainRouterPage';
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileScreenRoute extends _i14.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'my');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i6.ChatScreen]
class ChatScreenRoute extends _i14.PageRouteInfo<void> {
  const ChatScreenRoute() : super(ChatScreenRoute.name, path: 'onechat');

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i7.DiscussionListScreen]
class DiscussionListScreenRoute extends _i14.PageRouteInfo<void> {
  const DiscussionListScreenRoute()
      : super(DiscussionListScreenRoute.name, path: 'chats');

  static const String name = 'DiscussionListScreenRoute';
}

/// generated route for
/// [_i8.DocumentListScreen]
class DocumentListScreenRoute extends _i14.PageRouteInfo<void> {
  const DocumentListScreenRoute()
      : super(DocumentListScreenRoute.name, path: 'documents');

  static const String name = 'DocumentListScreenRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClientListRouter extends _i14.PageRouteInfo<void> {
  const ClientListRouter({List<_i14.PageRouteInfo>? children})
      : super(ClientListRouter.name,
            path: 'clients', initialChildren: children);

  static const String name = 'ClientListRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class DiaryRouterPage extends _i14.PageRouteInfo<void> {
  const DiaryRouterPage({List<_i14.PageRouteInfo>? children})
      : super(DiaryRouterPage.name, path: 'diary', initialChildren: children);

  static const String name = 'DiaryRouterPage';
}

/// generated route for
/// [_i9.ClientListScreen]
class ClientListScreenRoute extends _i14.PageRouteInfo<void> {
  const ClientListScreenRoute() : super(ClientListScreenRoute.name, path: '');

  static const String name = 'ClientListScreenRoute';
}

/// generated route for
/// [_i10.ClientRecordScreen]
class ClientRecordScreenRoute
    extends _i14.PageRouteInfo<ClientRecordScreenRouteArgs> {
  ClientRecordScreenRoute({required _i20.User user, _i15.Key? key})
      : super(ClientRecordScreenRoute.name,
            path: 'record',
            args: ClientRecordScreenRouteArgs(user: user, key: key));

  static const String name = 'ClientRecordScreenRoute';
}

class ClientRecordScreenRouteArgs {
  const ClientRecordScreenRouteArgs({required this.user, this.key});

  final _i20.User user;

  final _i15.Key? key;

  @override
  String toString() {
    return 'ClientRecordScreenRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i11.UpdateClientRecordScreen]
class UpdateClientRecordScreenRoute
    extends _i14.PageRouteInfo<UpdateClientRecordScreenRouteArgs> {
  UpdateClientRecordScreenRoute({required dynamic user, _i15.Key? key})
      : super(UpdateClientRecordScreenRoute.name,
            path: 'update',
            args: UpdateClientRecordScreenRouteArgs(user: user, key: key));

  static const String name = 'UpdateClientRecordScreenRoute';
}

class UpdateClientRecordScreenRouteArgs {
  const UpdateClientRecordScreenRouteArgs({required this.user, this.key});

  final dynamic user;

  final _i15.Key? key;

  @override
  String toString() {
    return 'UpdateClientRecordScreenRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [_i12.DiaryScreen]
class DiaryScreenRoute extends _i14.PageRouteInfo<void> {
  const DiaryScreenRoute() : super(DiaryScreenRoute.name, path: '');

  static const String name = 'DiaryScreenRoute';
}

/// generated route for
/// [_i13.AddMealScreen]
class AddMealScreenRoute extends _i14.PageRouteInfo<AddMealScreenRouteArgs> {
  AddMealScreenRoute({required DateTime day, _i15.Key? key})
      : super(AddMealScreenRoute.name,
            path: 'add', args: AddMealScreenRouteArgs(day: day, key: key));

  static const String name = 'AddMealScreenRoute';
}

class AddMealScreenRouteArgs {
  const AddMealScreenRouteArgs({required this.day, this.key});

  final DateTime day;

  final _i15.Key? key;

  @override
  String toString() {
    return 'AddMealScreenRouteArgs{day: $day, key: $key}';
  }
}
