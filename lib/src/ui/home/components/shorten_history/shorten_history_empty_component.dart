import 'package:flutter/material.dart';

class ShortenHistoryEmptyComponent extends StatelessWidget {
  const ShortenHistoryEmptyComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Text('Empty'),
          ),
        ),
      ],
    );
  }
}
