import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/favorites/favorites_bloc.dart';
import 'presentation/blocs/location/location_bloc.dart';
import 'presentation/blocs/nearby_stops/nearby_stops_bloc.dart';
import 'presentation/pages/map_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<LocationBloc>()..add(const LocationRequested()),
        ),
        BlocProvider(create: (_) => getIt<NearbyStopsBloc>()),
        BlocProvider(
          create: (_) => getIt<FavoritesBloc>()..add(const FavoritesStarted()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const MapPage(),
      ),
    );
  }
}
