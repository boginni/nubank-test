import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nu_assets/nu_assets.dart';

import '../../../domain/environment.dart';

class FaviconImage extends StatelessWidget {
  final String? url;
  final double size;

  const FaviconImage({
    super.key,
    this.url,
    this.size = 48.0,
  });

  String? getFavicon(
    String url, {
    int? size,
  }) {
    final trimmedUrl = url.trim();

    if (trimmedUrl.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(
      trimmedUrl.startsWith(RegExp('https?://'))
          ? trimmedUrl
          : 'https://$trimmedUrl',
    );

    final host = uri?.host;

    if (host == null) {
      return null;
    }

    final corsWrapperUri = Uri.tryParse(Environment.faviconProxy)?.replace(
      queryParameters: {
        'domain': host,
        'sz': ?size?.toString(),
      },
    );

    return corsWrapperUri?.toString();
  }

  @override
  Widget build(BuildContext context) {
    final favicon = getFavicon(
      url ?? '',
      size: size.toInt(),
    );

    if (favicon == null) {
      return const PlaceHolderImage();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.15),
      child: CachedNetworkImage(
        imageUrl: favicon,
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholder: (context, url) => SizedBox(
          width: size,
          height: size,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => PlaceHolderImage(
          size: size,
        ),
      ),
    );
  }
}

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      NuAssetsResources.placeholderImagePng,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
