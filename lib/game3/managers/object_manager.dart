// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/components.dart';

import './managers.dart';
import '../doodle_dash.dart';
import '../sprites/sprites.dart';
import '../util/util.dart';

final Random _rand = Random();

class ObjectManager extends Component with HasGameRef<DoodleDash> {
  ObjectManager({
    this.minHorizontalDistanceToNextPlatform = 200,
    this.maxHorizontalDistanceToNextPlatform = 300,
  });

  static double platformSpeed = 200.0;

  double minHorizontalDistanceToNextPlatform;
  double maxHorizontalDistanceToNextPlatform;
  final probGen = ProbabilityGenerator();
  final double _tallestPlatformHeight = 50;
  final List<Platform> _platforms = [];

  @override
  void onMount() {
    super.onMount();

    var currentX = (gameRef.size.x.floor() / 2).toDouble() - 50;

    var currentY =
        gameRef.size.y - (_rand.nextInt(gameRef.size.y.floor()) / 3) - 50;

    for (var i = 0; i < 9; i++) {
      if (i != 0) {
        currentX = _generateNextX(100);
        currentY = _generateNextY();
      }
      _platforms.add(
        _semiRandomPlatform(
          Vector2(
            currentX,
            currentY,
          ),
        ),
      );

      add(_platforms[i]);
    }
  }

  @override
  void update(double dt) {
    if(gameRef.gameManager.isGameOver)  return;
    platformSpeed += dt*5;
    //print(platformSpeed);
    final rightOfLeftmostPlatform =
        _platforms.first.position.x + _platforms.first.size.x;

    final screenLeft = 0;/*gameRef.player.position.x +
        (gameRef.size.x / 2) +
        gameRef.screenBufferSpace;*/

    if (rightOfLeftmostPlatform < screenLeft) {
      // TEST
      print("add platform");
      // TEST
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX(100);
      final nextPlat = _semiRandomPlatform(Vector2(newPlatX, newPlatY));
      add(nextPlat);
      _platforms.add(nextPlat);
      gameRef.gameManager.increaseScore();

      _cleanupPlatforms();
    }

    super.update(dt);
  }


  void _cleanupPlatforms() {
    final lowestPlat = _platforms.removeAt(0);

    lowestPlat.removeFromParent();
  }


  double _generateNextX(int platformWidth) {
    final previousPlatformXRange = Range(
      _platforms.last.position.x,
      _platforms.last.position.x + platformWidth,
    );

    final currentRightmostPlatformX = _platforms.last.position.x + platformWidth;

    final distanceToNextX = minHorizontalDistanceToNextPlatform.toInt() +
        _rand
            .nextInt((maxHorizontalDistanceToNextPlatform -
                    minHorizontalDistanceToNextPlatform)
                .floor())
            .toDouble();

    /*do {
      nextPlatformAnchorX =
          _rand.nextInt(gameRef.size.x.floor() - platformWidth).toDouble();
    } while (previousPlatformXRange.overlaps(
        Range(nextPlatformAnchorX, nextPlatformAnchorX + platformWidth)));
        */

    return currentRightmostPlatformX + distanceToNextX;
  }

  double _generateNextY() {
    final newPlatformY = _rand.nextInt(gameRef.size.y.floor() - 100).toDouble();
    return newPlatformY;
  }

  Platform _semiRandomPlatform(Vector2 position) {

    return NormalPlatform(position: position);
  }
}
