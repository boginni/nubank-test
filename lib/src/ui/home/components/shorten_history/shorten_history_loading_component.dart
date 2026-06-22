import 'package:flutter/material.dart';

class ShortenHistoryLoadingComponent extends StatelessWidget {
  const ShortenHistoryLoadingComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const .symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemBuilder: (context, int index) {
              return const ListTile(
                title: Text('title'),
              );
            },
          ),
        ),
      ],
    );
  }
}
