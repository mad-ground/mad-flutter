// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../doodle_dash.dart';
import 'sprites.dart';

enum PlayerState {
  right,
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<DoodleDash>, KeyboardHandler, CollisionCallbacks {
  Player({
    super.position,
    required this.character,
    this.jumpSpeed = 400,
  }) : super(
          size: Vector2(79, 109),
          anchor: Anchor.center,
          priority: 1,
        );

  int _hAxisInput = 0;
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 _velocity = Vector2.zero();
  bool get isMovingDown => _velocity.y > 0;
  Character character;
  double jumpSpeed;
  final double _gravity = 9;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox(radius : size.y));

    await _loadCharacterSprites();
    current = PlayerState.right;
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;

    _velocity.x = _hAxisInput * jumpSpeed;

    final double dashHorizontalCenter = size.x / 2;

    if (position.x < dashHorizontalCenter) {
      position.x = gameRef.size.x - (dashHorizontalCenter);
    }
    if (position.x > gameRef.size.x - (dashHorizontalCenter)) {
      position.x = dashHorizontalCenter;
    }

    _velocity.y += _gravity;

    position += _velocity * dt;

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    /*if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }*/

    // During development, its useful to "cheat"
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      jump();
    }

    return true;
  }


  void resetDirection() {
    _hAxisInput = 0;
  }
  

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    bool isNormalPlatform = false;

    if (other is NormalPlatform) {
      isNormalPlatform = true;
    }
    for(int i=0; i<intersectionPoints.length; i++){
      print(intersectionPoints.elementAt(i));
      print(position);
      if(intersectionPoints.elementAt(i).distanceTo(position+Vector2(size.x/2*0.2, size.y/2*0.4)) < size.y/2.2){
        if(isNormalPlatform){
          print("FINISHED");
          gameRef.onLose();
        }
      }
    } 


    
    /*bool isCollidingVertically =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    if (isMovingDown && isCollidingVertically) {
      //current = PlayerState.center;
      switch (other) {
        case NormalPlatform():
          ////jump();
          return;
        case SpringBoard():
          jump(specialJumpSpeed: jumpSpeed * 2);
          return;
        case BrokenPlatform() when other.current == BrokenPlatformState.cracked:
          jump();
          other.breakPlatform();
          return;
      }
    }
    */
  }

  void jump({double? specialJumpSpeed}) {
    //print(jumpSpeed);
    _velocity.y = specialJumpSpeed != null ? -specialJumpSpeed : -jumpSpeed;
  }


  void setJumpSpeed(double newJumpSpeed) {
    jumpSpeed = newJumpSpeed;
  }

  void reset() {
    _velocity = Vector2.zero();
    current = PlayerState.right;
  }

  void resetPosition() {
    position = Vector2(
      (gameRef.size.x - size.x) / 4,
      (gameRef.size.y - size.y) / 2,
    );
  }

  Future<void> _loadCharacterSprites() async {
    // Load & configure sprite assets
    final right = await gameRef.loadSprite('game/${character.name}_right.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.right: right,
    };
  }
}
