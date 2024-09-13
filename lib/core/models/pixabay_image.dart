class PixabayImageModel {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  const PixabayImageModel({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory PixabayImageModel.fromJson(Map<String, dynamic> data) {
    return PixabayImageModel(
      id: data['id'],
      pageURL: data['pageURL'],
      type: data['type'],
      tags: data['tags'],
      previewURL: data['previewURL'],
      previewWidth: data['previewWidth'],
      previewHeight: data['previewHeight'],
      webformatURL: data['webformatURL'],
      webformatWidth: data['webformatWidth'],
      webformatHeight: data['webformatHeight'],
      largeImageURL: data['largeImageURL'],
      imageWidth: data['imageWidth'],
      imageHeight: data['imageHeight'],
      imageSize: data['imageSize'],
      views: data['views'],
      downloads: data['downloads'],
      likes: data['likes'],
      comments: data['comments'],
      userId: data['user_id'],
      user: data['user'],
      userImageURL: data['userImageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageURL': pageURL,
      'type': type,
      'tags': tags,
      'previewURL': previewURL,
      'previewWidth': previewWidth,
      'previewHeight': previewHeight,
      'webformatURL': webformatURL,
      'webformatWidth': webformatWidth,
      'webformatHeight': webformatHeight,
      'largeImageURL': largeImageURL,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
      'imageSize': imageSize,
      'views': views,
      'downloads': downloads,
      'likes': likes,
      'comments': comments,
      'user_id': userId,
      'user': user,
      'userImageURL': userImageURL,
    };
  }
}
