import 'package:dio/dio.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/models/pixabay_image.dart';
import 'package:pixabay_demo/core/repositories/pixabay_repository.dart';

/// A service that implements the [PixabayRepository] interface
/// to handle the retrieval of images from the Pixabay API, including pagination.
class PixabayService implements PixabayRepository {
  final dio = Injection.instance.get<Dio>();

  @override
  Future<(List<PixabayImageModel>?, Exception?)> getImages({int page = 1, int perPage = 20}) async {
    try {
      final response = await dio.get(
        '/api/',
        queryParameters: {
          'image_type': 'photo',
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> hits = data['hits'];
        final images = hits.map((hit) => PixabayImageModel.fromJson(hit)).toList();
        return (images, null);
      } else {
        return (null, Exception("Failed to fetch images. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      return (null, Exception("An error occurred while fetching images: $e"));
    }
  }
}
