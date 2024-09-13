import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/models/pixabay_image.dart';
import 'package:pixabay_demo/view/screens/detailed_pixabay.dart';
import 'package:pixabay_demo/view/widgets/buttons/opacity_button.dart';

class PixabayImageCard extends StatelessWidget {
  final PixabayImageModel photo;
  const PixabayImageCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailedPixabay(image: photo);
      })),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            // Background image
            Image.network(
              photo.largeImageURL,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            // Dark gradient at the bottom for text readability
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Information displayed on the image
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo.user,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    photo.tags,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Top left icon and label
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.heart, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${photo.likes} ${context.fmt('card.info.likes')}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
