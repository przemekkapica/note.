import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/data/repository/auth_repository.dart';
import 'package:note/data/repository/item_repository.dart';
import 'package:note/utils/constants.dart';
import 'package:note/data/model/entity/item.dart';
import 'package:note/data/service/auth_service.dart';
import 'package:note/data/service/item_service.dart';
import 'package:note/view/screens/add_item_screen.dart';
import 'package:note/view/screens/auth_screen.dart';
import 'package:note/view/screens/details_screen.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/screens/not_found_screen.dart';

class AppRouter {
  AppRouter() {
    authService = AuthService();
    itemService = ItemService();
    authRepository = AuthRepository(authService: authService);
    itemRepository = ItemRepository(itemService: itemService);
  }

  late AuthService authService;
  late ItemService itemService;

  late AuthRepository authRepository;
  late ItemRepository itemRepository;

  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case AUTH_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: AuthBloc(authRepository: authRepository),
            child: AuthScreen(),
          ),
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
              itemRepository: itemRepository, authRepository: authRepository),
        );
      case ADD_ITEM_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: AddItemBloc(itemRepository: itemRepository),
            child: AddItemScreen(authRepository: authRepository),
          ),
        );
      case ITEM_DETAILS_ROUTE:
        if (args is Item) {
          return MaterialPageRoute(
              builder: (_) =>
                  DetailsScreen(note: args, authRepository: authRepository));
        } else {
          return MaterialPageRoute(builder: (_) => NotFoundScreen());
        }
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }

  Route<dynamic> onUnknownRoute(_) => MaterialPageRoute(
        builder: (_) => NotFoundScreen(),
      );

  List<Route<dynamic>> onGenerateInitialRoutes(_) {
    if (authService.user != null) {
      return <Route>[
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            itemRepository: itemRepository,
            authRepository: authRepository,
          ),
        )
      ];
    } else {
      return <Route>[
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: AuthBloc(authRepository: authRepository),
            child: AuthScreen(),
          ),
        )
      ];
    }
  }
}
