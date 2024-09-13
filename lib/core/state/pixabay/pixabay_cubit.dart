import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/models/pixabay_image.dart';
import 'package:pixabay_demo/core/repositories/pixabay_repository.dart';
import 'package:pixabay_demo/core/state/pixabay/pixabay_state.dart';

/// A Cubit class that handles the logic for fetching images from the Pixabay API.
/// It extends the `Cubit` class and manages the state of the Pixabay image list.
///
/// The cubit uses the `PixabayRepository` to interact with the API and
/// fetches images with pagination support. It handles loading, error, and data
/// management in the `PixabayState`.
class PixabayCubit extends Cubit<PixabayState> {
  /// An instance of the `PixabayRepository` fetched from the dependency injection container.
  final service = Injection.instance.get<PixabayRepository>();

  /// The delay duration after encountering an error, before resetting the error state.
  final resetDuration = const Duration(seconds: 1);

  /// Constructor for `PixabayCubit`. Initializes the cubit with an empty state
  /// and calls the `fetch` method to start loading images when the cubit is instantiated.
  PixabayCubit() : super(const PixabayState()) {
    fetch();
  }

  /// Fetches images from the Pixabay API, with optional support for pagination.
  ///
  /// If the current state contains no images, this method fetches the first page of results.
  /// Otherwise, it loads the next page based on the current number of images.
  ///
  /// The method emits the current state with updated loading and error indicators.
  /// After a successful fetch, the images are added to the state. If an error occurs,
  /// the error message is displayed briefly before being reset.
  ///
  /// Parameters:
  /// - [perPage]: The number of images to fetch per page (default is 10).
  Future<List<PixabayImageModel>> fetch({
    int perPage = 10,
  }) async {
    // Determine the event type (initial fetch or fetch more images)
    final event = state.images.isEmpty ? PixabayStateEvent.fetch : PixabayStateEvent.fetchMore;

    // Emit the loading state with the corresponding event
    emit(state.copyWith(loading: (event, true)));

    // Fetch images from the service
    final (images, error) = await service.getImages(
      perPage: perPage,
      page: state.images.isEmpty ? 1 : (state.images.length / perPage).round(),
    );

    // Handle any errors that occur during the fetch
    if (error != null) {
      emit(state.copyWith(error: (event, error.toString()), loading: (event, false)));

      // Brief delay before resetting the error state
      await Future.delayed(resetDuration);

      // Reset the error and stop loading
      emit(state.copyWith(error: (event, null), loading: (event, false)));
      return [];
    }

    // Add new images to the state and stop loading
    final stateImages = [...state.images, ...images!];
    emit(state.copyWith(images: stateImages, loading: (event, false), error: (event, null)));
    return stateImages;
  }
}
