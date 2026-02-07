import 'package:dice_switcher/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

final randomizer = Random();

class DiceGacha extends StatefulWidget {
  const DiceGacha({super.key});

  @override
  State<DiceGacha> createState() {
    return _DiceGachaState();
  }
}

class _DiceGachaState extends State<DiceGacha> with SingleTickerProviderStateMixin {
  var activeDiceShown = 'assets/images/dice-1.svg';
  String activeMessage = 'Congratulations, you\'ve rolled a 1!';
  late AnimationController _controller;
  late Animation<double> _animation;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 1.0,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  void gacha() {
    var diceGacha = randomizer.nextInt(6) + 1;
    setState(() {
      activeDiceShown = 'assets/images/dice-$diceGacha.svg';
      activeMessage = 'Congratulations, you\'ve rolled a $diceGacha!';
    });
    _controller.forward(from: 0.0);
    sfxPlayer();
  }

  void sfxPlayer() async {
    await _player.play(AssetSource('sfx/dice-sfx.mp3'));
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StyledText(
          activeMessage,
        ),
        RotationTransition(
          turns: _animation,
          child: ScaleTransition(
            scale: _animation,
            child: SvgPicture.asset(
              activeDiceShown,
              width: 200,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: gacha,
          style: ElevatedButton.styleFrom(
            elevation: 8,
            shadowColor: Colors.black.withValues(alpha: 0.2),
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 60,
              right: 60,
            ),
            backgroundColor: const Color(0xFFFFFFFF),
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Gacha'),
        ),
      ],
    );
  }
}
