import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/view/home/components/ninja_star_shape.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: const Center(child: NinjaStarShape()));
  }
}
