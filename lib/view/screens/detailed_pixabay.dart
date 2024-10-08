import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/models/pixabay_image.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';

class DetailedPixabay extends StatefulWidget {
  final PixabayImageModel image;
  const DetailedPixabay({super.key, required this.image});

  @override
  State<DetailedPixabay> createState() => _DetailedPixabayState();
}

class _DetailedPixabayState extends State<DetailedPixabay> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> segments = {
      0: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(context.fmt('card.section.photo-details')),
      ),
      1: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(context.fmt('card.section.author-stats')),
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.image.user),
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              widget.image.largeImageURL,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: SizedBox(
                width: 500,
                child: CupertinoSlidingSegmentedControl<int>(
                  padding: const EdgeInsets.all(0),
                  groupValue: _selectedSegment,
                  children: segments,
                  onValueChanged: (val) => setState(() => _selectedSegment = val!),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _selectedSegment == 0
                ? PhotoDetailsSection(image: widget.image)
                : AuthorStatsSection(image: widget.image),
          ),
        ],
      ),
    );
  }
}

class PhotoDetailsSection extends StatelessWidget {
  final PixabayImageModel image;
  const PhotoDetailsSection({super.key, required this.image});

  final style = const TextStyle(fontSize: 20, color: Colors.black87);
  final boldStyle =
      const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.fileImage, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.size')}: ', style: style),
                    TextSpan(text: '${image.imageSize} bytes', style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.fileCode, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.type')}: ', style: style),
                    TextSpan(text: image.type, style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.tags, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.tags')}: ', style: style),
                    TextSpan(text: image.tags, style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuthorStatsSection extends StatelessWidget {
  final PixabayImageModel image;
  const AuthorStatsSection({super.key, required this.image});

  final style = const TextStyle(fontSize: 20, color: Colors.black87);
  final boldStyle =
      const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.user, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.author')}: ', style: style),
                    TextSpan(text: image.user, style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.eye, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.views')}: ', style: style),
                    TextSpan(text: '${image.views}', style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.heart, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.likes')}: ', style: style),
                    TextSpan(text: '${image.likes}', style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.comment, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.comments')}: ', style: style),
                    TextSpan(text: '${image.comments}', style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.download, size: 16, color: AppColors.baseBlue),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.fmt('card.info.downloads')}: ', style: style),
                    TextSpan(text: '${image.downloads}', style: boldStyle),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
