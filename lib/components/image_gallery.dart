import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class ImageGallery extends StatefulWidget {
  final List<Uint8List> images;
  final double mainImageHeight;
  final double thumbnailSize;
  final double thumbnailSpacing;
  final Color selectedBorderColor;

  const ImageGallery({
    super.key,
    required this.images,
    this.mainImageHeight = 300,
    this.thumbnailSize = 60,
    this.thumbnailSpacing = 8,
    this.selectedBorderColor = cyan300,
  });

  @override
  ImageGalleryState createState() => ImageGalleryState();
}

class ImageGalleryState extends State<ImageGallery> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onThumbnailTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main image display with PageView for animation
        SizedBox(
          height: widget.mainImageHeight,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.memory(
                  widget.images[index],
                  fit: BoxFit.cover,
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes!
                  //           : null,
                  //     ),
                  //   );
                  // },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Thumbnail list
        SizedBox(
          height: widget.thumbnailSize + 8, // Extra space for border
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: widget.thumbnailSpacing),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () => _onThumbnailTap(index),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: widget.thumbnailSize,
                  height: widget.thumbnailSize,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(
                            color: widget.selectedBorderColor,
                            width: 3,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.memory(
                      widget.images[index],
                      fit: BoxFit.cover,
                      // loadingBuilder: (context, child, loadingProgress) {
                      //   if (loadingProgress == null) return child;
                      //   return const Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
