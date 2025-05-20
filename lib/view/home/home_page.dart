import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/home/components/ninja_star_shape.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/teeth_pattern.png',
                    ),

                    // fit: BoxFit.,
                    repeat: ImageRepeat.repeat),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cyan200,
                      cyan100,
                      cyan50,
                      Color.fromARGB(149, 229, 243, 241),
                      cyan50,
                      cyan100,
                      cyan200
                    ])),
            child: const Center(child: NinjaStarShape())));
  }
}
