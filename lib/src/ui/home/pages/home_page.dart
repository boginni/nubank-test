import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:flutter/material.dart';

import '../../../domain/dto/entities/shortened_url_entity.dart';
import '../components/home_header_component.dart';
import '../components/shorten_history/shorten_history_empty_component.dart';
import '../components/shorten_history/shorten_history_failure_component.dart';
import '../components/shorten_history/shorten_history_success_component.dart';
import '../controllers/home_controller.dart';
import '../controllers/home_store.dart';
import '../controllers/shorten_history_store.dart';

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

  HomeStore get store => controller.store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        init();
      },
    );
  }

  Future<void> init() async {
    await controller.init();
  }

  void onShortenUrl() {
    final isValid = store.formKey.currentState?.validate() ?? false;
    if (isValid) {
      controller.shortenUrl(store.urlController.text);
    }
  }

  String? urlValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Url nao pode ser vazia';
    }

    return null;
  }

  String failureToString(Failure value) {
    if (value is ClientServerFailure) {
      return 'Url enviada eh invalida';
    }

    if (value is TimeoutFailure) {
      return 'Servidor n~ao respondeu';
    }

    return 'Erro desconhecido';
  }

  Future<void> onTapEntity(ShortenedUrlEntity entity) async {
    final result = await controller.runtimeRepository.copyToClipboard(
      entity.url,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.isFailure ? 'Erro Ao copiar url' : 'Url Copiada',
          ),
        ),
      );
    }

    if (result.isFailure) {
      result.failure.throwError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nu test'),
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          store,
          controller.shortenHistoryStore,
        ]),
        builder: (context, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: switch (store.state) {
                    HomeStoreLoadingState() => HomeHeaderComponent(
                      formKey: store.formKey,
                      urlController: store.urlController,
                      onShortenUrl: onShortenUrl,
                      validator: urlValidator,
                      isLoading: true,
                    ),
                    HomeStoreFailureState(:final failure) =>
                      HomeHeaderComponent(
                        formKey: store.formKey,
                        urlController: store.urlController,
                        onShortenUrl: () {
                          store.state = HomeStoreState.success();
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              onShortenUrl();
                            },
                          );
                        },
                        validator: urlValidator,
                        failureErrorText: failureToString(failure),
                      ),
                    HomeStoreSuccessState() => HomeHeaderComponent(
                      formKey: store.formKey,
                      urlController: store.urlController,
                      onShortenUrl: onShortenUrl,
                      validator: urlValidator,
                    ),
                  },
                ),
              ];
            },
            body: switch (controller.shortenHistoryStore.state) {
              ShortenHistoryStoreInitialState() => const Offstage(),
              ShortenHistoryStoreLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              ShortenHistoryStoreFailureState(:final failure) =>
                ShortenHistoryFailureComponent(
                  failure: failure,
                ),
              ShortenHistoryStoreSuccessState(:final entities) =>
                ShortenHistoryComponent(
                  entities: entities,
                  onTap: onTapEntity,
                ),
              ShortenHistoryStoreEmptyState() =>
                const ShortenHistoryEmptyComponent(),
            },
          );
        },
      ),
    );
  }
}
