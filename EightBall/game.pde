FWorld world;
float holesize = 25;
float ballsize = 20;
float sticktheta = HALF_PI;
float stickv = 0.005;
float stickpower = 0;
boolean powermode = true;
boolean showstick = true;
int[] disappearframe = new int[15];
boolean[] ontable = new boolean[15];
boolean switchplayer = false;
boolean ball8hitin = false;
boolean hitin = false;
String winreason = "";
ArrayList<Integer> hitinthisturn = new ArrayList<>();
int otherplayer = 0;
boolean whiteballdraggable = false;
void game() {
  
  if (player ==1) {
    otherplayer = 2;
  }
  if (player ==2) {
    otherplayer = 1;
  }
  textAlign(CENTER, CENTER);
  if (player == 1) {
    background(#FF6961);
  } else {
    background(#AEC6FF);
  }
  if (whiteballdraggable) {
    whiteball.setGrabbable(true);
  } else {
    whiteball.setGrabbable(false);
  }




  drawinnerFrame();

  world.step();
  world.draw();

  fill(0);
  textSize(32);
  text("Player " + player, width/2, 25);



  if (checkHole(whiteball.getX(), whiteball.getY())) {
    whiteball.setPosition(width/2, height/2+200);
    whiteball.setVelocity(0, 0);
    switchplayer = true;
    whiteballdraggable = true;
  }
  for (int i = 0; i < 15; i++) {
    if (checkHole(balls[i].getX(), balls[i].getY())) {
      balls[i].setVelocity(0, 0);
      disappearframe[i]++;
    }
  }
  for (int i = 0; i < 15; i++) {
    if (disappearframe[i] > 0 && balls[i].getSize() > 1) {
      disappearframe[i]++;
      balls[i].setSize(balls[i].getSize()-1);
    }
    if (balls[i].getSize() < 2) {
      balls[i].setPosition(-1000, -1000);
      balls[i].setSize(100);
      disappearframe[i] = 0;
      ontable[i] = false;
      hitin = true;
      hitinthisturn.add(i);
    }
  }
  //p1 is red p2 is blue




  if (stickpower >= 150) {
    powermode = false;
  }
  if (stickpower <= 1) {
    powermode = true;
  }


  if (allballStop()) {
    showstick = true;
  } else {
    showstick = false;
  }
  if (showstick) {
    if (lkey || rkey) {
      sticktheta += stickv;
      
    } else {
      stickv = 0;
    }
    if (lkey) {
      stickv += -0.001;
    }
    if (rkey) {
      stickv += 0.001;
    }
    if (ukey) {
      if (powermode) {
        stickpower+=0.5;
      } else {
        stickpower-=0.5;
      }
    } else {
      if (stickpower >= 0) {
        whiteball.addImpulse(-0.5*cos(sticktheta)*pow(stickpower, 1.5), -0.5*sin(sticktheta)*pow(stickpower, 1.5));
        stickpower = 0;
        pushMatrix();
        translate(whiteball.getX(), whiteball.getY());
        rotate(sticktheta);
        fill(#761F1F);
        rect(15, -5, 200, 10);
        popMatrix();
        
      }
    }
    
  }

  if (showstick) {
    //stick visual
    pushMatrix();
    translate(whiteball.getX(), whiteball.getY());
    rotate(sticktheta);
    fill(#761F1F);
    rect(stickpower + 15, -5, 200, 10);
    fill(200, 50);
    rect(- 15, -2, -2000, 4);
    popMatrix();
  }
  
  showballnum();
}
void showballnum() {
  float[] ballrot = new float[15];
  PVector[] ballpos = new PVector[15];
  for (int i = 0; i < 15; i++) {
    ballrot[i] = balls[i].getRotation();
    ballpos[i] = new PVector(balls[i].getX(), balls[i].getY());
  }
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(ballpos[i].x, ballpos[i].y);
    rotate(ballrot[i]);
    if (i != 7) {
      fill(0);
    } else {
      fill(255);
    }
    textSize(8);
    text(i+1, -2, 0);
    popMatrix();
  }
}
boolean ball8(int player) {
  if (player == 1) {
    for (int i = 0; i < 7; i++) {
      if (ontable[i]) {
        return false;
      }
    }
  } else {
    for (int i = 8; i < 15; i++) {
      if (ontable[i]) {
        return false;
      }
    }
  }
  return true;
}


//700 1000
FCircle[] balls = new FCircle[15];
/*
0-6 solid
 7 is eightball
 8-14 stripe
 */
boolean allballStop() {
  if (player == 1) {
    for (int k : hitinthisturn) {
      if (k > 7) {
        switchplayer = true;
      } else if (k == 7) {
        if (ball8(player)) {
          winner = player;
          mode = 2;
          winreason = "8Ball hit in";
        } else {
          winner = otherplayer;
          mode = 2;
          winreason = "8Ball hit in too early";
        }
      }
    }
  } else {
    for (int k : hitinthisturn) {
      if (k < 7) {
        switchplayer = true;
      } else if (k == 7) {
        if (ball8(player)) {
          winner = player;
          mode = 2;
          winreason = "8Ball hit in";
        } else {
          winner = otherplayer;
          mode = 2;
          winreason = "8Ball hit in too early";
        }
      }
    }
  }

  for (int i = 0; i < 15; i++) {
    if (abs(balls[i].getVelocityX()) + abs(balls[i].getVelocityY()) > 0.01) {
      return false;
    }
  }
  if (abs(whiteball.getVelocityX()) + abs(whiteball.getVelocityY()) > 0.01) {
    return false;
  }
  if (!showstick) {
    hitinthisturn.clear();
    if (!hitin) {
      switchplayer = true;
    }
    hitin = false;
    if (switchplayer) {
      player = otherplayer;
      switchplayer = false;
    }
  }
  
  hitin = false;
  hitinthisturn.clear();
  return true;
}

void createBalls() {
  PVector[] arrangement = new PVector[15];
  int k = 0;
  for (int i = 0; i < 5; i++) {
    for (int j = i; j > -1; j--) {
      arrangement[k] = new PVector(width/2 + (j-i/2.0)*20 + random(-0.1, 0.1), height/2 - 200 - i*17.321+ random(-0.1, 0.1));

      k++;
    }
  }

  for (int i = 0; i < 15; i ++) {
    balls[i] = new FCircle(ballsize);
  }
  for (int i = 0; i < 7; i++) {
    balls[i].setFillColor(#FF6961);
  }
  for (int i = 8; i < 15; i++) {
    balls[i].setFillColor(#AEC6FF);
  }
  balls[7].setFillColor(#282828);
  int bba = 4;
  balls[7].setPosition(arrangement[bba].x, arrangement[bba].y);
  HashSet<Integer> set = new HashSet<>();
  set.add(bba);
  for (int i = 0; i < 15; i++) {
    if (i == 7) {
      i++;
    }
    int rand = (int)random(0, 15);
    while (!set.add(rand)) {
      rand = (int)random(0, 15);
    }
    balls[i].setPosition(arrangement[rand].x, arrangement[rand].y);
  }

  for (int i = 0; i < 15; i++) {
    balls[i].setRotation(random(0,2*PI));
    balls[i].setGrabbable(true);
    balls[i].setRestitution(0.8);
    world.add(balls[i]);
  }
}
FCircle whiteball;
void createWhiteBall() {
  whiteball = new FCircle(ballsize);
  whiteball.setPosition(width/2, height/2+200);
  whiteball.setGrabbable(false);
  whiteball.setRestitution(0.8);
  world.add(whiteball);
}
void createFrame() {

  frametop = new FPoly();
  framebot = new FPoly();
  framelefttop = new FPoly();
  frameleftbot = new FPoly();
  framerighttop = new FPoly();
  framerightbot = new FPoly();

  frametop.setStatic(true);
  framebot.setStatic(true);
  framelefttop.setStatic(true);
  frameleftbot.setStatic(true);
  framerighttop.setStatic(true);
  framerightbot.setStatic(true);

  frametop.setFillColor(#A06322);
  framebot.setFillColor(#A06322);
  framelefttop.setFillColor(#A06322);
  frameleftbot.setFillColor(#A06322);
  framerighttop.setFillColor(#A06322);
  framerightbot.setFillColor(#A06322);

  frametop.setGrabbable(false);
  framebot.setGrabbable(false);
  framelefttop.setGrabbable(false);
  frameleftbot.setGrabbable(false);
  framerighttop.setGrabbable(false);
  framerightbot.setGrabbable(false);

  frametop.setNoStroke();
  framebot.setNoStroke();
  framelefttop.setNoStroke();
  frameleftbot.setNoStroke();
  framerighttop.setNoStroke();
  framerightbot.setNoStroke();

  frametop.vertex(125 + holesize, 75);
  frametop.vertex(150 + holesize, 100);
  frametop.vertex(550 - holesize, 100);
  frametop.vertex(575 - holesize, 75);

  framebot.vertex(125 + holesize, 925);
  framebot.vertex(150 + holesize, 900);
  framebot.vertex(550 - holesize, 900);
  framebot.vertex(575 - holesize, 925);

  framerighttop.vertex(125, 75 + holesize);
  framerighttop.vertex(150, 100 + holesize);
  framerighttop.vertex(150, 485 - holesize/3);
  framerighttop.vertex(125, 495 - holesize/3);

  framelefttop.vertex(550, 100 + holesize);
  framelefttop.vertex(575, 75 + holesize);
  framelefttop.vertex(575, 495 - holesize/3);
  framelefttop.vertex(550, 485 - holesize/3);

  framerightbot.vertex(550, 515 + holesize/3);
  framerightbot.vertex(575, 505 + holesize/3);
  framerightbot.vertex(575, 925 - holesize);
  framerightbot.vertex(550, 900 - holesize);

  frameleftbot.vertex(125, 505 + holesize/3);
  frameleftbot.vertex(150, 515 + holesize/3);
  frameleftbot.vertex(150, 900 - holesize);
  frameleftbot.vertex(125, 925 - holesize);



  world.add(frametop);
  world.add(framebot);
  world.add(framelefttop);
  world.add(frameleftbot);
  world.add(framerighttop);
  world.add(framerightbot);
}

void drawinnerFrame() {
  fill(#A06322);
  strokeWeight(4);
  rect(105, 55, 490, 890);



  strokeWeight(4);
  fill(#F0AA5E);
  rect(125, 75, 450, 850);

  fill(0);
  //circles
  circle(145, 95, 20);
  circle(555, 95, 20);
  circle(135, 500, 20);
  circle(565, 500, 20);
  circle(555, 905, 20);
  circle(145, 905, 20);
}
boolean checkHole(float x, float y) {
  PVector pos = new PVector(x, y);
  PVector c1 = new PVector(145, 95);
  PVector c2 = new PVector(555, 95);
  PVector c3 = new PVector(135, 500);
  PVector c4 = new PVector(565, 500);
  PVector c5 = new PVector(145, 905);
  PVector c6 = new PVector(555, 905);
  if ((PVector.dist(pos, c1) < ballsize/2 + 10) || (PVector.dist(pos, c2) < ballsize/2 + 10) ||
    (PVector.dist(pos, c3) < ballsize/2 + 10) || (PVector.dist(pos, c4) < ballsize/2 + 10) ||
    (PVector.dist(pos, c5) < ballsize/2 + 10) || (PVector.dist(pos, c6) < ballsize/2 + 10)) {
    return true;
  }
  return false;
}

boolean rkey, lkey, ukey;
void gameK() {
  if (keyCode == RIGHT || (key == 'd' || key == 'D')) {
    rkey = true;
  }
  if (keyCode == LEFT || (key == 'a' || key == 'A')) {
    lkey = true;
  }
  if (keyCode == UP || (key == 'w' || key == 'W')) {
    ukey = true;
  }
}
void gameR() {
  if (keyCode == RIGHT || (key == 'd' || key == 'D')) {
    rkey = false;
  }
  if (keyCode == LEFT || (key == 'a' || key == 'A')) {
    lkey = false;
  }
  if (keyCode == UP || (key == 'w' || key == 'W')) {
    ukey = false;
  }
}
