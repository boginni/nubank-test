import 'package:flutter/material.dart';
import '../home_controller.dart';
import '../home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (controller.store.value is HomeStoreInitialState) {
          init();
        }
      },
    );
  }

  Future<void> init() async {
    await controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nu Test'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const .all(16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: TextFormField(),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverList.builder(
                itemBuilder: (context, int index) {
                  return const ListTile(
                    title: Text('title'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
