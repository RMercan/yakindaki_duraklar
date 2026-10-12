import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorites/favorites_bloc.dart';
import '../widgets/stop_list_tile.dart';
import 'stop_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoriler')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.stops.isEmpty) {
            return const Center(child: Text('Henüz favori durak yok.'));
          }
          return ListView.builder(
            itemCount: state.stops.length,
            itemBuilder: (context, index) {
              final stop = state.stops[index];
              return StopListTile(
                stop: stop,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => StopDetailPage(stop: stop),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
