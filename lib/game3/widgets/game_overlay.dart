// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../doodle_dash.dart';
import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: ScoreDisplay(game: widget.game),
          ),
          if (isMobile)
            Positioned(
              bottom: MediaQuery.of(context).size.height / 8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.jump();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_upward, size: 64),
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.moveRight();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_right, size: 64),
                        ),
                      ),
                    ),*/
                ),
              ),
            ),
          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
