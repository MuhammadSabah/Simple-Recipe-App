import 'package:FoodRecipeApp/navigation/app_route_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(
    const FoodRecipeApp(),
  );
}

class FoodRecipeApp extends StatefulWidget {
  const FoodRecipeApp({Key? key}) : super(key: key);

  @override
  _FoodRecipeAppState createState() => _FoodRecipeAppState();
}

class _FoodRecipeAppState extends State<FoodRecipeApp> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  final routeParser = AppRouteParser();

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _groceryManager),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        )
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme,
            title: 'FoodRecipe',
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: routeParser,
            routerDelegate: _appRouter,
          );
        },
      ),
    );
  }
}
