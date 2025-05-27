import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> profile;
  final double swipeProgress;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.swipeProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Profile image
          Image.network(
            profile['image'],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              //return const Center(child: CircularProgressIndicator());
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error, color: Colors.red, size: 50),
            ),
          ),
          // Gradient overlay for text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Profile details
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile['name']}, ${profile['age']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  profile['bio'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // LIKE/NOPE badges
          if (swipeProgress.abs() > 50)
            Positioned(
              top: 20,
              left: swipeProgress < 0 ? 20 : null,
              right: swipeProgress > 0 ? 20 : null,
              child: Transform.rotate(
                angle: swipeProgress < 0 ? -0.2 : 0.2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: swipeProgress > 0 ? Colors.green : Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Text(
                    swipeProgress > 0 ? 'LIKE' : 'NOPE',
                    style: TextStyle(
                      color: swipeProgress > 0 ? Colors.green : Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}