import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2023/screens/card_screen.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({super.key});

  final data = [
    ItemCardData(
        title: "Four Sword",
        subtitle: "The most powerful sword of the game",
        image: const AssetImage('assets/images/four_sword.png'),
        backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        background: LottieBuilder.asset('assets/animation/bg_4.json')),
    ItemCardData(
        title: "¿How to get?",
        subtitle: "You need the 4 elements and take them to the sanctuary",
        image: const AssetImage('assets/images/sanctuary.webp'),
        backgroundColor: Colors.white,
        titleColor: Colors.blueAccent,
        subtitleColor: Colors.black,
        background: LottieBuilder.asset('assets/animation/bg_4.json')),
    ItemCardData(
        title: "With this sword you can defeat Vaati",
        subtitle: "Vaati is weak against this sword",
        image: const AssetImage('assets/images/link.jpg'),
        backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
        titleColor: Colors.yellow,
        subtitleColor: Colors.white,
        background: LottieBuilder.asset('assets/animation/bg_4.json'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return ItemCard(data: data[index]);
        },
      ),
    );
  }
}
