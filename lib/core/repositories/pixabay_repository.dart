import 'package:pixabay_demo/core/models/pixabay_image.dart';

/// Abstract class defining the contract for Pixabay image operations.
///
/// This repository outlines the methods for retrieving images from Pixabay with pagination.
abstract class PixabayRepository {
  /// Fetches a list of images from Pixabay with pagination.
  ///
  /// Takes optional [page] and [perPage] parameters to control pagination.
  /// Returns a tuple with:
  /// - A list of [PixabayImageModel] if the request is successful,
  /// - An [Exception] in case of an error.
  Future<(List<PixabayImageModel>?, Exception?)> getImages({int page = 1, int perPage = 10});
}
