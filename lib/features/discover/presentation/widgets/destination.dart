import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';

class Destination extends StatelessWidget {
  final double? score;
  final String title;
  final String? duration;
  final GestureTapCallback? onTap;
  final String? image;

  const Destination({
    super.key,
    this.score,
    required this.title,
    this.duration,
    this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final hasMultipleImages = false; // This should come from the data

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: image != null && image!.isNotEmpty
                      ? Image.network(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
                      : Center(
                    child: Icon(
                      Icons.landscape,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              if (hasMultipleImages)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Image.asset("assets/icons/more-images.png"),
                ),
              if (score != null && score! > 0)
                Positioned(
                  left: 20,
                  top: 20,
                  child: Stars(score: score!/2),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (duration != null) ...[
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: 20,
                    child: Image.asset("assets/icons/airplane-mode.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "$duration heures",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ],
      ),
    );
  }
}