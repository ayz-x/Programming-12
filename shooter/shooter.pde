import fisica.*;
int nummaps = 15;
boolean gameStart = false;
FWorld[] world = new FWorld[nummaps];
Map[] maps = new Map[nummaps];
boolean zoomout = false;
float hp = 100;
PVector[] playerstart = new PVector[nummaps];
PVector[] mapdimensions = new PVector[nummaps];
int gridSize = 32;
int currmap = 0;
int playerSizeX = 24;
int playerSizeY = 24;
float freq;
boolean tips = false;
boolean showhitbox = false;
boolean slowtime = false;
int timeframe = 0;
int frametime;
boolean debug = false;
boolean draw = true;
boolean cheatmode = false;
String[] tip = new String[nummaps];
void setup() {
  frameRate(144);
  //min 12, 12
  generateEmpty(41, 41, false);
  freq = 1/frameRate;
  loadTextures(currmap);


  noStroke();
  rectMode(CENTER);

  textAlign(CENTER, CENTER);
  size(768, 768);

  Fisica.init(this);
  playerstart[0] = new PVector(2, 2);
  mapdimensions[0] = new PVector(20, 12);
  tip[0] = "A to move left, D to move right.";
  playerstart[1] = new PVector(2, 2);
  mapdimensions[1] = new PVector(20, 12);
  tip[1] = "W to jump, double jump is enabled.";
  playerstart[2] = new PVector(2, 2);
  mapdimensions[2] = new PVector(20, 12);
  tip[2] = "Spikes hurt you.";
  playerstart[3] = new PVector(2, 2);
  mapdimensions[3] = new PVector(30, 12);
  tip[3] = "Press R to reset.";
  playerstart[4] = new PVector(2, 2);
  mapdimensions[4] = new PVector(20, 12);
  tip[4] = "Beware of enemies. They cannot double jump.";
  playerstart[5] = new PVector(5.5, 2);
  mapdimensions[5] = new PVector(12, 40);
  tip[5] = "They have a detection range before they can get to you.";
  playerstart[6] = new PVector(2, 2);
  mapdimensions[6] = new PVector(20, 12);
  tip[6] = "The gun will aim at your cursor. Press 1 to switch to this gun.";
  playerstart[7] = new PVector(2, 2);
  mapdimensions[7] = new PVector(30, 12);
  tip[7] = "There are a lot of bouncing mechanics in this game.";
  playerstart[8] = new PVector(2, 2);
  mapdimensions[8] = new PVector(20, 12);
  tip[8] = "The gun can also break gray tiles.";
  playerstart[9] = new PVector(1, 2);
  mapdimensions[9] = new PVector(20, 12);
  tip[9] = "Who am I? And why am I giving you tips?";
  playerstart[10] = new PVector(2, 2);
  mapdimensions[10] = new PVector(20, 12);
  tip[10] = "Phantasms can fly and phase through walls.";
  playerstart[11] = new PVector(2, 2);
  mapdimensions[11] = new PVector(20, 12);
  tip[11] = " Run. ";
  playerstart[12] = new PVector(2, 2);
  mapdimensions[12] = new PVector(20, 12);
  tip[12] = "In here, it's kill or be killed.";
  playerstart[13] = new PVector(1, 3);
  mapdimensions[13] = new PVector(20, 12);
  tip[13] = "Die a hero, or live to become the villain.";
  playerstart[14] = new PVector(5.5, 2);
  mapdimensions[14] = new PVector(12, 40);
  tip[14] = "You have passed... For now.";

  for (int i = 0; i < nummaps; i++) {
    world[i] = new FWorld(-2000, -2000, 2000, 2000);
    world[i].setGravity(0, 900);
    maps[i] = new Map("maps/map" + i + ".txt", i);
  }
  maps[0].addtoWorld(0);
  currmap = 0;

  createPlayer();
}
//param: w>3, h>3
void generateEmpty(int w, int h, boolean t) {
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      if (i == 0 || i == h-1) {
        print("01 ");
      } else if (j == 0 || j == w-1) {
        print("01 ");
      } else {
        print("00 ");
      }
    }
    println();
  }
  if (t) {
    System.exit(-1);
  }
}


ArrayList<FBox> boxes = new ArrayList<>();

void changemap(int a) {
  currmap = a;
  loadTextures(currmap);
}

FPlayer player;
void createPlayer() {
  player = new FPlayer();
  player.setStatic(false);
  player.setName("player");
  player.setRotatable(false);
  player.setPosition(playerstart[currmap].x*gridSize, playerstart[currmap].y*gridSize);
  world[currmap].add(player);
}
void draw() {
  
  if (gameStart) {
    game();

    if (tips) {

      textSize(16);
      fill(#FFFFFF);
      strokeWeight(4);
      stroke(0);
      rect(width/2, height/2 + 350, tip[currmap].length()*8, 50);
      noStroke();
      fill(0);
      text(tip[currmap], width/2, height/2 + 350);
    }
  } else {
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("Shooter", width/2, height/2);
    textSize(16);
    text("Press any key to start", width/2, height/2 + 200);
    text("Press t for tips", width/2, height/2 + 350);
  }
  if (end){
    gameStart = false;
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("Thanks for playing!", width/2, height/2);
    textSize(16);
    text("You have braved the dungeons...", width/2, height/2 + 200);
    text("But this is not the end.", width/2, height/2 + 350);
  }
}

void game() {
  background(255);
  if (slowtime) {
    frameRate(16);
  } else {
    frameRate(72);
  }
  player.updateSprite();
  playerdeath();
  player.updatePlayerPos();
  player.checkTouching();

  enemiesact();
  drawWorld();
}
void drawWorld() {
  //-((player.getX() + width/2)/2);
  //-((player.getY() + height/2)/2);
  float offx = (mapdimensions[currmap].x)/2 - 6;
  float offy = (mapdimensions[currmap].y)/2 - 6;
  float x = player.getX()/32;
  float y = player.getY()/32;
  float tx;
  float ty;
  if (x < 5.5) {
    tx = 5.5;
    screenx = (x+0.5)*64;
  } else if (x > mapdimensions[currmap].x - 6.5) {
    tx = mapdimensions[currmap].x - 6.5;
    screenx = width/2 + ( x - mapdimensions[currmap].x + 6.5)*64;
  } else {
    tx = x;
    screenx = width/2;
  }
  if (y < 5.5) {
    ty = 5.5;
    screeny = (y+0.5)*64;
  } else if (y > mapdimensions[currmap].y - 6.5) {
    ty = mapdimensions[currmap].y - 6.5;
    screeny = height/2 + ( y - mapdimensions[currmap].y + 6.5)*64;
  } else {
    ty = y;
    screeny = height/2;
  }
  
 

  //println(tx*32 + " " + ty*32 + " " + player.getX() + " " + player.getY());
  //println(mouseX + " " + mouseY);
  //println(screenx + " " + screeny);
  //println();
  
  tx = (((mapdimensions[currmap].x)/2) - tx - offx)*32;
  ty = (((mapdimensions[currmap].y)/2) - ty - offy)*32;

  pushMatrix();
  if (!zoomout) {




    scale(2);
    translate(tx, ty);
  } else {
    scale(0.75);
    translate(16, 16);
  }
  if (draw) {
    world[currmap].step();
  }
  if (debug) {
    world[currmap].drawDebug();
  } else {
    world[currmap].draw();
  }
  popMatrix();
}

void keyPressed() {
  if (gameStart) {
    playerinputs();
  } else {
    gameStart = true;
  }
}
void keyReleased() {
  if (gameStart) {
    negplayerinputs();
  }
}
void keyTyped() {
  if (gameStart) {
    jump();
    if (key == 'y' || key == 'Y'){
      guns = 999;
    }
    
    if (key == 'u' || key == 'U') {
      next = true;
      if(currmap + 1 < nummaps){
      loadNextMap(currmap);
      }
    }

    if (key == 't' || key == 'T') {
      tips = tips ^ true;
    }
    if (key == 'r' || key == 'R') {
      die = true;
    }
    if (key == 'l' || key == 'L') {
      showhitbox = showhitbox ^ true;
    }
    if (key == 'o' || key == 'O') {
      slowtime = slowtime ^ true;
    }
    if (key == 'p' || key == 'P') {
      zoomout = zoomout ^ true;
    }
    if (key == 'k' || key == 'K') {
      debug = debug ^ true;
    }
    if (key == ',') {
      draw = draw ^ true;
    }
    if (key == 'm') {
      cheatmode = cheatmode ^ true;
    }
    if (draw == true && key == '.') {
      world[currmap].step();
    }
  }
}
