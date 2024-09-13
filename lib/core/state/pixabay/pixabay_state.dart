import 'package:pixabay_demo/core/models/pixabay_image.dart';

/// A event map for [PixabayState].
enum PixabayStateEvent {
  fetch,
  fetchMore,
}

class PixabayState {
  final List<PixabayImageModel> images;
  final Map<PixabayStateEvent, bool> loading;
  final Map<PixabayStateEvent, String?> error;

  const PixabayState({
    this.images = const [],
    this.loading = const {
      PixabayStateEvent.fetch: false,
      PixabayStateEvent.fetchMore: false,
    },
    this.error = const {},
  });

  PixabayState copyWith({
    List<PixabayImageModel>? images,
    (PixabayStateEvent, bool)? loading,
    (PixabayStateEvent, String?)? error,
  }) {
    final updatedLoading = Map<PixabayStateEvent, bool>.from(this.loading);
    final updatedError = Map<PixabayStateEvent, String?>.from(this.error);

    if (loading != null) updatedLoading[loading.$1] = loading.$2;
    if (error != null) updatedError[error.$1] = error.$2;
    return PixabayState(
      images: images ?? this.images,
      loading: updatedLoading,
      error: updatedError,
    );
  }
}
