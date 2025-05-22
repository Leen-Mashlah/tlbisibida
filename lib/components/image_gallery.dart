import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart'; // Assuming cyan300 is defined here

class ImageGallery extends StatefulWidget {
  final List<String> imageUrls;
  final double mainImageHeight;
  final double thumbnailSize;
  final double thumbnailSpacing;
  final Color selectedBorderColor;

  const ImageGallery({
    super.key,
    required this.imageUrls,
    this.mainImageHeight = 300,
    this.thumbnailSize = 60,
    this.thumbnailSpacing = 4,
    this.selectedBorderColor = cyan200,
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
    return SizedBox.expand(
      // This makes the widget fill its parent in both width and height
      child: Column(
        mainAxisSize: MainAxisSize
            .max, // Ensures the column tries to take max vertical space
        children: [
          // Main image display with PageView for animation
          Expanded(
            // Allows the main image section to take available space
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 60,
                          color: cyan500,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: widget.thumbnailSize + 8,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls.length,
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
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image,
                              size: 18, color: cyan500);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
