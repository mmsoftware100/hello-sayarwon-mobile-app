import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleDescriptionShimmer extends StatelessWidget {
  const ArticleDescriptionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Text(
          "--------------\n${'█' * 1000}"
        )
      ),
    );
  }
}
