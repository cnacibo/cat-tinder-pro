import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../domain/entities/cat_image.dart';

class CatCard extends StatefulWidget {
  final CatImage catImage;
  final String? currentImageUrl;
  final Function(bool) onSwipe;
  final VoidCallback onTap;
  final VoidCallback onRetry; 

  const CatCard({
    super.key,
    required this.catImage,
    required this.currentImageUrl,
    required this.onSwipe,
    required this.onTap,
    required this.onRetry,
  });

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  double dragX = 0.0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            setLocalState(() {
              dragX += details.delta.dx;
            });
          },
          onHorizontalDragEnd: (details) {
            if (dragX > 120) {
              widget.onSwipe(true);
            } else if (dragX < -120) {
              widget.onSwipe(false);
            }
            setLocalState(() {
              dragX = 0;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..translate(dragX),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: InkWell(
                onTap: widget.onTap,
                child: Card(
                  key: ValueKey(widget.catImage.id),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      _buildCatImage(),
                      if (widget.catImage.breeds.isNotEmpty)
                        _buildBreedNameOverlay(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCatImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double minConstain = constraints.maxHeight < constraints.maxWidth
              ? constraints.maxHeight
              : constraints.maxWidth;
          final double imageSize = minConstain * 0.9;
          
          return SizedBox(
            width: imageSize,
            height: imageSize,
            child: CachedNetworkImage(
              imageUrl: widget.currentImageUrl ?? _generateCatUrl(),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.black.withOpacity(0.05),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, error, stackTrace) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.broken_image, size: 48, color: Colors.red),
                      const SizedBox(height: 8),
                      const Text('Error while loading the image...'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: widget.onRetry,
                        child: const Text('Try again!'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _generateCatUrl() {
    return 'https://cataas.com/cat?type=square&timestamp=${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget _buildBreedNameOverlay() {
    final breedName = widget.catImage.breeds.isNotEmpty
        ? widget.catImage.breeds.first.name
        : 'Неизвестная порода';

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.75), Colors.transparent],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          breedName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black45,
                offset: Offset(0, 1),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}