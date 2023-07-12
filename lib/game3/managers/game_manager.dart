// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:madground/socket/SocketSystem.dart';

import '../doodle_dash.dart';

// It won't be a detailed section of the codelab, as its not Flame specific
class GameManager extends Component with HasGameRef<DoodleDash> {
  GameManager();

  Character character = Character.dash;
  ValueNotifier<int> score = ValueNotifier(0);
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void initUserList(List<String> userList, List<String> userNameList){
    this.score.value = userList.length;
  }

  void userGameOver(String userId, int rank){
    if("my_user_id" == userId){
      // gameOver
      
    }else{
      setScore(rank-1);
    }
  }

  void myGameOver(){
    SocketSystem.emitMessage("game3_gameOver", "");
  }

  void reset() {
    score.value = 0;
    state = GameState.intro;
  }
  void setScore(int score){
    this.score.value = score;
  }

  void increaseScore() {
    //score.value++;
  }
}

enum GameState { intro, playing, gameOver }
